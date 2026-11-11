# Simulacao: varias estrategias de recuperacao competindo, com personas de usuarios.
# SEM embeddings e SEM chamadas de API. O "LLM" que le listas e simulado por um roteador conceitual
# (entende sinonimos) cuja chance de reconhecer a linha certa cai com o tamanho da lista (lost-in-the-middle).
# Esses parametros sao PREMISSAS - veja RELATORIO.md. Ranking relativo importa mais que numeros absolutos.
param([int]$Seed = 7, [int]$Rounds = 1)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\..\src\DocSearch.ps1"
$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object Text.UTF8Encoding $false

# ---------- dados ----------
$topics = foreach ($l in [IO.File]::ReadAllLines("$PSScriptRoot\data\topics.txt", [Text.Encoding]::UTF8)) { if ($l.Trim()) { $p = $l.Split('|'); [pscustomobject]@{ Dom=$p[0]; Id=$p[1]; Tech=$p[2]; Biz=@($p[3],$p[4]); Sym=@($p[5],$p[6]) } } }
$aspects = foreach ($l in [IO.File]::ReadAllLines("$PSScriptRoot\data\aspects.txt", [Text.Encoding]::UTF8)) { if ($l.Trim()) { $p = $l.Split('|'); [pscustomobject]@{ Id=$p[0]; Tech=$p[1]; User=@($p[2],$p[3],$p[4]) } } }
$topicById = @{}; foreach ($t in $topics) { $topicById[$t.Id] = $t }
$aspById = @{}; foreach ($a in $aspects) { $aspById[$a.Id] = $a }
$ttype = @{}; foreach ($l in [IO.File]::ReadAllLines("$PSScriptRoot\sim\truth.tsv")) { $p = $l.Split('|'); $ttype[$p[0]] = $p[1] }
$docs = Read-Corpus "$root\corpus"
$docById = @{}; $docTok = @{}
foreach ($d in $docs) {
  $d | Add-Member Topic $d.Meta['topico']; $d | Add-Member Dom $d.Meta['dominio']
  $d | Add-Member Aspect $d.Id.Substring($d.Topic.Length + 1)
  $d | Add-Member TType $ttype[$d.Id]
  $d | Add-Member TitleKey (Get-StemKey $d.Title)
  $d | Add-Member LineKey (Get-StemKey ($d.Title + ' ' + $d.Meta['resumo']))
  $docById[$d.Id] = $d; $docTok[$d.Id] = [math]::Ceiling($d.Body.Length / 4.0)
}
$corpusTokens = ($docTok.Values | Measure-Object -Sum).Sum

# ---------- lexico conceitual (o "LLM" entende sinonimos) ----------
$topicKeys = @{}; foreach ($t in $topics) { $topicKeys[$t.Id] = @($t.Tech, $t.Biz[0], $t.Biz[1], $t.Sym[0], $t.Sym[1] | ForEach-Object { Get-StemKey $_ }) }
$aspKeys = @{}; foreach ($a in $aspects) { $aspKeys[$a.Id] = @($a.Tech, $a.User[0], $a.User[1], $a.User[2] | ForEach-Object { Get-StemKey $_ }) }
function Line-Score([string]$key, $q) {
  $s = 0
  foreach ($p in $topicKeys[$q.TopicId]) { if ($key.Contains($p)) { $s += 2; break } }
  foreach ($p in $aspKeys[$q.AspectId]) { if ($key.Contains($p)) { $s += 1; break } }
  return $s
}
function P-Recog([int]$n) { if ($n -le 10) { 0.98 } elseif ($n -le 30) { 0.93 } elseif ($n -le 60) { 0.85 } elseif ($n -le 120) { 0.75 } else { 0.6 } }
# $keys: lista de chaves normalizadas; devolve indices ordenados do mais ao menos provavel
function Route($keys, $q, $rng) {
  $p = P-Recog $keys.Count
  $rows = for ($i = 0; $i -lt $keys.Count; $i++) {
    $s = Line-Score $keys[$i] $q
    if ($s -gt 0 -and $rng.NextDouble() -gt $p) { $s = 0 }
    [pscustomobject]@{ I = $i; S = $s; R = $rng.NextDouble() }
  }
  return @($rows | Sort-Object @{e='S';Descending=$true}, R | ForEach-Object { $_.I })
}
function Tok([string]$s) { return [math]::Ceiling($s.Length / 4.0) }

