---
id: tracing-limite
title: Tracing distribuído - limite máximo
dominio: observabilidade
topico: tracing
resumo: Contém o limite máximo de Tracing distribuído (seguir uma requisição entre serviços).
aliases: seguir uma requisição entre serviços | não acho onde a requisição demorou | quanto aguenta
perguntas: Qual o limite máximo de Tracing distribuído? | teto seguir uma requisição entre serviços?
confidence: high
owner: squad-observabilidade
atualizado: 2026-06-10
---
# Tracing distribuído - limite máximo

## For future agent

Este doc trata do limite máximo de Tracing distribuído (seguir uma requisição entre serviços). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Tracing distribuído com os mecanismos legados, que serão descontinuados. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. O limite de complexidade aceito nos serviços que usam Tracing distribuído é revisado a cada semestre. O procedimento de auditoria exige evidências de que Tracing distribuído está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Tracing distribuído deve ser registrada no backlog do domínio de observabilidade.

## Como funciona

Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta. A configuração padrão de Tracing distribuído atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. A documentação de Tracing distribuído é mantida pela equipe do domínio e revisada em cada release. Os testes automatizados de Tracing distribuído rodam no pipeline de integração contínua a cada commit. Os riscos conhecidos de Tracing distribuído estão listados no registro de riscos do domínio de observabilidade.

## Decisões de arquitetura

Todas as alterações em Tracing distribuído passam por revisão de pelo menos duas pessoas da equipe. Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato. Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Tracing distribuído são publicadas no painel de observabilidade e acompanhadas semanalmente. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.

## Boas práticas

Falhas em Tracing distribuído geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em Tracing distribuído por meio do gerente de conta. A configuração padrão de Tracing distribuído atende à maioria dos casos, mas pode ser sobrescrita por serviço. O desenho de Tracing distribuído considera crescimento de volume de até dez vezes sem mudança estrutural. O prazo de implantação das mudanças relacionadas a Tracing distribuído segue o calendário trimestral de releases. O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.

## Histórico de mudanças

- 2025-07-24: O prazo de implantação das mudanças relacionadas a Tracing distribuído segue o calendário trimestral de releases.
- 2025-05-17: Em ambientes de homologação o comportamento de Tracing distribuído é idêntico ao de produção, exceto pelos volumes.
- 2025-02-14: O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.
- 2025-06-26: O mecanismo de Tracing distribuído foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.

## Anexo

O limite máximo configurado para Tracing distribuído em produção é de **883 operações por minuto**, com burst de 1766. Durante a migração para a nova plataforma, Tracing distribuído foi reescrito sem mudanças de contrato.
