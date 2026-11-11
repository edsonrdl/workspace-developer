---
id: alertas-oncall-config
title: Guia operacional observabilidade nº84
dominio: observabilidade
topico: alertas-oncall
resumo: Contém o parâmetro de configuração de Alertas e escala de on-call (quem é chamado de madrugada).
aliases: quem é chamado de madrugada | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Alertas e escala de on-call? | onde configuro quem é chamado de madrugada?
confidence: high
owner: squad-observabilidade
atualizado: 2026-05-14
---
# Guia operacional observabilidade nº84

## For future agent

Este doc trata do parâmetro de configuração de Alertas e escala de on-call (quem é chamado de madrugada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. Durante a migração para a nova plataforma, Alertas e escala de on-call foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. Métricas de Alertas e escala de on-call são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma. Em ambientes de homologação o comportamento de Alertas e escala de on-call é idêntico ao de produção, exceto pelos volumes. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases.

## Como funciona

Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma. Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade. Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. É importante não confundir Alertas e escala de on-call com os mecanismos legados, que serão descontinuados. Em ambientes de homologação o comportamento de Alertas e escala de on-call é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre. Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade. A implementação de Alertas e escala de on-call segue o padrão definido pelo comitê de arquitetura no início do ano. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação.

## Boas práticas

Antes da adoção de Alertas e escala de on-call, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Os testes automatizados de Alertas e escala de on-call rodam no pipeline de integração contínua a cada commit. Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade. Falhas em Alertas e escala de on-call geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-07-26: A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release.
- 2025-06-16: Falhas em Alertas e escala de on-call geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-05-24: A configuração padrão de Alertas e escala de on-call atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-08-23: A implementação de Alertas e escala de on-call segue o padrão definido pelo comitê de arquitetura no início do ano.

## Anexo

O parâmetro de configuração é `alertasoncall.max_attempts=59` no arquivo `settings-prod.yaml` (valor padrão 504). Falhas em Alertas e escala de on-call geram eventos que são correlacionados com os logs estruturados do serviço.