# ---------- indices ----------
"Construindo indices..."
$idxChunkCtx = Build-Index $docs 'chunk' $true
$idxChunkLegacy = Build-Index $docs 'chunk' $false
$idxDocCtx = Build-Index $docs 'doc' $true
$grep = @{}
foreach ($d in $docs) { $h = @{}; foreach ($s in (Get-Stems ($d.Title + ' ' + [regex]::Replace($d.Body, '(?ms)^## For future agent.*?(?=^## |\z)', '')))) { if ($h.ContainsKey($s)) { $h[$s]++ } else { $h[$s] = 1 } }; $grep[$d.Id] = $h }
$domains = @($docs | ForEach-Object { $_.Dom } | Select-Object -Unique)
$domKeys = @($domains | ForEach-Object { $dm = $_; Get-StemKey ($dm + ' ' + (($topics | Where-Object Dom -eq $dm | ForEach-Object { $_.Tech }) -join ', ')) })
$domTokens = Tok (($domains | ForEach-Object { $dm = $_; "$dm - " + (($topics | Where-Object Dom -eq $dm | ForEach-Object { $_.Tech }) -join ', ') }) -join "`n")
$allTitleKeys = @($docs | ForEach-Object { $_.TitleKey })
$flatTok = Tok (($docs | ForEach-Object { $_.Id + ' | ' + $_.Title }) -join "`n")

# ---------- glossario (curado pelo time; cresce com o feedback) ----------
function New-Glossary($rng) {
  $g = @{}
  foreach ($t in $topics) {
    $al = New-Object System.Collections.Generic.List[string]
    if ($rng.NextDouble() -lt .80) { $al.Add($t.Biz[0]) }; if ($rng.NextDouble() -lt .50) { $al.Add($t.Biz[1]) }
    if ($rng.NextDouble() -lt .60) { $al.Add($t.Sym[0]) }; if ($rng.NextDouble() -lt .40) { $al.Add($t.Sym[1]) }
    $g[$t.Tech] = $al
  }
  foreach ($a in $aspects) {
    $al = New-Object System.Collections.Generic.List[string]
    if ($rng.NextDouble() -lt .80) { $al.Add($a.User[0]) }; if ($rng.NextDouble() -lt .60) { $al.Add($a.User[1]) }; if ($rng.NextDouble() -lt .40) { $al.Add($a.User[2]) }
    $g[$a.Tech] = $al
  }
  return $g
}
function Add-Alias($g, [string]$canon, [string]$alias) { if (-not $g[$canon].Contains($alias)) { $g[$canon].Add($alias) } }

# ---------- personas ----------
$personas = @('senior', 'junior', 'suporte', 'po', 'impaciente', 'estagiario')
function New-Query($d, [string]$persona, $rng) {
  $t = $topicById[$d.Topic]; $a = $aspById[$d.Aspect]
  $tp = $null; $ap = $null
  $bi = $rng.Next(2); $si = $rng.Next(2); $ai = $rng.Next(3)
  switch ($persona) {
    'senior'     { $text = "$($t.Tech) $($a.Tech)" }
    'junior'     { $tp = $t.Biz[$bi]; $ap = $a.User[$ai]; $text = "$ap - $tp" }
    'suporte'    { $tp = $t.Sym[$si]; $ap = $a.User[$ai]; $text = "$tp - $ap" }
    'po'         { $tp = $t.Biz[$bi]; $text = "$tp $($a.Tech)" }
    'impaciente' { $ap = $a.User[0]; $text = "$($t.Tech) $ap" }
    'estagiario' { $tp = if ($rng.NextDouble() -lt .5) { $t.Biz[1] } else { $t.Sym[1] }; $ap = $a.User[2]; $text = "$tp $ap" }
  }
  return [pscustomobject]@{ Text = $text; TopicId = $d.Topic; AspectId = $d.Aspect; Persona = $persona; Target = $d.Id; TType = $d.TType; TopicPhrase = $tp; AspPhrase = $ap }
}
function New-Queries([int]$seed) {
  $rng = New-Object Random $seed
  $list = New-Object System.Collections.Generic.List[object]
  foreach ($p in $personas) { foreach ($d in $docs) { $list.Add((New-Query $d $p $rng)) } }
  return ,$list
}

