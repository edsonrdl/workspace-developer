---
id: tracing-prazo
title: Tracing distribuído - visão geral
dominio: observabilidade
topico: tracing
resumo: Contém o prazo (SLA) de Tracing distribuído (seguir uma requisição entre serviços).
aliases: seguir uma requisição entre serviços | lentidão sem saber qual serviço causou | em quanto tempo | tempo de espera
perguntas: Qual o prazo (SLA) de Tracing distribuído?
confidence: high
owner: squad-observabilidade
atualizado: 2026-05-17
---
# Tracing distribuído - visão geral

## For future agent

Este doc trata do prazo (SLA) de Tracing distribuído (seguir uma requisição entre serviços). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano. Os testes automatizados de Tracing distribuído rodam no pipeline de integração contínua a cada commit.

## Como funciona

Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade. A documentação de Tracing distribuído é mantida pela equipe do domínio e revisada em cada release.

## Decisões de arquitetura

A documentação de Tracing distribuído é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. Métricas de Tracing distribuído são publicadas no painel de observabilidade e acompanhadas semanalmente. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes.

## Boas práticas

É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados. Exemplos de uso de Tracing distribuído estão disponíveis no repositório de referência da plataforma. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Os testes automatizados de Tracing distribuído rodam no pipeline de integração contínua a cada commit. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade.

## Histórico de mudanças

- 2025-02-12: Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato.
- 2025-06-19: É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados.
- 2025-02-15: Exemplos de uso de Tracing distribuído estão disponíveis no repositório de referência da plataforma.
- 2025-08-25: Exemplos de uso de Tracing distribuído estão disponíveis no repositório de referência da plataforma.

## Anexo

O prazo (SLA) de atendimento para Tracing distribuído é de **12 horas úteis** após a abertura do chamado. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes.
