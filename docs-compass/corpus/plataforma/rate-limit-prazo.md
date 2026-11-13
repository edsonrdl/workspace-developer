---
id: rate-limit-prazo
title: Rate limiting - prazo (SLA)
dominio: plataforma
topico: rate-limit
resumo: Contém o prazo (SLA) de Rate limiting (limite de requisições por cliente).
aliases: limite de requisições por cliente | controle de uso da API por parceiro | erro 429 na API | tempo de espera
perguntas: Qual o prazo (SLA) de Rate limiting? | em quanto tempo limite de requisições por cliente?
confidence: high
owner: squad-plataforma
atualizado: 2026-05-24
---
# Rate limiting - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Rate limiting (limite de requisições por cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Rate limiting foi reescrito sem mudanças de contrato. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. Os testes automatizados de Rate limiting rodam no pipeline de integração contínua a cada commit. Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço.

## Como funciona

Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta. O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes. O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Decisões de arquitetura

Qualquer dúvida de negócio sobre Rate limiting deve ser registrada no backlog do domínio de plataforma. A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. Os testes automatizados de Rate limiting rodam no pipeline de integração contínua a cada commit.

## Boas práticas

Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta.

## Histórico de mudanças

- 2025-03-19: Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-07-11: Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes.
- 2025-04-24: O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação.
- 2025-05-10: A configuração padrão de Rate limiting atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O prazo (SLA) de atendimento para Rate limiting é de **31 horas úteis** após a abertura do chamado. O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação.
