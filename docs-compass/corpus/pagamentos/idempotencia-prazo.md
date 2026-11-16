---
id: idempotencia-prazo
title: Idempotência de requisições - referência
dominio: pagamentos
topico: idempotencia
resumo: Contém o prazo (SLA) de Idempotência de requisições (evitar cobrança duplicada).
aliases: evitar cobrança duplicada | garantir que o pedido não seja processado duas vezes | cliente foi cobrado duas vezes | em quanto tempo | tempo de espera
perguntas: Qual o prazo (SLA) de Idempotência de requisições?
confidence: high
owner: squad-pagamentos
atualizado: 2026-01-13
---
# Idempotência de requisições - referência

## For future agent

Este doc trata do prazo (SLA) de Idempotência de requisições (evitar cobrança duplicada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Qualquer dúvida de negócio sobre Idempotência de requisições deve ser registrada no backlog do domínio de pagamentos. É importante não confundir Idempotência de requisições com os mecanismos legados, que serão descontinuados. Os testes automatizados de Idempotência de requisições rodam no pipeline de integração contínua a cada commit.

## Como funciona

Todas as alterações em Idempotência de requisições passam por revisão de pelo menos duas pessoas da equipe. O procedimento de auditoria exige evidências de que Idempotência de requisições está ativo antes de cada certificação. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente. É importante não confundir Idempotência de requisições com os mecanismos legados, que serão descontinuados. Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato. A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano.

## Decisões de arquitetura

Em ambientes de homologação o comportamento de Idempotência de requisições é idêntico ao de produção, exceto pelos volumes. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. Falhas em Idempotência de requisições geram eventos que são correlacionados com os logs estruturados do serviço. Os testes automatizados de Idempotência de requisições rodam no pipeline de integração contínua a cada commit. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente. Antes da adoção de Idempotência de requisições, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma.

## Boas práticas

O desenho de Idempotência de requisições considera crescimento de volume de até dez vezes sem mudança estrutural. Qualquer dúvida de negócio sobre Idempotência de requisições deve ser registrada no backlog do domínio de pagamentos. Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente. A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Histórico de mudanças

- 2025-07-25: Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma.
- 2025-08-26: Em ambientes de homologação o comportamento de Idempotência de requisições é idêntico ao de produção, exceto pelos volumes.
- 2025-08-27: O prazo de implantação das mudanças relacionadas a Idempotência de requisições segue o calendário trimestral de releases.
- 2025-05-13: Durante a migração para a nova plataforma, Idempotência de requisições foi reescrito sem mudanças de contrato.

## Anexo

O prazo (SLA) de atendimento para Idempotência de requisições é de **71 horas úteis** após a abertura do chamado. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente.
