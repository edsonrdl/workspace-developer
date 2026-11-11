---
id: estorno-config
title: Estorno de transações - notas
dominio: pagamentos
topico: estorno
resumo: Contém o parâmetro de configuração de Estorno de transações (devolver dinheiro ao cliente).
aliases: devolver dinheiro ao cliente | reembolso não apareceu | onde configuro | como ajustar
perguntas: Qual o parâmetro de configuração de Estorno de transações? | onde configuro devolver dinheiro ao cliente?
confidence: high
owner: squad-pagamentos
atualizado: 2026-06-23
---
# Estorno de transações - notas

## For future agent

Este doc trata do parâmetro de configuração de Estorno de transações (devolver dinheiro ao cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe.

## Como funciona

Os testes automatizados de Estorno de transações rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta. A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. É importante não confundir Estorno de transações com os mecanismos legados, que serão descontinuados. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Durante a migração para a nova plataforma, Estorno de transações foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.

## Boas práticas

A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre. A documentação de Estorno de transações é mantida pela equipe do domínio e revisada em cada release. Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe. É importante não confundir Estorno de transações com os mecanismos legados, que serão descontinuados.

## Histórico de mudanças

- 2025-05-27: Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta.
- 2025-01-20: Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta.
- 2025-07-26: Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma.
- 2025-05-23: Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes.

## Anexo

O parâmetro de configuração é `estorno.max_attempts=61` no arquivo `settings-prod.yaml` (valor padrão 843). Os riscos conhecidos de Estorno de transações estão listados no registro de riscos do domínio de pagamentos.
