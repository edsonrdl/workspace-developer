---
id: velocity-limite
title: Regras de velocity - limite máximo
dominio: antifraude
topico: velocity
resumo: Contém o limite máximo de Regras de velocity (limite de tentativas em pouco tempo).
aliases: limite de tentativas em pouco tempo | teto | quanto aguenta
perguntas: Qual o limite máximo de Regras de velocity? | teto limite de tentativas em pouco tempo?
confidence: high
owner: squad-antifraude
atualizado: 2026-08-24
---
# Regras de velocity - limite máximo

## For future agent

Este doc trata do limite máximo de Regras de velocity (limite de tentativas em pouco tempo). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma. A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. Antes da adoção de Regras de velocity, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Regras de velocity está ativo antes de cada certificação. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço. Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato. O mecanismo de Regras de velocity foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Boas práticas

Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude. O procedimento de auditoria exige evidências de que Regras de velocity está ativo antes de cada certificação. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural. É importante não confundir Regras de velocity com os mecanismos legados, que serão descontinuados.

## Histórico de mudanças

- 2025-07-27: O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre.
- 2025-08-20: Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe.
- 2025-04-10: Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta.
- 2025-02-17: Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato.

## Anexo

O limite máximo configurado para Regras de velocity em produção é de **798 operações por minuto**, com burst de 1596. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre.