# ---------- estrategias ----------
# Retornam: Cands (ids, ate 3), Nav (tokens de navegacao), Mode ('doc' = abre arquivo inteiro | 'chunk' = ve secoes), Chunks
function Run-S1($q, $rng) {   # Skill com glossario plano de titulos (120 linhas) -> abre os 3 melhores arquivos
  $ord = Route $allTitleKeys $q $rng
  [pscustomobject]@{ Cands = @($ord[0..2] | ForEach-Object { $docs[$_].Id }); Nav = $flatTok; Mode = 'doc' }
}
function Stem-Arr([string]$s) { $l = Get-Stems $s; return ($l.ToArray() | Select-Object -Unique) }
function Run-S2($q, $rng) {   # Agente com grep/ripgrep literal (docs legados, sem frontmatter)
  $qs = @(Stem-Arr $q.Text); $nav = 0
  for ($round = 1; $round -le 2; $round++) {
    $rows = foreach ($d in $docs) {
      $h = $grep[$d.Id]; $m = 0; $tot = 0
      foreach ($s in $qs) { if ($h.ContainsKey($s)) { $m++; $tot += $h[$s] } }
      [pscustomobject]@{ Id = $d.Id; M = $m; T = $tot }
    }
    $rank = @($rows | Sort-Object @{e='M';Descending=$true}, @{e='T';Descending=$true})
    $nav += [math]::Min(40, @($rank | Where-Object M -gt 0).Count) * 30 + 80
    if ($round -eq 1 -and $rank[0].M -lt 2 -and $rng.NextDouble() -lt .5) {   # agente chuta o termo tecnico e tenta de novo
      $qs = @($qs + (Stem-Arr ($topicById[$q.TopicId].Tech + ' ' + $aspById[$q.AspectId].Tech)) | Select-Object -Unique); continue
    }
    break
  }
  [pscustomobject]@{ Cands = @($rank[0..2] | ForEach-Object { $_.Id }); Nav = $nav; Mode = 'doc' }
}
function Run-S3($q, $rng) {   # MOC 2 niveis: dominios (6) -> docs do dominio com resumo (20 linhas)
  $dord = Route $domKeys $q $rng; $dom = $domains[$dord[0]]
  $sub = @($docs | Where-Object Dom -eq $dom)
  $ord = Route @($sub | ForEach-Object { $_.LineKey }) $q $rng
  $nav = $domTokens + (Tok (($sub | ForEach-Object { $_.Title + ' - ' + $_.Meta['resumo'] }) -join "`n"))
  [pscustomobject]@{ Cands = @($ord[0..2] | ForEach-Object { $sub[$_].Id }); Nav = $nav; Mode = 'doc' }
}
function Run-S5($q, $rng) {   # MOC 3 niveis (vault Obsidian): dominio (6) -> topico (4) -> docs do topico (5)
  $dord = Route $domKeys $q $rng; $dom = $domains[$dord[0]]
  $tps = @($topics | Where-Object Dom -eq $dom)
  $tord = Route @($tps | ForEach-Object { Get-StemKey ($_.Tech + ' ' + $_.Biz[0]) }) $q $rng; $tp = $tps[$tord[0]]
  $sub = @($docs | Where-Object Topic -eq $tp.Id)
  $ord = Route @($sub | ForEach-Object { $_.LineKey }) $q $rng
  $nav = $domTokens + (Tok (($tps | ForEach-Object { $_.Tech + ' - ' + $_.Biz[0] }) -join "`n")) + (Tok (($sub | ForEach-Object { $_.Title + ' - ' + $_.Meta['resumo'] }) -join "`n"))
  [pscustomobject]@{ Cands = @($ord[0..2] | ForEach-Object { $sub[$_].Id }); Nav = $nav; Mode = 'doc' }
}
function Run-Doc($idx, $gloss, $q) {   # BM25 por arquivo (+ frontmatter), opcional glossario
  $r = Search-Index $idx $q.Text $gloss 3
  [pscustomobject]@{ Cands = @($r | ForEach-Object { $_.DocId }); Nav = 300; Mode = 'doc' }
}
function Run-Chunk($idx, $gloss, $q) {  # BM25 por secao: o CLI devolve as 3 melhores SECOES (agente nao abre o arquivo todo)
  $r = Search-Index $idx $q.Text $gloss 3
  [pscustomobject]@{ Cands = @($r | ForEach-Object { $_.DocId }); Nav = 0; Mode = 'chunk'; Chunks = $r }
}

function Eval-Result($res, $q) {
  $rank = [array]::IndexOf(@($res.Cands), $q.Target)
  $succ = ($rank -ge 0 -and $rank -lt 3)
  $tokens = [double]$res.Nav
  if ($res.Mode -eq 'doc') {
    foreach ($c in $res.Cands) { $tokens += $docTok[$c]; if ($c -eq $q.Target) { break } }
  } else {
    foreach ($c in $res.Chunks) { $tokens += (Tok $c.Text) + 15 }
    if ($succ) { $hit = $res.Chunks[$rank]; if ($hit.Heading -ne 'Anexo') { $tokens += $docTok[$q.Target] } }   # secao errada -> agente abre o arquivo
  }
  [pscustomobject]@{ Hit1 = ($rank -eq 0); Succ = $succ; Tokens = $tokens; Persona = $q.Persona; TType = $q.TType; Q = $q }
}

