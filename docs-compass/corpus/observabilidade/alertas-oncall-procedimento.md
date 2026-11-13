---
id: alertas-oncall-procedimento
title: Alertas e escala de on-call - runbook de troubleshooting
dominio: observabilidade
topico: alertas-oncall
resumo: Contém o runbook de troubleshooting de Alertas e escala de on-call (quem é chamado de madrugada).
aliases: quem é chamado de madrugada | não recebi o alerta do incidente | ninguém atendeu o plantão | como resolver
perguntas: Qual o runbook de troubleshooting de Alertas e escala de on-call? | como resolver quem é chamado de madrugada?
confidence: high
owner: squad-observabilidade
atualizado: 2026-01-17
---
# Alertas e escala de on-call - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Alertas e escala de on-call (quem é chamado de madrugada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade. A implementação de Alertas e escala de on-call segue o padrão definido pelo comitê de arquitetura no início do ano. A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. Falhas em Alertas e escala de on-call geram eventos que são correlacionados com os logs estruturados do serviço. Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma.

## Como funciona

Em ambientes de homologação o comportamento de Alertas e escala de on-call é idêntico ao de produção, exceto pelos volumes. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. A configuração padrão de Alertas e escala de on-call atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade. Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. Falhas em Alertas e escala de on-call geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Alertas e escala de on-call é revisado a cada semestre.

## Decisões de arquitetura

O desenho de Alertas e escala de on-call considera crescimento de volume de até dez vezes sem mudança estrutural. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. O prazo de implantação das mudanças relacionadas a Alertas e escala de on-call segue o calendário trimestral de releases. A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação. Os riscos conhecidos de Alertas e escala de on-call estão listados no registro de riscos do domínio de observabilidade.

## Boas práticas

A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma. O procedimento de auditoria exige evidências de que Alertas e escala de on-call está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Alertas e escala de on-call deve ser registrada no backlog do domínio de observabilidade. Todas as alterações em Alertas e escala de on-call passam por revisão de pelo menos duas pessoas da equipe. É importante não confundir Alertas e escala de on-call com os mecanismos legados, que serão descontinuados. A implementação de Alertas e escala de on-call segue o padrão definido pelo comitê de arquitetura no início do ano.

## Histórico de mudanças

- 2025-05-16: A documentação de Alertas e escala de on-call é mantida pela equipe do domínio e revisada em cada release.
- 2025-02-20: Antes da adoção de Alertas e escala de on-call, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-07-17: É importante não confundir Alertas e escala de on-call com os mecanismos legados, que serão descontinuados.
- 2025-04-22: Exemplos de uso de Alertas e escala de on-call estão disponíveis no repositório de referência da plataforma.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-367; 2) reiniciar o job `alertasoncall-worker`; 3) abrir incidente se persistir por mais de 11 minutos. O mecanismo de Alertas e escala de on-call foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.
