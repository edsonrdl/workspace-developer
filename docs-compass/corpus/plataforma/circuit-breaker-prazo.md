---
id: circuit-breaker-prazo
title: Guia operacional plataforma nº67
dominio: plataforma
topico: circuit-breaker
resumo: Contém o prazo (SLA) de Circuit breaker (proteção quando o parceiro cai).
aliases: proteção quando o parceiro cai | desligar chamadas para serviço instável | em quanto tempo | tempo de espera
perguntas: Qual o prazo (SLA) de Circuit breaker? | em quanto tempo proteção quando o parceiro cai?
confidence: high
owner: squad-plataforma
atualizado: 2026-03-20
---
# Guia operacional plataforma nº67

## For future agent

Este doc trata do prazo (SLA) de Circuit breaker (proteção quando o parceiro cai). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta. Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço. É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados. O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma.

## Como funciona

A configuração padrão de Circuit breaker atende à maioria dos casos, mas pode ser sobrescrita por serviço. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma. Durante a migração para a nova plataforma, Circuit breaker foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta. É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados. Todas as alterações em Circuit breaker passam por revisão de pelo menos duas pessoas da equipe.

## Decisões de arquitetura

É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados. Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma. O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre. Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit. O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases. Antes da adoção de Circuit breaker, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Boas práticas

Durante a migração para a nova plataforma, Circuit breaker foi reescrito sem mudanças de contrato. Os riscos conhecidos de Circuit breaker estão listados no registro de riscos do domínio de plataforma. O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação. Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit.

## Histórico de mudanças

- 2025-06-19: Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma.
- 2025-07-15: Métricas de Circuit breaker são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-08-14: Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes.
- 2025-06-23: O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.

## Anexo

O prazo (SLA) de atendimento para Circuit breaker é de **68 horas úteis** após a abertura do chamado. A configuração padrão de Circuit breaker atende à maioria dos casos, mas pode ser sobrescrita por serviço.
