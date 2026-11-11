---
id: tracing-responsavel
title: Tracing distribuído - visão geral
dominio: observabilidade
topico: tracing
resumo: Contém o equipe responsável de Tracing distribuído (seguir uma requisição entre serviços).
aliases: seguir uma requisição entre serviços | não acho onde a requisição demorou | lentidão sem saber qual serviço causou | com quem falar | a quem pedir ajuda
perguntas: Qual o equipe responsável de Tracing distribuído?
confidence: high
owner: squad-observabilidade
atualizado: 2026-01-11
---
# Tracing distribuído - visão geral

## For future agent

Este doc trata do equipe responsável de Tracing distribuído (seguir uma requisição entre serviços). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. A documentação de Tracing distribuído é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. O procedimento de auditoria exige evidências de que Tracing distribuído está ativo antes de cada certificação.

## Como funciona

O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. Exemplos de uso de Tracing distribuído estão disponíveis no repositório de referência da plataforma. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Tracing distribuído está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade. Métricas de Tracing distribuído são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. Exemplos de uso de Tracing distribuído estão disponíveis no repositório de referência da plataforma. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. O desenho de Tracing distribuído considera crescimento de volume de até dez vezes sem mudança estrutural.

## Histórico de mudanças

- 2025-01-21: O prazo de implantação das mudanças relacionadas a Tracing distribuído segue o calendário trimestral de releases.
- 2025-08-20: A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-02-26: A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-01-22: Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço.

## Anexo

A equipe responsável por Tracing distribuído é a squad **Atlas**, canal #tracing-suporte (plantão: ramal 899). É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados.
