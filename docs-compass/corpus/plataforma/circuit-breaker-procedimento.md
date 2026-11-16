---
id: circuit-breaker-procedimento
title: Circuit breaker - guia
dominio: plataforma
topico: circuit-breaker
resumo: Contém o runbook de troubleshooting de Circuit breaker (proteção quando o parceiro cai).
aliases: proteção quando o parceiro cai | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Circuit breaker?
confidence: medium
owner: squad-plataforma
atualizado: 2026-05-17
---
# Circuit breaker - guia

## For future agent

Este doc trata do runbook de troubleshooting de Circuit breaker (proteção quando o parceiro cai). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre. Todas as alterações em Circuit breaker passam por revisão de pelo menos duas pessoas da equipe. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma. Os riscos conhecidos de Circuit breaker estão listados no registro de riscos do domínio de plataforma. O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases.

## Como funciona

Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. A implementação de Circuit breaker segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases. Os riscos conhecidos de Circuit breaker estão listados no registro de riscos do domínio de plataforma. O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. A configuração padrão de Circuit breaker atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre.

## Decisões de arquitetura

Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma. Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço. Antes da adoção de Circuit breaker, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release.

## Boas práticas

Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma. Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural. Todas as alterações em Circuit breaker passam por revisão de pelo menos duas pessoas da equipe.

## Histórico de mudanças

- 2025-03-18: O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-04-13: Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes.
- 2025-06-22: O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases.
- 2025-05-23: A configuração padrão de Circuit breaker atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-480; 2) reiniciar o job `circuitbreaker-worker`; 3) abrir incidente se persistir por mais de 58 minutos. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma.
