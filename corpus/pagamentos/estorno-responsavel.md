---
id: estorno-responsavel
title: Estorno de transações - notas
dominio: pagamentos
topico: estorno
resumo: Contém o equipe responsável de Estorno de transações (devolver dinheiro ao cliente).
aliases: devolver dinheiro ao cliente | valor não voltou para a conta do cliente | com quem falar | quem cuida disso
perguntas: Qual o equipe responsável de Estorno de transações? | com quem falar devolver dinheiro ao cliente?
confidence: high
owner: squad-pagamentos
atualizado: 2026-06-20
---
# Estorno de transações - notas

## For future agent

Este doc trata do equipe responsável de Estorno de transações (devolver dinheiro ao cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Estorno de transações estão listados no registro de riscos do domínio de pagamentos. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Estorno de transações segue o calendário trimestral de releases. Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta.

## Como funciona

A documentação de Estorno de transações é mantida pela equipe do domínio e revisada em cada release. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Os testes automatizados de Estorno de transações rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Estorno de transações por meio do gerente de conta. O desenho de Estorno de transações considera crescimento de volume de até dez vezes sem mudança estrutural. Qualquer dúvida de negócio sobre Estorno de transações deve ser registrada no backlog do domínio de pagamentos.

## Decisões de arquitetura

Qualquer dúvida de negócio sobre Estorno de transações deve ser registrada no backlog do domínio de pagamentos. Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe. Os riscos conhecidos de Estorno de transações estão listados no registro de riscos do domínio de pagamentos. A implementação de Estorno de transações segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Estorno de transações com os mecanismos legados, que serão descontinuados. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Boas práticas

Métricas de Estorno de transações são publicadas no painel de observabilidade e acompanhadas semanalmente. O prazo de implantação das mudanças relacionadas a Estorno de transações segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Estorno de transações foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Estorno de transações está ativo antes de cada certificação. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Histórico de mudanças

- 2025-02-20: Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes.
- 2025-07-19: Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma.
- 2025-02-25: O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.
- 2025-06-10: A documentação de Estorno de transações é mantida pela equipe do domínio e revisada em cada release.

## Anexo

A equipe responsável por Estorno de transações é a squad **Atlas**, canal #estorno-suporte (plantão: ramal 626). Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
