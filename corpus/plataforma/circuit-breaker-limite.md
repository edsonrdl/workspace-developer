---
id: circuit-breaker-limite
title: Circuit breaker - referência
dominio: plataforma
topico: circuit-breaker
resumo: Contém o limite máximo de Circuit breaker (proteção quando o parceiro cai).
aliases: proteção quando o parceiro cai | tudo travou quando o banco ficou fora
perguntas: Qual o limite máximo de Circuit breaker?
confidence: high
owner: squad-plataforma
atualizado: 2026-08-18
---
# Circuit breaker - referência

## For future agent

Este doc trata do limite máximo de Circuit breaker (proteção quando o parceiro cai). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço. Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. Métricas de Circuit breaker são publicadas no painel de observabilidade e acompanhadas semanalmente. Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma. Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit. Os riscos conhecidos de Circuit breaker estão listados no registro de riscos do domínio de plataforma.

## Como funciona

Durante a migração para a nova plataforma, Circuit breaker foi reescrito sem mudanças de contrato. Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma. O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release.

## Decisões de arquitetura

A implementação de Circuit breaker segue o padrão definido pelo comitê de arquitetura no início do ano. Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Circuit breaker são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma. Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta. O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural.

## Boas práticas

Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit. Todas as alterações em Circuit breaker passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma. Durante a migração para a nova plataforma, Circuit breaker foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre.

## Histórico de mudanças

- 2025-03-15: O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases.
- 2025-01-22: Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit.
- 2025-04-24: Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma.
- 2025-07-12: Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes.

## Anexo

O limite máximo configurado para Circuit breaker em produção é de **783 operações por minuto**, com burst de 1566. O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural.
