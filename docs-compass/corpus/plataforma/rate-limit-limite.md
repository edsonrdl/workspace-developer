---
id: rate-limit-limite
title: Rate limiting - limite máximo
dominio: plataforma
topico: rate-limit
resumo: Contém o limite máximo de Rate limiting (limite de requisições por cliente).
aliases: limite de requisições por cliente | erro 429 na API | parceiro reclama de requisições recusadas | teto | quanto aguenta
perguntas: Qual o limite máximo de Rate limiting? | teto limite de requisições por cliente?
confidence: high
owner: squad-plataforma
atualizado: 2026-08-20
---
# Rate limiting - limite máximo

## For future agent

Este doc trata do limite máximo de Rate limiting (limite de requisições por cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. Qualquer dúvida de negócio sobre Rate limiting deve ser registrada no backlog do domínio de plataforma. O desenho de Rate limiting considera crescimento de volume de até dez vezes sem mudança estrutural. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. A configuração padrão de Rate limiting atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes. A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Durante a migração para a nova plataforma, Rate limiting foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação.

## Decisões de arquitetura

Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe. O desenho de Rate limiting considera crescimento de volume de até dez vezes sem mudança estrutural. A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. Os riscos conhecidos de Rate limiting estão listados no registro de riscos do domínio de plataforma. O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.

## Boas práticas

A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases. Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente. O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-08-10: A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-03-24: O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação.
- 2025-06-18: Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-03-11: A configuração padrão de Rate limiting atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O limite máximo configurado para Rate limiting em produção é de **638 operações por minuto**, com burst de 1276. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados.
