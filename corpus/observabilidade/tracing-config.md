---
id: tracing-config
title: Guia operacional observabilidade nº94
dominio: observabilidade
topico: tracing
resumo: Contém o parâmetro de configuração de Tracing distribuído (seguir uma requisição entre serviços).
aliases: seguir uma requisição entre serviços | ver por onde a chamada passou | não acho onde a requisição demorou | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Tracing distribuído? | onde configuro seguir uma requisição entre serviços?
confidence: high
owner: squad-observabilidade
atualizado: 2026-07-17
---
# Guia operacional observabilidade nº94

## For future agent

Este doc trata do parâmetro de configuração de Tracing distribuído (seguir uma requisição entre serviços). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A documentação de Tracing distribuído é mantida pela equipe do domínio e revisada em cada release. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta.

## Como funciona

Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes. Métricas de Tracing distribuído são publicadas no painel de observabilidade e acompanhadas semanalmente. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta.

## Decisões de arquitetura

Métricas de Tracing distribuído são publicadas no painel de observabilidade e acompanhadas semanalmente. É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano.

## Boas práticas

Métricas de Tracing distribuído são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta. O procedimento de auditoria exige evidências de que Tracing distribuído está ativo antes de cada certificação. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço.

## Histórico de mudanças

- 2025-01-18: Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-08-22: Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato.
- 2025-04-11: Os testes automatizados de Tracing distribuído rodam no pipeline de integração contínua a cada commit.
- 2025-04-17: A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano.

## Anexo

O parâmetro de configuração é `tracing.max_attempts=54` no arquivo `settings-prod.yaml` (valor padrão 702). Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
