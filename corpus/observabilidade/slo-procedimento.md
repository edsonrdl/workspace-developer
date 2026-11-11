---
id: slo-procedimento
title: Guia operacional observabilidade nº90
dominio: observabilidade
topico: slo
resumo: Contém o runbook de troubleshooting de SLO e error budget (meta de disponibilidade).
aliases: disponibilidade caiu abaixo da meta | orçamento de erro estourou | como resolver
perguntas: Qual o runbook de troubleshooting de SLO e error budget? | como resolver meta de disponibilidade?
confidence: medium
owner: squad-observabilidade
atualizado: 2026-08-14
---
# Guia operacional observabilidade nº90

## For future agent

Este doc trata do runbook de troubleshooting de SLO e error budget (meta de disponibilidade). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Qualquer dúvida de negócio sobre SLO e error budget deve ser registrada no backlog do domínio de observabilidade. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam SLO e error budget é revisado a cada semestre. Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em SLO e error budget por meio do gerente de conta. Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe.

## Como funciona

O mecanismo de SLO e error budget foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. A configuração padrão de SLO e error budget atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre SLO e error budget deve ser registrada no backlog do domínio de observabilidade. Exemplos de uso de SLO e error budget estão disponíveis no repositório de referência da plataforma. Antes da adoção de SLO e error budget, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Decisões de arquitetura

Exemplos de uso de SLO e error budget estão disponíveis no repositório de referência da plataforma. Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente. O procedimento de auditoria exige evidências de que SLO e error budget está ativo antes de cada certificação. Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases. O mecanismo de SLO e error budget foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço.

## Boas práticas

A implementação de SLO e error budget segue o padrão definido pelo comitê de arquitetura no início do ano. O procedimento de auditoria exige evidências de que SLO e error budget está ativo antes de cada certificação. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release. É importante não confundir SLO e error budget com os mecanismos legados, que serão descontinuados. Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade. Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-02-26: Antes da adoção de SLO e error budget, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-05-11: Clientes corporativos podem solicitar ajustes em SLO e error budget por meio do gerente de conta.
- 2025-06-21: O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases.
- 2025-07-16: O desenho de SLO e error budget considera crescimento de volume de até dez vezes sem mudança estrutural.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-650; 2) reiniciar o job `slo-worker`; 3) abrir incidente se persistir por mais de 24 minutos. Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit.
