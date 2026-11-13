---
id: conciliacao-bancaria-prazo
title: Conciliação bancária - referência
dominio: conciliacao
topico: conciliacao-bancaria
resumo: Contém o prazo (SLA) de Conciliação bancária (bater extrato com as vendas).
aliases: bater extrato com as vendas | diferença no fechamento do dia | em quanto tempo | tempo de espera
perguntas: Qual o prazo (SLA) de Conciliação bancária? | em quanto tempo bater extrato com as vendas?
confidence: high
owner: squad-conciliacao
atualizado: 2026-05-27
---
# Conciliação bancária - referência

## For future agent

Este doc trata do prazo (SLA) de Conciliação bancária (bater extrato com as vendas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O desenho de Conciliação bancária considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de Conciliação bancária é idêntico ao de produção, exceto pelos volumes. Falhas em Conciliação bancária geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Conciliação bancária passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Conciliação bancária atende à maioria dos casos, mas pode ser sobrescrita por serviço. O mecanismo de Conciliação bancária foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao.

## Como funciona

Todas as alterações em Conciliação bancária passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Conciliação bancária, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Conciliação bancária é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de Conciliação bancária estão disponíveis no repositório de referência da plataforma. O procedimento de auditoria exige evidências de que Conciliação bancária está ativo antes de cada certificação.

## Decisões de arquitetura

Exemplos de uso de Conciliação bancária estão disponíveis no repositório de referência da plataforma. O prazo de implantação das mudanças relacionadas a Conciliação bancária segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Conciliação bancária foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Conciliação bancária está ativo antes de cada certificação. O desenho de Conciliação bancária considera crescimento de volume de até dez vezes sem mudança estrutural.

## Boas práticas

Métricas de Conciliação bancária são publicadas no painel de observabilidade e acompanhadas semanalmente. Antes da adoção de Conciliação bancária, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Conciliação bancária é idêntico ao de produção, exceto pelos volumes. Durante a migração para a nova plataforma, Conciliação bancária foi reescrito sem mudanças de contrato. Os testes automatizados de Conciliação bancária rodam no pipeline de integração contínua a cada commit. O mecanismo de Conciliação bancária foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. A configuração padrão de Conciliação bancária atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Histórico de mudanças

- 2025-05-24: A implementação de Conciliação bancária segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-03-24: Qualquer dúvida de negócio sobre Conciliação bancária deve ser registrada no backlog do domínio de conciliacao.
- 2025-03-17: Antes da adoção de Conciliação bancária, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-08-27: Durante a migração para a nova plataforma, Conciliação bancária foi reescrito sem mudanças de contrato.

## Anexo

O prazo (SLA) de atendimento para Conciliação bancária é de **39 horas úteis** após a abertura do chamado. O mecanismo de Conciliação bancária foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao.
