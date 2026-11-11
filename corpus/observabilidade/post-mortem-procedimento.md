---
id: post-mortem-procedimento
title: Post-mortem de incidentes - runbook de troubleshooting
dominio: observabilidade
topico: post-mortem
resumo: Contém o runbook de troubleshooting de Post-mortem de incidentes (relatório depois de uma falha).
aliases: relatório depois de uma falha | análise do que deu errado
perguntas: Qual o runbook de troubleshooting de Post-mortem de incidentes? | como resolver relatório depois de uma falha?
confidence: medium
owner: squad-observabilidade
atualizado: 2026-08-19
---
# Post-mortem de incidentes - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Post-mortem de incidentes (relatório depois de uma falha). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Qualquer dúvida de negócio sobre Post-mortem de incidentes deve ser registrada no backlog do domínio de observabilidade. Falhas em Post-mortem de incidentes geram eventos que são correlacionados com os logs estruturados do serviço. Durante a migração para a nova plataforma, Post-mortem de incidentes foi reescrito sem mudanças de contrato. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma.

## Como funciona

Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes. O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Durante a migração para a nova plataforma, Post-mortem de incidentes foi reescrito sem mudanças de contrato. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade. O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe.

## Decisões de arquitetura

A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta. O desenho de Post-mortem de incidentes considera crescimento de volume de até dez vezes sem mudança estrutural. Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente. A implementação de Post-mortem de incidentes segue o padrão definido pelo comitê de arquitetura no início do ano. Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit.

## Boas práticas

O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta. Durante a migração para a nova plataforma, Post-mortem de incidentes foi reescrito sem mudanças de contrato. A documentação de Post-mortem de incidentes é mantida pela equipe do domínio e revisada em cada release. O desenho de Post-mortem de incidentes considera crescimento de volume de até dez vezes sem mudança estrutural. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade.

## Histórico de mudanças

- 2025-01-10: Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-01-19: O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre.
- 2025-01-19: Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma.
- 2025-01-23: Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-843; 2) reiniciar o job `postmortem-worker`; 3) abrir incidente se persistir por mais de 32 minutos. A documentação de Post-mortem de incidentes é mantida pela equipe do domínio e revisada em cada release.
