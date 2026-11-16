---
id: liquidacao-limite
title: Liquidação D+1 - limite máximo
dominio: conciliacao
topico: liquidacao
resumo: Contém o limite máximo de Liquidação D+1 (quando o dinheiro cai na conta).
aliases: quando o dinheiro cai na conta | data de recebimento das vendas | repasse atrasou | teto | valor máximo permitido
perguntas: Qual o limite máximo de Liquidação D+1?
confidence: high
owner: squad-conciliacao
atualizado: 2026-02-16
---
# Liquidação D+1 - limite máximo

## For future agent

Este doc trata do limite máximo de Liquidação D+1 (quando o dinheiro cai na conta). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural. Os testes automatizados de Liquidação D+1 rodam no pipeline de integração contínua a cada commit. Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta.

## Como funciona

O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural. Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Liquidação D+1 é revisado a cada semestre. Os riscos conhecidos de Liquidação D+1 estão listados no registro de riscos do domínio de conciliacao. Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Decisões de arquitetura

Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. O prazo de implantação das mudanças relacionadas a Liquidação D+1 segue o calendário trimestral de releases. Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente. O mecanismo de Liquidação D+1 foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao.

## Boas práticas

A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço. Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Liquidação D+1 é revisado a cada semestre. Todas as alterações em Liquidação D+1 passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Liquidação D+1 deve ser registrada no backlog do domínio de conciliacao. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço.

## Histórico de mudanças

- 2025-01-12: Todas as alterações em Liquidação D+1 passam por revisão de pelo menos duas pessoas da equipe.
- 2025-07-27: A documentação de Liquidação D+1 é mantida pela equipe do domínio e revisada em cada release.
- 2025-07-23: O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-05-14: Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato.

## Anexo

O limite máximo configurado para Liquidação D+1 em produção é de **435 operações por minuto**, com burst de 870. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes.
