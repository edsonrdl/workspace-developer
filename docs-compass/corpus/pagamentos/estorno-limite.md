---
id: estorno-limite
title: Estorno de transações - limite máximo
dominio: pagamentos
topico: estorno
resumo: Contém o limite máximo de Estorno de transações (devolver dinheiro ao cliente).
aliases: devolver dinheiro ao cliente | valor não voltou para a conta do cliente | reembolso não apareceu | teto | quanto aguenta | valor máximo permitido
perguntas: Qual o limite máximo de Estorno de transações? | teto devolver dinheiro ao cliente?
confidence: high
owner: squad-pagamentos
atualizado: 2026-02-21
---
# Estorno de transações - limite máximo

## For future agent

Este doc trata do limite máximo de Estorno de transações (devolver dinheiro ao cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Qualquer dúvida de negócio sobre Estorno de transações deve ser registrada no backlog do domínio de pagamentos. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural. Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.

## Como funciona

Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre. Falhas em Estorno de transações geram eventos que são correlacionados com os logs estruturados do serviço. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Decisões de arquitetura

Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Durante a migração para a nova plataforma, Estorno de transações foi reescrito sem mudanças de contrato. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano.

## Boas práticas

A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Estorno de transações segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Estorno de transações foi reescrito sem mudanças de contrato. É importante não confundir Estorno de transações com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Estorno de transações está ativo antes de cada certificação. A documentação de Estorno de transações é mantida pela equipe do domínio e revisada em cada release.

## Histórico de mudanças

- 2025-05-13: A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-08-13: Os testes automatizados de Estorno de transações rodam no pipeline de integração contínua a cada commit.
- 2025-04-18: A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-06-10: Métricas de Estorno de transações são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

O limite máximo configurado para Estorno de transações em produção é de **897 operações por minuto**, com burst de 1794. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural.
