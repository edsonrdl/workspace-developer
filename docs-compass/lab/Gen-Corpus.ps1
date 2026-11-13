# Gera um corpus sintetico de docs .md (plataforma de pagamentos ficticia "AcmePay").
# 24 topicos x 5 aspectos = 120 docs. A resposta de cada doc fica SEMPRE na ultima secao (Anexo).
# 20% dos docs tem titulo generico (o assunto so aparece no corpo). Frontmatter simula enriquecimento por LLM
# (parcial e imperfeito de proposito: cada alias so entra com certa probabilidade).
param([int]$Seed = 42)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object Text.UTF8Encoding $false
$rng = New-Object Random $Seed

$topics = foreach ($l in [IO.File]::ReadAllLines("$PSScriptRoot\data\topics.txt", [Text.Encoding]::UTF8)) { if ($l.Trim()) { $p = $l.Split('|'); [pscustomobject]@{ Dom=$p[0]; Id=$p[1]; Tech=$p[2]; Biz=@($p[3],$p[4]); Sym=@($p[5],$p[6]) } } }
$aspects = foreach ($l in [IO.File]::ReadAllLines("$PSScriptRoot\data\aspects.txt", [Text.Encoding]::UTF8)) { if ($l.Trim()) { $p = $l.Split('|'); [pscustomobject]@{ Id=$p[0]; Tech=$p[1]; User=@($p[2],$p[3],$p[4]) } } }

$filler = @(
 'O mecanismo de {t} foi introduzido para reduzir incidentes recorrentes no domínio de {d}.',
 'Antes da adoção de {t}, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.',
 'A implementação de {t} segue o padrão definido pelo comitê de arquitetura no início do ano.',
 'O prazo de implantação das mudanças relacionadas a {t} segue o calendário trimestral de releases.',
 'É importante não confundir {t} com os mecanismos legados, que serão descontinuados.',
 'Todas as alterações em {t} passam por revisão de pelo menos duas pessoas da equipe.',
 'O limite de complexidade aceito nos serviços que usam {t} é revisado a cada semestre.',
 'Os testes automatizados de {t} rodam no pipeline de integração contínua a cada commit.',
 'A documentação de {t} é mantida pela equipe do domínio e revisada em cada release.',
 'Em ambientes de homologação o comportamento de {t} é idêntico ao de produção, exceto pelos volumes.',
 'Métricas de {t} são publicadas no painel de observabilidade e acompanhadas semanalmente.',
 'Clientes corporativos podem solicitar ajustes em {t} por meio do gerente de conta.',
 'Durante a migração para a nova plataforma, {t} foi reescrito sem mudanças de contrato.',
 'Qualquer dúvida de negócio sobre {t} deve ser registrada no backlog do domínio de {d}.',
 'A configuração padrão de {t} atende à maioria dos casos, mas pode ser sobrescrita por serviço.',
 'Exemplos de uso de {t} estão disponíveis no repositório de referência da plataforma.',
 'Falhas em {t} geram eventos que são correlacionados com os logs estruturados do serviço.',
 'O procedimento de auditoria exige evidências de que {t} está ativo antes de cada certificação.',
 'O desenho de {t} considera crescimento de volume de até dez vezes sem mudança estrutural.',
 'Os riscos conhecidos de {t} estão listados no registro de riscos do domínio de {d}.')
$secs = @('Contexto','Como funciona','Decisões de arquitetura','Boas práticas')

function Pick($arr) { return $arr[$rng.Next($arr.Count)] }
function Sample($arr, [int]$n) { return @($arr | Sort-Object { $rng.Next() } | Select-Object -First $n) }
function Chance([double]$p) { return ($rng.NextDouble() -lt $p) }

