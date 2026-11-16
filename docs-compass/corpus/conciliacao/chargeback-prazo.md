---
id: chargeback-prazo
title: Chargeback - prazo (SLA)
dominio: conciliacao
topico: chargeback
resumo: Contém o prazo (SLA) de Chargeback (contestação de compra).
aliases: contestação de compra | cliente contestou a compra no cartão | tempo de espera | quando fica pronto
perguntas: Qual o prazo (SLA) de Chargeback? | em quanto tempo contestação de compra?
confidence: high
owner: squad-conciliacao
atualizado: 2026-02-14
---
# Chargeback - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Chargeback (contestação de compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit. Qualquer dúvida de negócio sobre Chargeback deve ser registrada no backlog do domínio de conciliacao. É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

Os riscos conhecidos de Chargeback estão listados no registro de riscos do domínio de conciliacao. Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta. A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço. A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases. Exemplos de uso de Chargeback estão disponíveis no repositório de referência da plataforma.

## Decisões de arquitetura

A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases. Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural. Os riscos conhecidos de Chargeback estão listados no registro de riscos do domínio de conciliacao. Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço.

## Boas práticas

Exemplos de uso de Chargeback estão disponíveis no repositório de referência da plataforma. Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço. O mecanismo de Chargeback foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Qualquer dúvida de negócio sobre Chargeback deve ser registrada no backlog do domínio de conciliacao. Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Histórico de mudanças

- 2025-03-24: Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit.
- 2025-08-12: Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-01-10: Os testes automatizados de Chargeback rodam no pipeline de integração contínua a cada commit.
- 2025-01-17: Métricas de Chargeback são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

O prazo (SLA) de atendimento para Chargeback é de **55 horas úteis** após a abertura do chamado. O procedimento de auditoria exige evidências de que Chargeback está ativo antes de cada certificação.
