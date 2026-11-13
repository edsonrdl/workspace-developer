param([string]$Questions,[string]$Repo,[string]$Out)
Set-Location $Repo
$rows = Get-Content $Questions -Encoding UTF8 | Where-Object { $_.Trim() }
$res = foreach ($r in $rows) {
  $p = $r -split "`t"; $exp = ($p[0] -replace '/','\').ToLower()
  $o = & powershell -NoProfile -File src\DocSearch.ps1 -Query $p[1] -Glossary corpus\glossario.txt -Top 3 2>&1 | ForEach-Object { "$_" }
  $files = @($o | Where-Object { $_ -match '^\s+arquivo:' } | ForEach-Object { ($_ -replace '^\s+arquivo:\s*','').ToLower() })
  $rank = 0; for ($i=0;$i -lt $files.Count;$i++) { if ($files[$i].EndsWith('\corpus\' + $exp)) { $rank = $i+1; break } }
  [pscustomobject]@{ doc=$p[0]; rank=$rank; n=$files.Count; q=$p[1] }
}
$res | Export-Csv $Out -NoTypeInformation -Encoding UTF8
"top1={0}/{1} top3={2}/{1}" -f @($res|?{$_.rank -eq 1}).Count, $res.Count, @($res|?{$_.rank -ge 1}).Count
$res | ? { $_.rank -ne 1 } | % { "  rank=$($_.rank) $($_.doc)" }
