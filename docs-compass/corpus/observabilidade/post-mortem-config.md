---
id: post-mortem-config
title: Guia operacional observabilidade nº99
dominio: observabilidade
topico: post-mortem
resumo: Contém o parâmetro de configuração de Post-mortem de incidentes (relatório depois de uma falha).
aliases: relatório depois de uma falha | incidente repetiu sem lição aprendida | onde configuro | como ajustar
perguntas: Qual o parâmetro de configuração de Post-mortem de incidentes?
confidence: high
owner: squad-observabilidade
atualizado: 2026-03-14
---
# Guia operacional observabilidade nº99

## For future agent

Este doc trata do parâmetro de configuração de Post-mortem de incidentes (relatório depois de uma falha). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. O procedimento de auditoria exige evidências de que Post-mortem de incidentes está ativo antes de cada certificação. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta. Falhas em Post-mortem de incidentes geram eventos que são correlacionados com os logs estruturados do serviço. O desenho de Post-mortem de incidentes considera crescimento de volume de até dez vezes sem mudança estrutural. Durante a migração para a nova plataforma, Post-mortem de incidentes foi reescrito sem mudanças de contrato.

## Como funciona

O procedimento de auditoria exige evidências de que Post-mortem de incidentes está ativo antes de cada certificação. Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta. O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit.

## Decisões de arquitetura

Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma. O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Todas as alterações em Post-mortem de incidentes passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Post-mortem de incidentes deve ser registrada no backlog do domínio de observabilidade. Os riscos conhecidos de Post-mortem de incidentes estão listados no registro de riscos do domínio de observabilidade.

## Boas práticas

Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente. Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma. O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta.

## Histórico de mudanças

- 2025-03-25: A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-04-16: Durante a migração para a nova plataforma, Post-mortem de incidentes foi reescrito sem mudanças de contrato.
- 2025-03-22: Qualquer dúvida de negócio sobre Post-mortem de incidentes deve ser registrada no backlog do domínio de observabilidade.
- 2025-07-12: Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes.

## Anexo

O parâmetro de configuração é `postmortem.max_attempts=39` no arquivo `settings-prod.yaml` (valor padrão 377). O desenho de Post-mortem de incidentes considera crescimento de volume de até dez vezes sem mudança estrutural.
