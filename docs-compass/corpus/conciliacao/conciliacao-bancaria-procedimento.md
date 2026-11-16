---
id: conciliacao-bancaria-procedimento
title: Conciliação bancária - runbook de troubleshooting
dominio: conciliacao
topico: conciliacao-bancaria
resumo: Contém o runbook de troubleshooting de Conciliação bancária (bater extrato com as vendas).
aliases: bater extrato com as vendas | diferença no fechamento do dia | como resolver
perguntas: Qual o runbook de troubleshooting de Conciliação bancária? | como resolver bater extrato com as vendas?
confidence: high
owner: squad-conciliacao
atualizado: 2026-01-26
---
# Conciliação bancária - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Conciliação bancária (bater extrato com as vendas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O mecanismo de Conciliação bancária foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Antes da adoção de Conciliação bancária, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Clientes corporativos podem solicitar ajustes em Conciliação bancária por meio do gerente de conta. A configuração padrão de Conciliação bancária atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de Conciliação bancária rodam no pipeline de integração contínua a cada commit. Qualquer dúvida de negócio sobre Conciliação bancária deve ser registrada no backlog do domínio de conciliacao. A implementação de Conciliação bancária segue o padrão definido pelo comitê de arquitetura no início do ano.

## Como funciona

O mecanismo de Conciliação bancária foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. A configuração padrão de Conciliação bancária atende à maioria dos casos, mas pode ser sobrescrita por serviço. O desenho de Conciliação bancária considera crescimento de volume de até dez vezes sem mudança estrutural. Antes da adoção de Conciliação bancária, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Conciliação bancária é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

Qualquer dúvida de negócio sobre Conciliação bancária deve ser registrada no backlog do domínio de conciliacao. Métricas de Conciliação bancária são publicadas no painel de observabilidade e acompanhadas semanalmente. O mecanismo de Conciliação bancária foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Exemplos de uso de Conciliação bancária estão disponíveis no repositório de referência da plataforma. A configuração padrão de Conciliação bancária atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de Conciliação bancária rodam no pipeline de integração contínua a cada commit. O procedimento de auditoria exige evidências de que Conciliação bancária está ativo antes de cada certificação.

## Boas práticas

É importante não confundir Conciliação bancária com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Conciliação bancária é revisado a cada semestre. A documentação de Conciliação bancária é mantida pela equipe do domínio e revisada em cada release. Os testes automatizados de Conciliação bancária rodam no pipeline de integração contínua a cada commit. Falhas em Conciliação bancária geram eventos que são correlacionados com os logs estruturados do serviço. O desenho de Conciliação bancária considera crescimento de volume de até dez vezes sem mudança estrutural. Durante a migração para a nova plataforma, Conciliação bancária foi reescrito sem mudanças de contrato.

## Histórico de mudanças

- 2025-03-27: A documentação de Conciliação bancária é mantida pela equipe do domínio e revisada em cada release.
- 2025-02-24: O desenho de Conciliação bancária considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-03-27: Métricas de Conciliação bancária são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-03-27: A implementação de Conciliação bancária segue o padrão definido pelo comitê de arquitetura no início do ano.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-295; 2) reiniciar o job `conciliacaobancaria-worker`; 3) abrir incidente se persistir por mais de 34 minutos. Exemplos de uso de Conciliação bancária estão disponíveis no repositório de referência da plataforma.
