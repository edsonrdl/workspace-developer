---
id: rate-limit-responsavel
title: Rate limiting - equipe responsável
dominio: plataforma
topico: rate-limit
resumo: Contém o equipe responsável de Rate limiting (limite de requisições por cliente).
aliases: limite de requisições por cliente | erro 429 na API | parceiro reclama de requisições recusadas | com quem falar | quem cuida disso
perguntas: Qual o equipe responsável de Rate limiting?
confidence: high
owner: squad-plataforma
atualizado: 2026-06-24
---
# Rate limiting - equipe responsável

## For future agent

Este doc trata do equipe responsável de Rate limiting (limite de requisições por cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases. Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta. Os riscos conhecidos de Rate limiting estão listados no registro de riscos do domínio de plataforma. Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma.

## Como funciona

Os testes automatizados de Rate limiting rodam no pipeline de integração contínua a cada commit. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases. A configuração padrão de Rate limiting atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Decisões de arquitetura

A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases. Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Rate limiting foi reescrito sem mudanças de contrato.

## Boas práticas

O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Durante a migração para a nova plataforma, Rate limiting foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta.

## Histórico de mudanças

- 2025-02-23: Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe.
- 2025-02-12: Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta.
- 2025-08-19: Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-01-21: Durante a migração para a nova plataforma, Rate limiting foi reescrito sem mudanças de contrato.

## Anexo

A equipe responsável por Rate limiting é a squad **Nexus**, canal #ratelimit-suporte (plantão: ramal 675). Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
