---
id: idempotencia-responsavel
title: Idempotência de requisições - equipe responsável
dominio: pagamentos
topico: idempotencia
resumo: Contém o equipe responsável de Idempotência de requisições (evitar cobrança duplicada).
aliases: evitar cobrança duplicada | cliente foi cobrado duas vezes | com quem falar | a quem pedir ajuda
perguntas: Qual o equipe responsável de Idempotência de requisições?
confidence: high
owner: squad-pagamentos
atualizado: 2026-01-11
---
# Idempotência de requisições - equipe responsável

## For future agent

Este doc trata do equipe responsável de Idempotência de requisições (evitar cobrança duplicada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Antes da adoção de Idempotência de requisições, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço. O prazo de implantação das mudanças relacionadas a Idempotência de requisições segue o calendário trimestral de releases. A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano. Qualquer dúvida de negócio sobre Idempotência de requisições deve ser registrada no backlog do domínio de pagamentos.

## Como funciona

O limite de complexidade aceito nos serviços que usam Idempotência de requisições é revisado a cada semestre. Em ambientes de homologação o comportamento de Idempotência de requisições é idêntico ao de produção, exceto pelos volumes. O desenho de Idempotência de requisições considera crescimento de volume de até dez vezes sem mudança estrutural. Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma. Os testes automatizados de Idempotência de requisições rodam no pipeline de integração contínua a cada commit.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Idempotência de requisições está ativo antes de cada certificação. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Clientes corporativos podem solicitar ajustes em Idempotência de requisições por meio do gerente de conta. Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato. Todas as alterações em Idempotência de requisições passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Boas práticas

A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Idempotência de requisições com os mecanismos legados, que serão descontinuados. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam Idempotência de requisições é revisado a cada semestre.

## Histórico de mudanças

- 2025-06-27: Qualquer dúvida de negócio sobre Idempotência de requisições deve ser registrada no backlog do domínio de pagamentos.
- 2025-02-15: Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-07-22: O limite de complexidade aceito nos serviços que usam Idempotência de requisições é revisado a cada semestre.
- 2025-05-23: Em ambientes de homologação o comportamento de Idempotência de requisições é idêntico ao de produção, exceto pelos volumes.

## Anexo

A equipe responsável por Idempotência de requisições é a squad **Aurora**, canal #idempotencia-suporte (plantão: ramal 712). Os riscos conhecidos de Idempotência de requisições estão listados no registro de riscos do domínio de pagamentos.
