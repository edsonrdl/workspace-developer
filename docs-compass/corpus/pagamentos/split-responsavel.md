---
id: split-responsavel
title: Guia operacional pagamentos nº13
dominio: pagamentos
topico: split
resumo: Contém o equipe responsável de Split de pagamento (dividir o valor entre lojistas).
aliases: dividir o valor entre lojistas | repartir a venda entre vários recebedores | repasse veio com valor errado
perguntas: Qual o equipe responsável de Split de pagamento?
confidence: high
owner: squad-pagamentos
atualizado: 2026-01-24
---
# Guia operacional pagamentos nº13

## For future agent

Este doc trata do equipe responsável de Split de pagamento (dividir o valor entre lojistas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Métricas de Split de pagamento são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato. Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os riscos conhecidos de Split de pagamento estão listados no registro de riscos do domínio de pagamentos.

## Como funciona

A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos. Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. O limite de complexidade aceito nos serviços que usam Split de pagamento é revisado a cada semestre. O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Decisões de arquitetura

É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados. Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. Falhas em Split de pagamento geram eventos que são correlacionados com os logs estruturados do serviço. O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Boas práticas

O desenho de Split de pagamento considera crescimento de volume de até dez vezes sem mudança estrutural. Falhas em Split de pagamento geram eventos que são correlacionados com os logs estruturados do serviço. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. Métricas de Split de pagamento são publicadas no painel de observabilidade e acompanhadas semanalmente. A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe.

## Histórico de mudanças

- 2025-03-11: Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe.
- 2025-03-16: Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-06-14: Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe.
- 2025-05-22: O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação.

## Anexo

A equipe responsável por Split de pagamento é a squad **Zenith**, canal #split-suporte (plantão: ramal 874). O limite de complexidade aceito nos serviços que usam Split de pagamento é revisado a cada semestre.
