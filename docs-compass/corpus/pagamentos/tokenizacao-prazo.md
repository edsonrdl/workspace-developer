---
id: tokenizacao-prazo
title: Tokenização de cartão - prazo (SLA)
dominio: pagamentos
topico: tokenizacao
resumo: Contém o prazo (SLA) de Tokenização de cartão (guardar cartão do cliente).
aliases: guardar cartão do cliente | cartão salvo parou de funcionar | em quanto tempo | tempo de espera
perguntas: Qual o prazo (SLA) de Tokenização de cartão?
confidence: high
owner: squad-pagamentos
atualizado: 2026-04-22
---
# Tokenização de cartão - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Tokenização de cartão (guardar cartão do cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Exemplos de uso de Tokenização de cartão estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Tokenização de cartão deve ser registrada no backlog do domínio de pagamentos. É importante não confundir Tokenização de cartão com os mecanismos legados, que serão descontinuados. Os riscos conhecidos de Tokenização de cartão estão listados no registro de riscos do domínio de pagamentos. Todas as alterações em Tokenização de cartão passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço. O mecanismo de Tokenização de cartão foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Como funciona

O desenho de Tokenização de cartão considera crescimento de volume de até dez vezes sem mudança estrutural. Exemplos de uso de Tokenização de cartão estão disponíveis no repositório de referência da plataforma. Métricas de Tokenização de cartão são publicadas no painel de observabilidade e acompanhadas semanalmente. O limite de complexidade aceito nos serviços que usam Tokenização de cartão é revisado a cada semestre. Durante a migração para a nova plataforma, Tokenização de cartão foi reescrito sem mudanças de contrato. A documentação de Tokenização de cartão é mantida pela equipe do domínio e revisada em cada release.

## Decisões de arquitetura

A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Tokenização de cartão está ativo antes de cada certificação. Todas as alterações em Tokenização de cartão passam por revisão de pelo menos duas pessoas da equipe. Durante a migração para a nova plataforma, Tokenização de cartão foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Tokenização de cartão é revisado a cada semestre. A implementação de Tokenização de cartão segue o padrão definido pelo comitê de arquitetura no início do ano.

## Boas práticas

A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Tokenização de cartão, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Tokenização de cartão estão disponíveis no repositório de referência da plataforma. O procedimento de auditoria exige evidências de que Tokenização de cartão está ativo antes de cada certificação. O desenho de Tokenização de cartão considera crescimento de volume de até dez vezes sem mudança estrutural.

## Histórico de mudanças

- 2025-01-18: Clientes corporativos podem solicitar ajustes em Tokenização de cartão por meio do gerente de conta.
- 2025-02-12: O procedimento de auditoria exige evidências de que Tokenização de cartão está ativo antes de cada certificação.
- 2025-06-22: Clientes corporativos podem solicitar ajustes em Tokenização de cartão por meio do gerente de conta.
- 2025-07-27: Em ambientes de homologação o comportamento de Tokenização de cartão é idêntico ao de produção, exceto pelos volumes.

## Anexo

O prazo (SLA) de atendimento para Tokenização de cartão é de **22 horas úteis** após a abertura do chamado. O procedimento de auditoria exige evidências de que Tokenização de cartão está ativo antes de cada certificação.
