---
id: tracing-procedimento
title: Guia operacional observabilidade nº95
dominio: observabilidade
topico: tracing
resumo: Contém o runbook de troubleshooting de Tracing distribuído (seguir uma requisição entre serviços).
aliases: seguir uma requisição entre serviços | ver por onde a chamada passou
perguntas: Qual o runbook de troubleshooting de Tracing distribuído?
confidence: high
owner: squad-observabilidade
atualizado: 2026-01-17
---
# Guia operacional observabilidade nº95

## For future agent

Este doc trata do runbook de troubleshooting de Tracing distribuído (seguir uma requisição entre serviços). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. A configuração padrão de Tracing distribuído atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes.

## Como funciona

O desenho de Tracing distribuído considera crescimento de volume de até dez vezes sem mudança estrutural. Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade. O prazo de implantação das mudanças relacionadas a Tracing distribuído segue o calendário trimestral de releases. Os testes automatizados de Tracing distribuído rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade. É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados.

## Decisões de arquitetura

O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes. Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade. A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano. O desenho de Tracing distribuído considera crescimento de volume de até dez vezes sem mudança estrutural. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade.

## Boas práticas

O desenho de Tracing distribuído considera crescimento de volume de até dez vezes sem mudança estrutural. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade. Antes da adoção de Tracing distribuído, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe.

## Histórico de mudanças

- 2025-08-20: Exemplos de uso de Tracing distribuído estão disponíveis no repositório de referência da plataforma.
- 2025-06-25: A implementação de Tracing distribuído segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-01-11: É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados.
- 2025-05-27: O procedimento de auditoria exige evidências de que Tracing distribuído está ativo antes de cada certificação.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-214; 2) reiniciar o job `tracing-worker`; 3) abrir incidente se persistir por mais de 46 minutos. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.
