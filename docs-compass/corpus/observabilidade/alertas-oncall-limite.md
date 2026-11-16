---
id: alertas-oncall-limite
title: Alertas e escala de on-call - limite máximo
dominio: observabilidade
topico: alertas-oncall
resumo: Contém o limite máximo de Alertas e escala de on-call (quem é chamado de madrugada).
aliases: quem é chamado de madrugada | não recebi o alerta do incidente | teto
perguntas: Qual o limite máximo de Alertas e escala de on-call? | teto quem é chamado de madrugada?
confidence: high
owner: squad-observabilidade
atualizado: 2026-02-24
---
# Alertas e escala de on-call - limite máximo

## For future agent

Este doc trata do limite máximo de Alertas e escala de on-call (quem é chamado de madrugada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Clientes corporativos podem solicitar ajustes em Alertas e escala de on-call por meio do gerente de conta. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases. Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade. Antes da adoção de Alertas e escala de on-call, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Como funciona

Os testes automatizados de Alertas e escala de on-call rodam no pipeline de integração contínua a cada commit. A configuração padrão de Alertas e escala de on-call atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. Durante a migração para a nova plataforma, Alertas e escala de on-call foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação. A implementação de Alertas e escala de on-call segue o padrão definido pelo comitê de arquitetura no início do ano.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação. O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. Antes da adoção de Alertas e escala de on-call, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Os testes automatizados de Alertas e escala de on-call rodam no pipeline de integração contínua a cada commit.

## Boas práticas

Métricas de Alertas e escala de on-call são publicadas no painel de observabilidade e acompanhadas semanalmente. Em ambientes de homologação o comportamento de Alertas e escala de on-call é idêntico ao de produção, exceto pelos volumes. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases. Clientes corporativos podem solicitar ajustes em Alertas e escala de on-call por meio do gerente de conta. Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe.

## Histórico de mudanças

- 2025-08-26: Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe.
- 2025-02-13: É importante não confundir Alertas e escala de on-call com os mecanismos legados, que serão descontinuados.
- 2025-02-20: Métricas de Alertas e escala de on-call são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-02-17: Clientes corporativos podem solicitar ajustes em Alertas e escala de on-call por meio do gerente de conta.

## Anexo

O limite máximo configurado para Alertas e escala de on-call em produção é de **559 operações por minuto**, com burst de 1118. Clientes corporativos podem solicitar ajustes em Alertas e escala de on-call por meio do gerente de conta.
