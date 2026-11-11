---
id: circuit-breaker-config
title: Circuit breaker - parâmetro de configuração
dominio: plataforma
topico: circuit-breaker
resumo: Contém o parâmetro de configuração de Circuit breaker (proteção quando o parceiro cai).
aliases: proteção quando o parceiro cai | tudo travou quando o banco ficou fora | sistema lento porque um serviço caiu | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Circuit breaker?
confidence: high
owner: squad-plataforma
atualizado: 2026-08-22
---
# Circuit breaker - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Circuit breaker (proteção quando o parceiro cai). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Métricas de Circuit breaker são publicadas no painel de observabilidade e acompanhadas semanalmente. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação. O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural. Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta.

## Como funciona

Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Circuit breaker rodam no pipeline de integração contínua a cada commit. O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma.

## Decisões de arquitetura

O desenho de Circuit breaker considera crescimento de volume de até dez vezes sem mudança estrutural. Exemplos de uso de Circuit breaker estão disponíveis no repositório de referência da plataforma. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases. Antes da adoção de Circuit breaker, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Circuit breaker foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.

## Boas práticas

A configuração padrão de Circuit breaker atende à maioria dos casos, mas pode ser sobrescrita por serviço. A documentação de Circuit breaker é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Circuit breaker segue o calendário trimestral de releases. O limite de complexidade aceito nos serviços que usam Circuit breaker é revisado a cada semestre. O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação. Clientes corporativos podem solicitar ajustes em Circuit breaker por meio do gerente de conta.

## Histórico de mudanças

- 2025-05-27: Em ambientes de homologação o comportamento de Circuit breaker é idêntico ao de produção, exceto pelos volumes.
- 2025-08-15: O procedimento de auditoria exige evidências de que Circuit breaker está ativo antes de cada certificação.
- 2025-03-13: Antes da adoção de Circuit breaker, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-08-10: É importante não confundir Circuit breaker com os mecanismos legados, que serão descontinuados.

## Anexo

O parâmetro de configuração é `circuitbreaker.max_attempts=35` no arquivo `settings-prod.yaml` (valor padrão 783). Antes da adoção de Circuit breaker, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
