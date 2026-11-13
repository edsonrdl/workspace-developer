---
id: liquidacao-procedimento
title: Liquidação D+1 - runbook de troubleshooting
dominio: conciliacao
topico: liquidacao
resumo: Contém o runbook de troubleshooting de Liquidação D+1 (quando o dinheiro cai na conta).
aliases: quando o dinheiro cai na conta | dinheiro da venda não caiu ainda | como resolver
perguntas: Qual o runbook de troubleshooting de Liquidação D+1? | como resolver quando o dinheiro cai na conta?
confidence: medium
owner: squad-conciliacao
atualizado: 2026-01-25
---
# Liquidação D+1 - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Liquidação D+1 (quando o dinheiro cai na conta). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta. A documentação de Liquidação D+1 é mantida pela equipe do domínio e revisada em cada release. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Como funciona

O mecanismo de Liquidação D+1 foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. O desenho de Liquidação D+1 considera crescimento de volume de até dez vezes sem mudança estrutural. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta.

## Boas práticas

Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-04-18: Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-06-20: Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes.
- 2025-02-13: O mecanismo de Liquidação D+1 foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao.
- 2025-07-21: Os riscos conhecidos de Liquidação D+1 estão listados no registro de riscos do domínio de conciliacao.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-54; 2) reiniciar o job `liquidacao-worker`; 3) abrir incidente se persistir por mais de 55 minutos. O prazo de implantação das mudanças relacionadas a Liquidação D+1 segue o calendário trimestral de releases.
