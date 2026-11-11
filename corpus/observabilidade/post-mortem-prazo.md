---
id: post-mortem-prazo
title: Post-mortem de incidentes - prazo (SLA)
dominio: observabilidade
topico: post-mortem
resumo: Contém o prazo (SLA) de Post-mortem de incidentes (relatório depois de uma falha).
aliases: relatório depois de uma falha | incidente repetiu sem lição aprendida | tempo de espera
perguntas: Qual o prazo (SLA) de Post-mortem de incidentes?
confidence: high
owner: squad-observabilidade
atualizado: 2026-07-26
---
# Post-mortem de incidentes - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Post-mortem de incidentes (relatório depois de uma falha). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit. É importante não confundir Post-mortem de incidentes com os mecanismos legados, que serão descontinuados. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe.

## Como funciona

Falhas em Post-mortem de incidentes geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente. O desenho de Post-mortem de incidentes considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes. O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade.

## Decisões de arquitetura

A implementação de Post-mortem de incidentes segue o padrão definido pelo comitê de arquitetura no início do ano. Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit. Falhas em Post-mortem de incidentes geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

Falhas em Post-mortem de incidentes geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. O procedimento de auditoria exige evidências de que Post-mortem de incidentes está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-06-16: O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.
- 2025-07-10: Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-03-12: Falhas em Post-mortem de incidentes geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-07-24: É importante não confundir Post-mortem de incidentes com os mecanismos legados, que serão descontinuados.

## Anexo

O prazo (SLA) de atendimento para Post-mortem de incidentes é de **38 horas úteis** após a abertura do chamado. A documentação de Post-mortem de incidentes é mantida pela equipe do domínio e revisada em cada release.
