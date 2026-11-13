# Gera os MOCs (mapas de conteudo) a partir do frontmatter. Rodar no CI a cada merge.
#   corpus/INDEX.md            -> nivel 1: dominios e os topicos de cada um (~6 linhas)
#   corpus/<dominio>/_INDEX.md -> nivel 2/3: topicos com seus docs e o resumo de uma linha
param([string]$Root = (Join-Path $PSScriptRoot '..\corpus'))
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\DocSearch.ps1"
$utf8 = New-Object Text.UTF8Encoding $false
$docs = Read-Corpus $Root
$root1 = New-Object System.Collections.Generic.List[string]
$root1.Add("# Índice geral (MOC nível 1)"); $root1.Add("")
$root1.Add("Escolha o domínio e abra o ``_INDEX.md`` dele. Busca direta: ``DocSearch.ps1 -Query ""...""``."); $root1.Add("")
foreach ($dom in ($docs | ForEach-Object { $_.Meta['dominio'] } | Select-Object -Unique)) {
  $dd = @($docs | Where-Object { $_.Meta['dominio'] -eq $dom })
  $tops = @($dd | ForEach-Object { $_.Meta['topico'] } | Select-Object -Unique)
  $names = @($tops | ForEach-Object { $t = $_; $f1 = ($dd | Where-Object { $_.Meta['topico'] -eq $t -and $_.Title -notlike 'Guia operacional*' } | Select-Object -First 1); if ($f1) { ($f1.Title -split ' - ')[0] } else { $t } })
  $root1.Add("- **[[$dom/_INDEX|$dom]]** - " + ($names -join ', '))
  $l = New-Object System.Collections.Generic.List[string]
  $l.Add("# $dom (MOC nível 2)"); $l.Add("")
  foreach ($t in $tops) {
    $td = @($dd | Where-Object { $_.Meta['topico'] -eq $t })
    $first = ($td | Where-Object { $_.Title -notlike 'Guia operacional*' } | Select-Object -First 1)
    $tname = if ($first) { ($first.Title -split ' - ')[0] } else { $t }
    $l.Add("## $tname"); $l.Add("")
    foreach ($d in $td) { $l.Add("- [[$($d.Id)]] - $($d.Meta['resumo'])") }
    $l.Add("")
  }
  [IO.File]::WriteAllLines("$Root\$dom\_INDEX.md", $l, $utf8)
}
[IO.File]::WriteAllLines("$Root\INDEX.md", $root1, $utf8)
"MOCs gerados: INDEX.md + $((($docs | ForEach-Object { $_.Meta['dominio'] } | Select-Object -Unique)).Count) _INDEX.md"
