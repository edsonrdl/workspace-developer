---
id: rate-limit-procedimento
title: Rate limiting - guia
dominio: plataforma
topico: rate-limit
resumo: Contém o runbook de troubleshooting de Rate limiting (limite de requisições por cliente).
aliases: limite de requisições por cliente | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Rate limiting? | como resolver limite de requisições por cliente?
confidence: high
owner: squad-plataforma
atualizado: 2026-01-14
---
# Rate limiting - guia

## For future agent

Este doc trata do runbook de troubleshooting de Rate limiting (limite de requisições por cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases. A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe. Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta. Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes.

## Como funciona

O mecanismo de Rate limiting foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Rate limiting é idêntico ao de produção, exceto pelos volumes. A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases. A configuração padrão de Rate limiting atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Decisões de arquitetura

A implementação de Rate limiting segue o padrão definido pelo comitê de arquitetura no início do ano. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. A configuração padrão de Rate limiting atende à maioria dos casos, mas pode ser sobrescrita por serviço. O desenho de Rate limiting considera crescimento de volume de até dez vezes sem mudança estrutural. Os riscos conhecidos de Rate limiting estão listados no registro de riscos do domínio de plataforma. Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

Qualquer dúvida de negócio sobre Rate limiting deve ser registrada no backlog do domínio de plataforma. É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados. A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. Métricas de Rate limiting são publicadas no painel de observabilidade e acompanhadas semanalmente. Os riscos conhecidos de Rate limiting estão listados no registro de riscos do domínio de plataforma.

## Histórico de mudanças

- 2025-06-23: É importante não confundir Rate limiting com os mecanismos legados, que serão descontinuados.
- 2025-03-15: A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release.
- 2025-07-16: Os riscos conhecidos de Rate limiting estão listados no registro de riscos do domínio de plataforma.
- 2025-08-27: A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-674; 2) reiniciar o job `ratelimit-worker`; 3) abrir incidente se persistir por mais de 21 minutos. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço.
