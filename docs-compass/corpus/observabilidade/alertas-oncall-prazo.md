---
id: alertas-oncall-prazo
title: Alertas e escala de on-call - visão geral
dominio: observabilidade
topico: alertas-oncall
resumo: Contém o prazo (SLA) de Alertas e escala de on-call (quem é chamado de madrugada).
aliases: quem é chamado de madrugada | não recebi o alerta do incidente
perguntas: Qual o prazo (SLA) de Alertas e escala de on-call? | em quanto tempo quem é chamado de madrugada?
confidence: high
owner: squad-observabilidade
atualizado: 2026-05-21
---
# Alertas e escala de on-call - visão geral

## For future agent

Este doc trata do prazo (SLA) de Alertas e escala de on-call (quem é chamado de madrugada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Antes da adoção de Alertas e escala de on-call, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade. Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma.

## Como funciona

O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. A configuração padrão de Alertas e escala de on-call atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade. A implementação de Alertas e escala de on-call segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases. É importante não confundir Alertas e escala de on-call com os mecanismos legados, que serão descontinuados. Durante a migração para a nova plataforma, Alertas e escala de on-call foi reescrito sem mudanças de contrato.

## Decisões de arquitetura

Em ambientes de homologação o comportamento de Alertas e escala de on-call é idêntico ao de produção, exceto pelos volumes. Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade. O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases. É importante não confundir Alertas e escala de on-call com os mecanismos legados, que serão descontinuados.

## Boas práticas

A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases. Métricas de Alertas e escala de on-call são publicadas no painel de observabilidade e acompanhadas semanalmente. Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade. Falhas em Alertas e escala de on-call geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-04-25: Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade.
- 2025-06-16: Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade.
- 2025-07-20: O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre.
- 2025-02-23: Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe.

## Anexo

O prazo (SLA) de atendimento para Alertas e escala de on-call é de **50 horas úteis** após a abertura do chamado. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação.
