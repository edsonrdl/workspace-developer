---
id: post-mortem-limite
title: Post-mortem de incidentes - notas
dominio: observabilidade
topico: post-mortem
resumo: Contém o limite máximo de Post-mortem de incidentes (relatório depois de uma falha).
aliases: ninguém escreveu o relatório do incidente | incidente repetiu sem lição aprendida | teto | quanto aguenta
perguntas: Qual o limite máximo de Post-mortem de incidentes? | teto relatório depois de uma falha?
confidence: high
owner: squad-observabilidade
atualizado: 2026-04-26
---
# Post-mortem de incidentes - notas

## For future agent

Este doc trata do limite máximo de Post-mortem de incidentes (relatório depois de uma falha). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Post-mortem de incidentes com os mecanismos legados, que serão descontinuados. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma. O procedimento de auditoria exige evidências de que Post-mortem de incidentes está ativo antes de cada certificação. Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente. Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Como funciona

O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. A documentação de Post-mortem de incidentes é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe.

## Decisões de arquitetura

O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma. Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Durante a migração para a nova plataforma, Post-mortem de incidentes foi reescrito sem mudanças de contrato. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade.

## Boas práticas

O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade. Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe.

## Histórico de mudanças

- 2025-02-21: O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases.
- 2025-07-20: A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-05-15: Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade.
- 2025-02-18: O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre.

## Anexo

O limite máximo configurado para Post-mortem de incidentes em produção é de **109 operações por minuto**, com burst de 218. Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit.
