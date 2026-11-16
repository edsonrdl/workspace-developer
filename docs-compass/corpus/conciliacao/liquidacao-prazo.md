---
id: liquidacao-prazo
title: Liquidação D+1 - prazo (SLA)
dominio: conciliacao
topico: liquidacao
resumo: Contém o prazo (SLA) de Liquidação D+1 (quando o dinheiro cai na conta).
aliases: quando o dinheiro cai na conta | em quanto tempo | quando fica pronto
perguntas: Qual o prazo (SLA) de Liquidação D+1? | em quanto tempo quando o dinheiro cai na conta?
confidence: high
owner: squad-conciliacao
atualizado: 2026-01-16
---
# Liquidação D+1 - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Liquidação D+1 (quando o dinheiro cai na conta). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Todas as alterações em Liquidação D+1 passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre Liquidação D+1 deve ser registrada no backlog do domínio de conciliacao. O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta.

## Como funciona

O mecanismo de Liquidação D+1 foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. Qualquer dúvida de negócio sobre Liquidação D+1 deve ser registrada no backlog do domínio de conciliacao. A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural.

## Decisões de arquitetura

Todas as alterações em Liquidação D+1 passam por revisão de pelo menos duas pessoas da equipe. Os riscos conhecidos de Liquidação D+1 estão listados no registro de riscos do domínio de conciliacao. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Liquidação D+1 segue o calendário trimestral de releases. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço.

## Boas práticas

Os riscos conhecidos de Liquidação D+1 estão listados no registro de riscos do domínio de conciliacao. A documentação de Liquidação D+1 é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Liquidação D+1 é revisado a cada semestre. Todas as alterações em Liquidação D+1 passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Histórico de mudanças

- 2025-07-17: Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-01-14: Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato.
- 2025-06-16: Qualquer dúvida de negócio sobre Liquidação D+1 deve ser registrada no backlog do domínio de conciliacao.
- 2025-05-15: É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados.

## Anexo

O prazo (SLA) de atendimento para Liquidação D+1 é de **18 horas úteis** após a abertura do chamado. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta.
