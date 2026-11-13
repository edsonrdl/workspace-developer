<#
  DocSearch.ps1 - busca local em docs .md SEM embeddings, SEM API, SEM servidor.
  - Indexa por SECAO (## heading), nao por arquivo -> acha a resposta mesmo no fim do doc.
  - "Contexto" do frontmatter (titulo, resumo, aliases, perguntas) e anexado a cada secao.
  - Glossario de sinonimos (glossario.txt) expande a consulta ("teto" -> "limite maximo").
  - Ranking BM25. Saida curta: secao + caminho -> o agente le so o necessario.

  Uso CLI:  powershell -File DocSearch.ps1 -Query "teto de requisicoes por parceiro" -Root ..\corpus -Top 3
  Uso lib:  . .\DocSearch.ps1   (dot-source; nao executa nada sem -Query)
#>
param(
  [string]$Query,
  [string]$Root = (Join-Path $PSScriptRoot '..\corpus'),
  [string]$Glossary,
  [int]$Top = 3
)

$script:Stop = @{}
foreach ($w in ('a o as os um uma uns umas de do da dos das em no na nos nas por para com sem que e ou se ao aos ate como qual quais quem quando onde ha ser sao foi tem ter mais mas ja seu sua seus suas eu me meu minha isso isto esta este esse essa').Split(' ')) { $script:Stop[$w] = $true }

function ConvertTo-Norm([string]$s) {
  $d = $s.ToLowerInvariant().Normalize([Text.NormalizationForm]::FormD)
  $d = [regex]::Replace($d, '\p{Mn}', '')
  return ([regex]::Replace($d, '[^a-z0-9]+', ' ')).Trim()
}

function Get-Stems([string]$s) {
  $out = New-Object 'System.Collections.Generic.List[string]'
  foreach ($t in (ConvertTo-Norm $s).Split(' ')) {
    if ($t.Length -lt 2 -or $script:Stop.ContainsKey($t)) { continue }
    if ($t.Length -gt 6) { $t = $t.Substring(0, 6) }
    $out.Add($t)
  }
  return ,$out
}

function Get-StemKey([string]$s) { return ' ' + ((Get-Stems $s) -join ' ') + ' ' }

function Read-Doc([string]$path) {
  $raw = [IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
  $meta = @{}; $body = $raw
  if ($raw -match '(?s)^---\r?\n(.*?)\r?\n---\r?\n(.*)$') {
    $fm = $Matches[1]; $body = $Matches[2]
    foreach ($l in ($fm -split '\r?\n')) { if ($l -match '^([a-z_]+):\s*(.*)$') { $meta[$Matches[1]] = $Matches[2].Trim() } }
  }
  $title = $meta['title']
  if (-not $title -and $body -match '(?m)^# (.+)$') { $title = $Matches[1].Trim() }
  $rel = $path
  [pscustomobject]@{ Id = [IO.Path]::GetFileNameWithoutExtension($path); Path = $rel; Meta = $meta; Title = $title; Body = $body }
}

function Read-Corpus([string]$root) {
  $list = New-Object 'System.Collections.Generic.List[object]'
  foreach ($f in (Get-ChildItem -Path $root -Recurse -Filter *.md | Where-Object { $_.Name -notmatch '^(_|INDEX\.md|lacunas)' } | Sort-Object FullName)) { $list.Add((Read-Doc $f.FullName)) }
  return ,$list
}

# Glossario: hashtable canonico -> lista de aliases  =>  entradas { AliasKey, Canon }
function New-GlossaryEntries($table) {
  $entries = New-Object 'System.Collections.Generic.List[object]'
  foreach ($canon in $table.Keys) {
    $cs = Get-Stems $canon
    foreach ($a in $table[$canon]) { $entries.Add([pscustomobject]@{ AliasKey = (Get-StemKey $a); Canon = $cs }) }
  }
  return ,$entries
}

function Read-GlossaryFile([string]$path) {
  $t = @{}
  foreach ($l in [IO.File]::ReadAllLines($path, [Text.Encoding]::UTF8)) {
    if ($l -match '^\s*([^#=][^=]*)=(.+)$') { $t[$Matches[1].Trim()] = @($Matches[2].Split('|') | ForEach-Object { $_.Trim() } | Where-Object { $_ }) }
  }
  return (New-GlossaryEntries $t)
}

# $mode: 'chunk' (uma entrada por secao) ou 'doc' (uma entrada por arquivo); $context: anexa frontmatter
function Build-Index($docs, [string]$mode = 'chunk', [bool]$context = $true) {
  $chunks = New-Object 'System.Collections.Generic.List[object]'
  foreach ($d in $docs) {
    $ctx = @{}
    # A secao "## For future agent" (2-3 frases: do que o doc trata e quando serve) entra como CONTEXTO do doc,
    # nunca como secao candidata a ser exibida (senao ela ganharia do trecho com a resposta).
    $ffa = ''
    if ($d.Body -match '(?ms)^## For future agent\s*\r?\n(.*?)(?=^## |\z)') { $ffa = $Matches[1] }
    if ($context) { $ctx = @{ t = $d.Title; r = $d.Meta['resumo']; a = $d.Meta['aliases']; p = $d.Meta['perguntas']; f = $ffa } }
    if ($mode -eq 'doc') { $parts = @($d.Body) } else { $parts = [regex]::Split($d.Body, '(?m)^(?=## )') }
    foreach ($p in $parts) {
      if (-not $p.Trim()) { continue }
      if ($mode -eq 'chunk' -and $p -match '^## For future agent') { continue }
      if ($mode -eq 'chunk' -and $p -notmatch '^## ' -and $p.Trim().Length -lt 160) { continue }   # preambulo so com o titulo (ja entra como contexto)
      $head = ($p -split '\r?\n')[0].TrimStart('# ').Trim()
      $tf = @{}; $tfb = @{}
      $script:len = 0.0; $script:lenb = 0.0
      $addb = {   # corpo + heading (usado para escolher QUAL secao mostrar)
        param($text, $w)
        foreach ($s in (Get-Stems $text)) {
          if ($tf.ContainsKey($s)) { $tf[$s] += $w } else { $tf[$s] = [double]$w }
          if ($tfb.ContainsKey($s)) { $tfb[$s] += $w } else { $tfb[$s] = [double]$w }
          $script:len += $w; $script:lenb += $w
        }
      }
      $addc = {   # contexto do frontmatter (usado para decidir QUAL doc)
        param($text, $w)
        foreach ($s in (Get-Stems $text)) { if ($tf.ContainsKey($s)) { $tf[$s] += $w } else { $tf[$s] = [double]$w }; $script:len += $w }
      }
      & $addb $p 1
      & $addb $head 2
      if ($context) { & $addc $ctx.t 3; & $addc $ctx.r 2; & $addc $ctx.a 2; & $addc $ctx.p 2; & $addc $ctx.f 2 }
      else { & $addc $d.Title 3 }
      $chunks.Add([pscustomobject]@{ DocId = $d.Id; Path = $d.Path; Heading = $head; Text = $p; Tf = $tf; Len = $script:len; TfB = $tfb; LenB = $script:lenb })
    }
  }
  $df = @{}; $tot = 0.0
  foreach ($c in $chunks) { $tot += $c.Len; foreach ($k in $c.Tf.Keys) { if ($df.ContainsKey($k)) { $df[$k]++ } else { $df[$k] = 1 } } }
  [pscustomobject]@{ Chunks = $chunks; Df = $df; N = $chunks.Count; AvgLen = $tot / [math]::Max(1, $chunks.Count) }
}

function Expand-Query([string]$q, $gloss) {
  $qs = New-Object 'System.Collections.Generic.List[string]'
  foreach ($s in (Get-Stems $q)) { if (-not $qs.Contains($s)) { $qs.Add($s) } }
  if ($gloss) {
    $key = ' ' + ($qs -join ' ') + ' '
    # alias casado contra a consulta original (sem stopwords); adiciona o termo canonico
    $orig = Get-StemKey $q
    foreach ($e in $gloss) {
      if ($orig.Contains($e.AliasKey)) { foreach ($s in $e.Canon) { if (-not $qs.Contains($s)) { $qs.Add($s) } } }
    }
  }
  return ,$qs
}

# Retorna chunks rankeados (1 por doc, o melhor), com score BM25
function Search-Index($idx, [string]$q, $gloss = $null, [int]$top = 3) {
  $terms = Expand-Query $q $gloss
  $k1 = 1.2; $k1b = 0.3; $b = 0.75
  $best = @{}   # por doc: score = melhor chunk (com contexto); secao exibida = chunk com maior match no corpo
  foreach ($c in $idx.Chunks) {
    $score = 0.0; $sb = 0.0
    foreach ($t in $terms) {
      $n = $idx.Df[$t]
      $idf = if ($n) { [math]::Log(1 + ($idx.N - $n + 0.5) / ($n + 0.5)) } else { 0 }
      if ($c.Tf.ContainsKey($t)) { $f = $c.Tf[$t]; $score += $idf * ($f * ($k1 + 1)) / ($f + $k1 * (1 - $b + $b * $c.Len / $idx.AvgLen)) }
      if ($c.TfB.ContainsKey($t)) { $f = $c.TfB[$t]; $sb += $idf * ($f * ($k1b + 1)) / ($f + $k1b * (1 - $b + $b * $c.LenB / $idx.AvgLen)) }   # k1 baixo: cobertura de termos distintos pesa mais que repeticao
    }
    if ($score -le 0) { continue }
    if (-not $best.ContainsKey($c.DocId)) { $best[$c.DocId] = [pscustomobject]@{ DocId = $c.DocId; Path = $c.Path; Heading = $c.Heading; Text = $c.Text; Score = $score; Body = $sb } }
    else {
      $cur = $best[$c.DocId]
      if ($score -gt $cur.Score) { $cur.Score = $score }
      if ($sb -gt $cur.Body) { $cur.Body = $sb; $cur.Heading = $c.Heading; $cur.Text = $c.Text; $cur.Path = $c.Path }
    }
  }
  return @($best.Values | Sort-Object Score -Descending | Select-Object -First $top)
}

if ($Query) {
  $docs = Read-Corpus $Root
  $idx = Build-Index $docs 'chunk' $true
  $gl = $null
  if ($Glossary -and (Test-Path $Glossary)) { $gl = Read-GlossaryFile $Glossary }
  $i = 0
  foreach ($r in (Search-Index $idx $Query $gl $Top)) {
    $i++
    "[{0}] {1}  (score {2:N1})`n    secao: {3}`n    arquivo: {4}" -f $i, $r.DocId, $r.Score, $r.Heading, $r.Path
    $snippet = ($r.Text -split '\r?\n' | Where-Object { $_.Trim() } | Select-Object -Skip 1 -First 3) -join ' '
    "    trecho: " + $snippet.Substring(0, [math]::Min(300, $snippet.Length))
  }
}
