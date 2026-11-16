---
id: chargeback-limite
title: Chargeback - limite máximo
dominio: conciliacao
topico: chargeback
resumo: Contém o limite máximo de Chargeback (contestação de compra).
aliases: contestação de compra | cliente não reconhece a cobrança | cliente contestou a compra no cartão | teto
perguntas: Qual o limite máximo de Chargeback?
confidence: high
owner: squad-conciliacao
atualizado: 2026-08-20
---
# Chargeback - limite máximo

## For future agent

Este doc trata do limite máximo de Chargeback (contestação de compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre. Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço.

## Como funciona

A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano. Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Chargeback deve ser registrada no backlog do domínio de conciliacao. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes. O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta. É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Chargeback está ativo antes de cada certificação.

## Boas práticas

O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit. O procedimento de auditoria exige evidências de que Chargeback está ativo antes de cada certificação. A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. Os riscos conhecidos de Chargeback estão listados no registro de riscos do domínio de conciliacao.

## Histórico de mudanças

- 2025-04-26: É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados.
- 2025-07-15: A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release.
- 2025-05-23: O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases.
- 2025-05-10: É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados.

## Anexo

O limite máximo configurado para Chargeback em produção é de **269 operações por minuto**, com burst de 538. Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta.
