# Extrai texto de um .docx sem dependências (só .NET/PowerShell).
# Uso: powershell -NoProfile -ExecutionPolicy Bypass -File extract-docx.ps1 -Path <arquivo.docx> [-Out <saida.md>]
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [string]$Out
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $Path)) { Write-Error "Arquivo não encontrado: $Path"; exit 1 }
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead((Resolve-Path -LiteralPath $Path).Path)
try {
  $entry = $zip.Entries | Where-Object { ($_.FullName -replace '\\','/') -eq 'word/document.xml' } | Select-Object -First 1
  if (-not $entry) { Write-Error 'Não parece um .docx (sem word/document.xml)'; exit 1 }
  $sr = New-Object System.IO.StreamReader($entry.Open(), [System.Text.Encoding]::UTF8)
  $xml = $sr.ReadToEnd(); $sr.Close()
} finally { $zip.Dispose() }

$t = $xml
$t = $t -replace '<w:numPr>.*?</w:numPr>', '<w:t>- </w:t>'     # item de lista
$t = $t -replace '</w:p>(?=\s*</w:tc>)', ''                         # parágrafo final da célula não quebra linha
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

if ($Out) {
  [System.IO.File]::WriteAllText($Out, $t + "`n", (New-Object System.Text.UTF8Encoding($false)))
  Write-Output "OK -> $Out ($($t.Length) chars)"
} else {
  [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
  Write-Output $t
}