function Run-All($queries, $strategies, [int]$salt) {
  $out = @{}
  foreach ($name in $strategies.Keys) { $out[$name] = New-Object System.Collections.Generic.List[object] }
  $qi = 0
  foreach ($q in $queries) {
    $qi++; $si = 0
    foreach ($name in ($strategies.Keys | Sort-Object)) {
      $si++
      $rng = New-Object Random ($Seed * 100003 + $qi * 31 + $si + $salt)
      $res = & $strategies[$name] $q $rng
      $out[$name].Add((Eval-Result $res $q))
    }
  }
  return $out
}

function Summarize($rows) {
  $n = $rows.Count
  $tok = @($rows | ForEach-Object { $_.Tokens } | Sort-Object)
  [pscustomobject]@{
    N = $n
    Hit1 = [math]::Round(100 * @($rows | Where-Object Hit1).Count / $n, 1)
    Succ3 = [math]::Round(100 * @($rows | Where-Object Succ).Count / $n, 1)
    TokMedio = [math]::Round(($tok | Measure-Object -Average).Average)
    TokP90 = [math]::Round($tok[[math]::Floor(0.9 * ($n - 1))])
  }
}
# S7 = tenta S6; se as secoes mostradas nao trazem a resposta (agente percebe em 90% dos casos), cai no MOC (S5)
function Combine($a, $b) {
  $out = New-Object 'System.Collections.Generic.List[object]'
  for ($i = 0; $i -lt $a.Count; $i++) {
    if ($a[$i].Succ -or (($i * 7919) % 10) -ge 9) { $out.Add($a[$i]) }
    else { $out.Add([pscustomobject]@{ Hit1 = $false; Succ = $b[$i].Succ; Tokens = $a[$i].Tokens + $b[$i].Tokens; Persona = $a[$i].Persona; TType = $a[$i].TType; Q = $a[$i].Q }) }
  }
  return $out
}
function Pct($rows, $field, $value) { $s = @($rows | Where-Object { $_.$field -eq $value }); if ($s.Count -eq 0) { return '-' }; return [math]::Round(100 * @($s | Where-Object Succ).Count / $s.Count, 0) }

# ============================ EXECUCAO ============================
$gloss0 = New-Glossary (New-Object Random ($Seed + 1))
$G0 = New-GlossaryEntries $gloss0
$noGl = $null

$strategies = @{
  'S1 Skill + glossario plano de titulos'     = { param($q, $r) Run-S1 $q $r }
  'S2 Agente com grep literal'                = { param($q, $r) Run-S2 $q $r }
  'S3 MOC 2 niveis (dominio > docs)'          = { param($q, $r) Run-S3 $q $r }
  'S4 BM25 por arquivo + frontmatter'         = { param($q, $r) Run-Doc $idxDocCtx $null $q }
  'S5 MOC 3 niveis (dominio>topico>docs)'     = { param($q, $r) Run-S5 $q $r }
  'S6 HIBRIDO secoes+frontmatter+glossario'   = { param($q, $r) Run-Chunk $idxChunkCtx $G0 $q }
  'S6a hibrido SEM glossario'                 = { param($q, $r) Run-Chunk $idxChunkCtx $null $q }
  'S6b hibrido SEM frontmatter (docs legados)'= { param($q, $r) Run-Chunk $idxChunkLegacy $G0 $q }
  'S4g BM25 por arquivo + glossario (sem secoes)' = { param($q, $r) Run-Doc $idxDocCtx $G0 $q }
}
"Simulando $($personas.Count * $docs.Count) consultas x $($strategies.Count) estrategias..."
$qA = New-Queries $Seed
$res = Run-All $qA $strategies 0
$res['S7 HIBRIDO + fallback MOC (S6 -> S5)'] = Combine $res['S6 HIBRIDO secoes+frontmatter+glossario'] $res['S5 MOC 3 niveis (dominio>topico>docs)']

