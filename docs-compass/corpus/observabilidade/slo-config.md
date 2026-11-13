---
id: slo-config
title: SLO e error budget - visão geral
dominio: observabilidade
topico: slo
resumo: Contém o parâmetro de configuração de SLO e error budget (meta de disponibilidade).
aliases: meta de disponibilidade | disponibilidade caiu abaixo da meta
perguntas: Qual o parâmetro de configuração de SLO e error budget?
confidence: high
owner: squad-observabilidade
atualizado: 2026-08-26
---
# SLO e error budget - visão geral

## For future agent

Este doc trata do parâmetro de configuração de SLO e error budget (meta de disponibilidade). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir SLO e error budget com os mecanismos legados, que serão descontinuados. Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe. A implementação de SLO e error budget segue o padrão definido pelo comitê de arquitetura no início do ano. A configuração padrão de SLO e error budget atende à maioria dos casos, mas pode ser sobrescrita por serviço. Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Como funciona

A implementação de SLO e error budget segue o padrão definido pelo comitê de arquitetura no início do ano. Exemplos de uso de SLO e error budget estão disponíveis no repositório de referência da plataforma. Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit. É importante não confundir SLO e error budget com os mecanismos legados, que serão descontinuados. O mecanismo de SLO e error budget foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Durante a migração para a nova plataforma, SLO e error budget foi reescrito sem mudanças de contrato.

## Decisões de arquitetura

Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de SLO e error budget foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. O desenho de SLO e error budget considera crescimento de volume de até dez vezes sem mudança estrutural. A implementação de SLO e error budget segue o padrão definido pelo comitê de arquitetura no início do ano. Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release. A configuração padrão de SLO e error budget atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit. Em ambientes de homologação o comportamento de SLO e error budget é idêntico ao de produção, exceto pelos volumes. A implementação de SLO e error budget segue o padrão definido pelo comitê de arquitetura no início do ano.

## Histórico de mudanças

- 2025-06-21: O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases.
- 2025-05-12: Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-06-24: O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases.
- 2025-08-13: A configuração padrão de SLO e error budget atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O parâmetro de configuração é `slo.max_attempts=3` no arquivo `settings-prod.yaml` (valor padrão 467). O procedimento de auditoria exige evidências de que SLO e error budget está ativo antes de cada certificação.
