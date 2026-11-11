---
id: circuit-breaker-responsavel
title: Guia operacional plataforma nº68
dominio: plataforma
topico: circuit-breaker
resumo: Contém o equipe responsável de Circuit breaker (proteção quando o parceiro cai).
aliases: proteção quando o parceiro cai | tudo travou quando o banco ficou fora | quem cuida disso
perguntas: Qual o equipe responsável de Circuit breaker? | com quem falar proteção quando o parceiro cai?
confidence: high
owner: squad-plataforma
atualizado: 2026-03-20
---
# Guia operacional plataforma nº68

## For future agent

Este doc trata do equipe responsável de Circuit breaker (proteção quando o parceiro cai). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases. Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. Antes da adoção de Circuit breaker, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. Qualquer dúvida de negócio sobre Circuit breaker deve ser registrada no backlog do domínio de plataforma.

## Como funciona

Métricas de Circuit breaker são publicadas no painel de observabilidade e acompanhadas semanalmente. Os riscos conhecidos de Circuit breaker estão listados no registro de riscos do domínio de plataforma. A implementação de Circuit breaker segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma.

## Decisões de arquitetura

O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural. O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre. O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação. Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit. Durante a migração para a nova plataforma, Circuit breaker foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma.

## Boas práticas

O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural. Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados.

## Histórico de mudanças

- 2025-04-24: Falhas em Circuit breaker geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-05-25: Métricas de Circuit breaker são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-06-21: O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.
- 2025-02-22: Todas as alterações em Circuit breaker passam por revisão de pelo menos duas pessoas da equipe.

## Anexo

A equipe responsável por Circuit breaker é a squad **Nexus**, canal #circuitbreaker-suporte (plantão: ramal 563). Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes.
