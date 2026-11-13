---
id: chargeback-responsavel
title: Chargeback - equipe responsável
dominio: conciliacao
topico: chargeback
resumo: Contém o equipe responsável de Chargeback (contestação de compra).
aliases: contestação de compra | cliente não reconhece a cobrança | com quem falar | quem cuida disso
perguntas: Qual o equipe responsável de Chargeback?
confidence: high
owner: squad-conciliacao
atualizado: 2026-05-16
---
# Chargeback - equipe responsável

## For future agent

Este doc trata do equipe responsável de Chargeback (contestação de compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Qualquer dúvida de negócio sobre Chargeback deve ser registrada no backlog do domínio de conciliacao. Métricas de Chargeback são publicadas no painel de observabilidade e acompanhadas semanalmente. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit.

## Como funciona

Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço. É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Chargeback está ativo antes de cada certificação. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano.

## Decisões de arquitetura

O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. Métricas de Chargeback são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta. O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes. Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release.

## Histórico de mudanças

- 2025-01-12: Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta.
- 2025-04-24: Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes.
- 2025-08-20: É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados.
- 2025-04-19: Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato.

## Anexo

A equipe responsável por Chargeback é a squad **Titan**, canal #chargeback-suporte (plantão: ramal 970). Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
