# Extrai texto de um .docx sem dependências (só .NET/PowerShell) e AVISA o que não consegue ler.
# Uso: powershell -NoProfile -File extract-docx.ps1 -Path <arquivo.docx> [-Out <saida.md>]
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [string]$Out
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $Path)) { Write-Error "Arquivo não encontrado: $Path"; exit 1 }
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$full = (Resolve-Path -LiteralPath $Path).Path
try {
  # FileShare.ReadWrite: funciona mesmo com o Word aberto (arquivo "travado")
  $fs = New-Object System.IO.FileStream($full, 'Open', 'Read', 'ReadWrite')
  $zip = New-Object System.IO.Compression.ZipArchive($fs, 'Read')
} catch { Write-Error "Não consegui abrir o arquivo (é um .docx válido?): $($_.Exception.Message)"; exit 1 }
$images = 0; $hasComments = $false
try {
  $norm = { param($e) $e.FullName.Replace([string][char]92, '/') }
  $entry = $zip.Entries | Where-Object { (& $norm $_) -eq 'word/document.xml' } | Select-Object -First 1
  if (-not $entry) { Write-Error 'Não parece um .docx (sem word/document.xml)'; exit 1 }
  $sr = New-Object System.IO.StreamReader($entry.Open(), [System.Text.Encoding]::UTF8)
  $xml = $sr.ReadToEnd(); $sr.Close()
  $images = @($zip.Entries | Where-Object { (& $norm $_) -like 'word/media/*' }).Count
  $hasComments = [bool]($zip.Entries | Where-Object { (& $norm $_) -eq 'word/comments.xml' })
} finally { $zip.Dispose(); $fs.Dispose() }

$t = $xml
# texto excluído em "controle de alterações" não deve virar texto vivo
$deletions = [regex]::Matches($t, '<w:del\b').Count
$t = [regex]::Replace($t, '(?s)<w:del\b[^>]*>.*?</w:del>', '')
# caixas de texto aparecem duas vezes (Choice + Fallback): mantém só uma
$t = [regex]::Replace($t, '(?s)<mc:Fallback>.*?</mc:Fallback>', '')
# títulos -> #, listas -> "- " com recuo
$t = [regex]::Replace($t, '(?s)<w:p\b(?:(?!</w:p>).)*?<w:pStyle w:val="(?:Heading|Ttulo|Titulo|Titre|berschrift)(\d)"[^>]*/>', {
  param($m) '<w:p><w:t>' + ('#' * [int]$m.Groups[1].Value) + ' </w:t>' })
$t = [regex]::Replace($t, '(?s)<w:numPr>\s*<w:ilvl w:val="(\d+)"\s*/>.*?</w:numPr>', {
  param($m) '<w:t>' + ('  ' * [int]$m.Groups[1].Value) + '- </w:t>' })
$t = $t -replace '(?s)<w:numPr>.*?</w:numPr>', '<w:t>- </w:t>'
$t = $t -replace '</w:p>(?=\s*</w:tc>)', ''          # parágrafo final da célula não quebra linha
$t = $t -replace '</w:p>', "`n"
$t = $t -replace '<w:br\s*/>', "`n"
$t = $t -replace '<w:tab\s*/>', "`t"
$t = $t -replace '</w:tc>', ' | '
$t = $t -replace '</w:tr>', "`n"
$t = $t -replace '<[^>]+>', ''
$t = [System.Net.WebUtility]::HtmlDecode($t)
$t = ($t -split "`n" | ForEach-Object { $_.TrimEnd() }) -join "`n"
$t = $t -replace "(\n){3,}", "`n`n"
$t = $t.Trim()

$warn = @()
if ($images -gt 0)   { $warn += "$images imagem(ns)/diagrama(s) NÃO lidos (word/media). Peça ao usuário para descrevê-los ou exporte-os." }
if ($hasComments)    { $warn += "O documento tem comentários que NÃO foram extraídos." }
if ($deletions -gt 0){ $warn += "$deletions trecho(s) excluído(s) em controle de alterações foram ignorados." }
foreach ($w in $warn) { Write-Warning $w }
if ($warn.Count -gt 0) {
  $banner = ($warn | ForEach-Object { "> AVISO: $_" }) -join "`n"
  $t = $banner + "`n`n" + $t
}

if ($Out) {
  $dir = Split-Path -Parent $Out
  if ($dir -and -not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  [System.IO.File]::WriteAllText($Out, $t + "`n", (New-Object System.Text.UTF8Encoding($false)))
  Write-Output "OK -> $Out ($($t.Length) chars; imagens: $images; avisos: $($warn.Count))"
} else {
  [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
  Write-Output $t
}