$md = New-Object System.Collections.Generic.List[string]
$md.Add("# Resultado da competição (gerado por lab/Simulate.ps1, seed $Seed)")
$md.Add("")
$md.Add("Corpus: $($docs.Count) docs, ~$corpusTokens tokens no total. Consultas: $($qA.Count) ($($personas.Count) personas x $($docs.Count) docs). Sucesso = doc certo entre os 3 candidatos que o agente chega a abrir/ver.")
$md.Add("")
$md.Add("## Placar geral")
$md.Add("")
$md.Add("| Estratégia | Acerto no 1º (%) | Sucesso top-3 (%) | Tokens médios/pergunta | Tokens P90 |")
$md.Add("|---|---:|---:|---:|---:|")
$order = $res.Keys | Sort-Object { (Summarize $res[$_]).Succ3 } -Descending
foreach ($name in $order) { $s = Summarize $res[$name]; $md.Add("| $name | $($s.Hit1) | $($s.Succ3) | $($s.TokMedio) | $($s.TokP90) |") }
$md.Add("| (ref) Colocar TODOS os docs no contexto | - | n/d | $corpusTokens | $corpusTokens |")
$md.Add("")
$md.Add("## Sucesso top-3 por persona (%)")
$md.Add("")
$md.Add("| Estratégia | " + ($personas -join ' | ') + " |")
$md.Add("|---|" + (($personas | ForEach-Object { '---:' }) -join '|') + "|")
foreach ($name in $order) { $md.Add("| $name | " + (($personas | ForEach-Object { Pct $res[$name] 'Persona' $_ }) -join ' | ') + " |") }
$md.Add("")
$md.Add("## Sucesso top-3 por tipo de título do doc (%)")
$md.Add("")
$md.Add("| Estratégia | descritivo | topico (sem o aspecto) | genérico |")
$md.Add("|---|---:|---:|---:|")
foreach ($name in $order) { $md.Add("| $name | $(Pct $res[$name] 'TType' 'descritivo') | $(Pct $res[$name] 'TType' 'topico') | $(Pct $res[$name] 'TType' 'generico') |") }

# ---------- ciclo de feedback do glossario (S6) ----------
$sKey = 'S6 HIBRIDO secoes+frontmatter+glossario'
$fails = @($res[$sKey] | Where-Object { -not $_.Succ })
$gtab1 = @{}; foreach ($k in $gloss0.Keys) { $gtab1[$k] = New-Object System.Collections.Generic.List[string]; $gtab1[$k].AddRange([string[]]@($gloss0[$k])) }
$added = 0
foreach ($f in $fails) {
  $q = $f.Q
  if ($q.TopicPhrase -and -not $gtab1[$topicById[$q.TopicId].Tech].Contains($q.TopicPhrase)) { Add-Alias $gtab1 $topicById[$q.TopicId].Tech $q.TopicPhrase; $added++ }
  if ($q.AspPhrase -and -not $gtab1[$aspById[$q.AspectId].Tech].Contains($q.AspPhrase)) { Add-Alias $gtab1 $aspById[$q.AspectId].Tech $q.AspPhrase; $added++ }
}
$G1 = New-GlossaryEntries $gtab1
$qB = New-Queries ($Seed + 999)
$fb = @{
  'S6 glossario inicial'                 = { param($q, $r) Run-Chunk $idxChunkCtx $G0 $q }
  'S6 glossario apos 1 ciclo de feedback' = { param($q, $r) Run-Chunk $idxChunkCtx $G1 $q }
  'S5 MOC 3 niveis (ref)'                 = { param($q, $r) Run-S5 $q $r }
}
$resB = Run-All $qB $fb 5000
$resB['S7 hibrido + fallback MOC, apos feedback'] = Combine $resB['S6 glossario apos 1 ciclo de feedback'] $resB['S5 MOC 3 niveis (ref)']
$md.Add("")
$md.Add("## Ciclo de feedback do glossário (consultas NOVAS, rodada B)")
$md.Add("")
$md.Add("Cada consulta que falhou na rodada A virou alias no glossário ($($fails.Count) falhas, $added aliases adicionados; os aliases que o time escreveria em 1 sprint de uso).")
$md.Add("")
$md.Add("| Versão | Acerto no 1º (%) | Sucesso top-3 (%) | Tokens médios |")
$md.Add("|---|---:|---:|---:|")
foreach ($name in ($resB.Keys | Sort-Object)) { $s = Summarize $resB[$name]; $md.Add("| $name | $($s.Hit1) | $($s.Succ3) | $($s.TokMedio) |") }

[IO.File]::WriteAllLines("$PSScriptRoot\sim\resultado.md", $md, $utf8)
# glossario resultante como artefato do repo
$gl = New-Object System.Collections.Generic.List[string]
$gl.Add("# Glossário de sinônimos (termo canônico = aliases usados pelo time). Lido por DocSearch.ps1 -Glossary")
foreach ($k in ($gtab1.Keys | Sort-Object)) { if ($gtab1[$k].Count) { $gl.Add("$k = " + ($gtab1[$k] -join ' | ')) } }
[IO.File]::WriteAllLines("$root\corpus\glossario.txt", $gl, $utf8)
$md
