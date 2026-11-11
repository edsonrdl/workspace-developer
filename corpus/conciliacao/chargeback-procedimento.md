---
id: chargeback-procedimento
title: Chargeback - runbook de troubleshooting
dominio: conciliacao
topico: chargeback
resumo: Contém o runbook de troubleshooting de Chargeback (contestação de compra).
aliases: contestação de compra | cliente não reconhece a cobrança | cliente contestou a compra no cartão | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Chargeback? | como resolver contestação de compra?
confidence: high
owner: squad-conciliacao
atualizado: 2026-05-25
---
# Chargeback - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Chargeback (contestação de compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre Chargeback deve ser registrada no backlog do domínio de conciliacao. O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre. A documentação de Chargeback é mantida pela equipe do domínio e revisada em cada release. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Como funciona

Exemplos de uso de Chargeback estão disponíveis no repositório de referência da plataforma. Clientes corporativos podem solicitar ajustes em Chargeback por meio do gerente de conta. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases. O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural. Durante a migração para a nova plataforma, Chargeback foi reescrito sem mudanças de contrato. É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados.

## Decisões de arquitetura

Falhas em Chargeback geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Chargeback está ativo antes de cada certificação. Todas as alterações em Chargeback passam por revisão de pelo menos duas pessoas da equipe. A implementação de Chargeback segue o padrão definido pelo comitê de arquitetura no início do ano. Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Boas práticas

A configuração padrão de Chargeback atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre Chargeback deve ser registrada no backlog do domínio de conciliacao. Antes da adoção de Chargeback, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Chargeback segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-01-27: O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre.
- 2025-02-12: O limite de complexidade aceito nos serviços que usam Chargeback é revisado a cada semestre.
- 2025-08-26: É importante não confundir Chargeback com os mecanismos legados, que serão descontinuados.
- 2025-03-17: Em ambientes de homologação o comportamento de Chargeback é idêntico ao de produção, exceto pelos volumes.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-393; 2) reiniciar o job `chargeback-worker`; 3) abrir incidente se persistir por mais de 67 minutos. O desenho de Chargeback considera crescimento de volume de até dez vezes sem mudança estrutural.
