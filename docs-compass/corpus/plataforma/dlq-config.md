---
id: dlq-config
title: Fila de mensagens mortas (DLQ) - parâmetro de configuração
dominio: plataforma
topico: dlq
resumo: Contém o parâmetro de configuração de Fila de mensagens mortas (DLQ) (mensagens que falharam no processamento).
aliases: mensagens que falharam no processamento | qual a configuração | como ajustar
perguntas: Qual o parâmetro de configuração de Fila de mensagens mortas (DLQ)? | onde configuro mensagens que falharam no processamento?
confidence: high
owner: squad-plataforma
atualizado: 2026-02-23
---
# Fila de mensagens mortas (DLQ) - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Fila de mensagens mortas (DLQ) (mensagens que falharam no processamento). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Em ambientes de homologação o comportamento de Fila de mensagens mortas (DLQ) é idêntico ao de produção, exceto pelos volumes. Falhas em Fila de mensagens mortas (DLQ) geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Fila de mensagens mortas (DLQ) é revisado a cada semestre. Os riscos conhecidos de Fila de mensagens mortas (DLQ) estão listados no registro de riscos do domínio de plataforma. Métricas de Fila de mensagens mortas (DLQ) são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Como funciona

Métricas de Fila de mensagens mortas (DLQ) são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em Fila de mensagens mortas (DLQ) passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Fila de mensagens mortas (DLQ) é idêntico ao de produção, exceto pelos volumes. O mecanismo de Fila de mensagens mortas (DLQ) foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Falhas em Fila de mensagens mortas (DLQ) geram eventos que são correlacionados com os logs estruturados do serviço.

## Decisões de arquitetura

Antes da adoção de Fila de mensagens mortas (DLQ), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Durante a migração para a nova plataforma, Fila de mensagens mortas (DLQ) foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Fila de mensagens mortas (DLQ) deve ser registrada no backlog do domínio de plataforma. Falhas em Fila de mensagens mortas (DLQ) geram eventos que são correlacionados com os logs estruturados do serviço. A documentação de Fila de mensagens mortas (DLQ) é mantida pela equipe do domínio e revisada em cada release.

## Boas práticas

A implementação de Fila de mensagens mortas (DLQ) segue o padrão definido pelo comitê de arquitetura no início do ano. O limite de complexidade aceito nos serviços que usam Fila de mensagens mortas (DLQ) é revisado a cada semestre. Os riscos conhecidos de Fila de mensagens mortas (DLQ) estão listados no registro de riscos do domínio de plataforma. É importante não confundir Fila de mensagens mortas (DLQ) com os mecanismos legados, que serão descontinuados. O desenho de Fila de mensagens mortas (DLQ) considera crescimento de volume de até dez vezes sem mudança estrutural. O prazo de implantação das mudanças relacionadas a Fila de mensagens mortas (DLQ) segue o calendário trimestral de releases. Clientes corporativos podem solicitar ajustes em Fila de mensagens mortas (DLQ) por meio do gerente de conta.

## Histórico de mudanças

- 2025-01-23: A documentação de Fila de mensagens mortas (DLQ) é mantida pela equipe do domínio e revisada em cada release.
- 2025-03-24: O limite de complexidade aceito nos serviços que usam Fila de mensagens mortas (DLQ) é revisado a cada semestre.
- 2025-05-12: O mecanismo de Fila de mensagens mortas (DLQ) foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.
- 2025-02-17: A documentação de Fila de mensagens mortas (DLQ) é mantida pela equipe do domínio e revisada em cada release.

## Anexo

O parâmetro de configuração é `dlq.max_attempts=15` no arquivo `settings-prod.yaml` (valor padrão 726). O desenho de Fila de mensagens mortas (DLQ) considera crescimento de volume de até dez vezes sem mudança estrutural.
