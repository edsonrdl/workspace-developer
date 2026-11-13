---
id: dlq-procedimento
title: Fila de mensagens mortas (DLQ) - runbook de troubleshooting
dominio: plataforma
topico: dlq
resumo: Contém o runbook de troubleshooting de Fila de mensagens mortas (DLQ) (mensagens que falharam no processamento).
aliases: mensagens que falharam no processamento | fila de erros do sistema assíncrono | eventos não foram processados | como resolver
perguntas: Qual o runbook de troubleshooting de Fila de mensagens mortas (DLQ)? | como resolver mensagens que falharam no processamento?
confidence: high
owner: squad-plataforma
atualizado: 2026-03-11
---
# Fila de mensagens mortas (DLQ) - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Fila de mensagens mortas (DLQ) (mensagens que falharam no processamento). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A configuração padrão de Fila de mensagens mortas (DLQ) atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Fila de mensagens mortas (DLQ) passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Fila de mensagens mortas (DLQ) foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. O desenho de Fila de mensagens mortas (DLQ) considera crescimento de volume de até dez vezes sem mudança estrutural. A documentação de Fila de mensagens mortas (DLQ) é mantida pela equipe do domínio e revisada em cada release.

## Como funciona

Falhas em Fila de mensagens mortas (DLQ) geram eventos que são correlacionados com os logs estruturados do serviço. Durante a migração para a nova plataforma, Fila de mensagens mortas (DLQ) foi reescrito sem mudanças de contrato. Os testes automatizados de Fila de mensagens mortas (DLQ) rodam no pipeline de integração contínua a cada commit. O limite de complexidade aceito nos serviços que usam Fila de mensagens mortas (DLQ) é revisado a cada semestre. Todas as alterações em Fila de mensagens mortas (DLQ) passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Fila de mensagens mortas (DLQ) é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

É importante não confundir Fila de mensagens mortas (DLQ) com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Fila de mensagens mortas (DLQ) é revisado a cada semestre. Antes da adoção de Fila de mensagens mortas (DLQ), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O procedimento de auditoria exige evidências de que Fila de mensagens mortas (DLQ) está ativo antes de cada certificação. Métricas de Fila de mensagens mortas (DLQ) são publicadas no painel de observabilidade e acompanhadas semanalmente. Os testes automatizados de Fila de mensagens mortas (DLQ) rodam no pipeline de integração contínua a cada commit. O mecanismo de Fila de mensagens mortas (DLQ) foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Fila de mensagens mortas (DLQ) por meio do gerente de conta. Os riscos conhecidos de Fila de mensagens mortas (DLQ) estão listados no registro de riscos do domínio de plataforma. Exemplos de uso de Fila de mensagens mortas (DLQ) estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Fila de mensagens mortas (DLQ) deve ser registrada no backlog do domínio de plataforma. O desenho de Fila de mensagens mortas (DLQ) considera crescimento de volume de até dez vezes sem mudança estrutural. O limite de complexidade aceito nos serviços que usam Fila de mensagens mortas (DLQ) é revisado a cada semestre.

## Histórico de mudanças

- 2025-08-19: Métricas de Fila de mensagens mortas (DLQ) são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-07-13: A documentação de Fila de mensagens mortas (DLQ) é mantida pela equipe do domínio e revisada em cada release.
- 2025-07-21: Os riscos conhecidos de Fila de mensagens mortas (DLQ) estão listados no registro de riscos do domínio de plataforma.
- 2025-04-21: Métricas de Fila de mensagens mortas (DLQ) são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-413; 2) reiniciar o job `dlq-worker`; 3) abrir incidente se persistir por mais de 32 minutos. A implementação de Fila de mensagens mortas (DLQ) segue o padrão definido pelo comitê de arquitetura no início do ano.
