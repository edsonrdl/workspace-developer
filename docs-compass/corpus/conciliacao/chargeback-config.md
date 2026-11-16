---
id: chargeback-config
title: Chargeback - parâmetro de configuração
dominio: conciliacao
topico: chargeback
resumo: Contém o parâmetro de configuração de Chargeback (contestação de compra).
aliases: contestação de compra | onde configuro | como ajustar
perguntas: Qual o parâmetro de configuração de Chargeback? | onde configuro contestação de compra?
confidence: high
owner: squad-conciliacao
atualizado: 2026-02-18
---
# Chargeback - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Chargeback (contestação de compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Chargeback estão listados no registro de riscos do domínio de conciliacao. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. Métricas de Chargeback são publicadas no painel de observabilidade e acompanhadas semanalmente. A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço. A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes.

## Como funciona

A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano. A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit. A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço. Métricas de Chargeback são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Decisões de arquitetura

Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases. O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural.

## Boas práticas

Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-07-26: O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-04-26: Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato.
- 2025-08-27: Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes.
- 2025-06-13: Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta.

## Anexo

O parâmetro de configuração é `chargeback.max_attempts=28` no arquivo `settings-prod.yaml` (valor padrão 596). Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato.
