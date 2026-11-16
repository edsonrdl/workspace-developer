---
id: estorno-prazo
title: Estorno de transações - prazo (SLA)
dominio: pagamentos
topico: estorno
resumo: Contém o prazo (SLA) de Estorno de transações (devolver dinheiro ao cliente).
aliases: devolver dinheiro ao cliente | valor não voltou para a conta do cliente
perguntas: Qual o prazo (SLA) de Estorno de transações?
confidence: high
owner: squad-pagamentos
atualizado: 2026-02-21
---
# Estorno de transações - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Estorno de transações (devolver dinheiro ao cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os testes automatizados de Estorno de transações rodam no pipeline de integração contínua a cada commit. Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes. Métricas de Estorno de transações são publicadas no painel de observabilidade e acompanhadas semanalmente. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural. Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe. A documentação de Estorno de transações é mantida pela equipe do domínio e revisada em cada release.

## Como funciona

Qualquer dúvida de negócio sobre Estorno de transações deve ser registrada no backlog do domínio de pagamentos. Os testes automatizados de Estorno de transações rodam no pipeline de integração contínua a cada commit. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural.

## Decisões de arquitetura

A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Estorno de transações geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Estorno de transações está ativo antes de cada certificação. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta. A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta. Métricas de Estorno de transações são publicadas no painel de observabilidade e acompanhadas semanalmente. Falhas em Estorno de transações geram eventos que são correlacionados com os logs estruturados do serviço. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano.

## Histórico de mudanças

- 2025-05-11: O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.
- 2025-07-16: O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.
- 2025-06-13: Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe.
- 2025-06-12: A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O prazo (SLA) de atendimento para Estorno de transações é de **53 horas úteis** após a abertura do chamado. Qualquer dúvida de negócio sobre Estorno de transações deve ser registrada no backlog do domínio de pagamentos.
