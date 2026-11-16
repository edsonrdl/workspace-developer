---
id: idempotencia-limite
title: Idempotência de requisições - limite máximo
dominio: pagamentos
topico: idempotencia
resumo: Contém o limite máximo de Idempotência de requisições (evitar cobrança duplicada).
aliases: evitar cobrança duplicada | garantir que o pedido não seja processado duas vezes | cliente foi cobrado duas vezes | teto | quanto aguenta
perguntas: Qual o limite máximo de Idempotência de requisições? | teto evitar cobrança duplicada?
confidence: high
owner: squad-pagamentos
atualizado: 2026-03-19
---
# Idempotência de requisições - limite máximo

## For future agent

Este doc trata do limite máximo de Idempotência de requisições (evitar cobrança duplicada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O prazo de implantação das mudanças relacionadas a Idempotência de requisições segue o calendário trimestral de releases. Os riscos conhecidos de Idempotência de requisições estão listados no registro de riscos do domínio de pagamentos. Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. O desenho de Idempotência de requisições considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de Idempotência de requisições é idêntico ao de produção, exceto pelos volumes. Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Idempotência de requisições está ativo antes de cada certificação. Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato. Os riscos conhecidos de Idempotência de requisições estão listados no registro de riscos do domínio de pagamentos. Todas as alterações em Idempotência de requisições passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release.

## Boas práticas

Os riscos conhecidos de Idempotência de requisições estão listados no registro de riscos do domínio de pagamentos. A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-08-27: O limite de complexidade aceito nos serviços que usam Idempotência de requisições é revisado a cada semestre.
- 2025-06-12: A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-04-15: Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma.
- 2025-02-12: É importante não confundir Idempotência de requisições com os mecanismos legados, que serão descontinuados.

## Anexo

O limite máximo configurado para Idempotência de requisições em produção é de **674 operações por minuto**, com burst de 1348. Clientes corporativos podem solicitar ajustes em Idempotência de requisições por meio do gerente de conta.