$suffix = @('visão geral','notas','guia','referência','anotações')
$squads = @('Atlas','Orion','Vega','Helios','Nexus','Titan','Aurora','Zenith')
$truth = New-Object System.Collections.Generic.List[string]
$n = 0
foreach ($t in $topics) {
  foreach ($a in $aspects) {
    $n++
    $id = "$($t.Id)-$($a.Id)"
    $N1 = $rng.Next(40, 990); $N2 = $rng.Next(2, 72)
    $slug = $t.Id -replace '[^a-z0-9]', ''
    switch ($a.Id) {
      'limite' { $fact = "O limite máximo configurado para $($t.Tech) em produção é de **$N1 operações por minuto**, com burst de $($N1*2)." }
      'prazo' { $fact = "O prazo (SLA) de atendimento para $($t.Tech) é de **$N2 horas úteis** após a abertura do chamado." }
      'responsavel' { $fact = "A equipe responsável por $($t.Tech) é a squad **$(Pick $squads)**, canal #$slug-suporte (plantão: ramal $N1)." }
      'config' { $fact = "O parâmetro de configuração é ``$slug.max_attempts=$N2`` no arquivo ``settings-prod.yaml`` (valor padrão $N1)." }
      'procedimento' { $fact = "Runbook de troubleshooting: 1) confirmar o alerta ALR-$N1; 2) reiniciar o job ``$slug-worker``; 3) abrir incidente se persistir por mais de $N2 minutos." }
    }
    # tipo de titulo
    $r = $rng.NextDouble()
    if ($r -lt 0.5) { $ttype = 'descritivo'; $title = "$($t.Tech) - $($a.Tech)" }
    elseif ($r -lt 0.8) { $ttype = 'topico'; $title = "$($t.Tech) - $(Pick $suffix)" }
    else { $ttype = 'generico'; $title = "Guia operacional $($t.Dom) nº$n" }
    $dom = $t.Dom

    # frontmatter (enriquecimento parcial)
    $als = New-Object System.Collections.Generic.List[string]
    if (Chance .85) { $als.Add($t.Biz[0]) }; if (Chance .35) { $als.Add($t.Biz[1]) }
    if (Chance .60) { $als.Add($t.Sym[0]) }; if (Chance .30) { $als.Add($t.Sym[1]) }
    if (Chance .80) { $als.Add($a.User[0]) }; if (Chance .50) { $als.Add($a.User[1]) }; if (Chance .30) { $als.Add($a.User[2]) }
    $qs = @("Qual o $($a.Tech) de $($t.Tech)?")
    if (Chance .6) { $qs += "$($a.User[0]) $($t.Biz[0])?" }
    $conf = if ($n % 10 -eq 0) { 'medium' } else { 'high' }   # ilustrativo: stated | high | medium | speculation
    $fm = "---`nid: $id`ntitle: $title`ndominio: $dom`ntopico: $($t.Id)`nresumo: Contém o $($a.Tech) de $($t.Tech) ($($t.Biz[0])).`naliases: $($als -join ' | ')`nperguntas: $($qs -join ' | ')`nconfidence: $conf`nowner: squad-$dom`natualizado: 2026-0$($rng.Next(1,9))-$($rng.Next(10,28))`n---`n"

    $sb = New-Object Text.StringBuilder
    [void]$sb.Append("# $title`n`n")
    [void]$sb.Append("## For future agent`n`nEste doc trata do $($a.Tech) de $($t.Tech) ($($t.Biz[0])). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.`n`n")
    foreach ($s in $secs) {
      [void]$sb.Append("## $s`n`n")
      $sent = Sample $filler ($rng.Next(5,8))
      [void]$sb.Append((($sent | ForEach-Object { $_.Replace('{t}', $t.Tech).Replace('{d}', $dom) }) -join ' ') + "`n`n")
    }
    [void]$sb.Append("## Histórico de mudanças`n`n")
    foreach ($k in 1..4) { [void]$sb.Append("- 2025-0$($rng.Next(1,9))-$($rng.Next(10,28)): " + ((Pick $filler).Replace('{t}', $t.Tech).Replace('{d}', $dom)) + "`n") }
    [void]$sb.Append("`n## Anexo`n`n$fact " + ((Pick $filler).Replace('{t}', $t.Tech).Replace('{d}', $dom)) + "`n")

    $dir = "$root\corpus\$dom"; New-Item -ItemType Directory -Force $dir | Out-Null
    [IO.File]::WriteAllText("$dir\$id.md", $fm + $sb.ToString(), $utf8)
    $truth.Add("$id|$ttype")
  }
}
New-Item -ItemType Directory -Force "$PSScriptRoot\sim" | Out-Null
[IO.File]::WriteAllLines("$PSScriptRoot\sim\truth.tsv", $truth, $utf8)
"Gerados $n docs em $root\corpus"
