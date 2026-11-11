---
id: segredos-responsavel
title: Gestão de segredos - referência
dominio: seguranca
topico: segredos
resumo: Contém o equipe responsável de Gestão de segredos (onde guardar senha de serviço).
aliases: onde guardar senha de serviço | senha vazou no repositório | com quem falar | a quem pedir ajuda
perguntas: Qual o equipe responsável de Gestão de segredos?
confidence: high
owner: squad-seguranca
atualizado: 2026-08-14
---
# Gestão de segredos - referência

## For future agent

Este doc trata do equipe responsável de Gestão de segredos (onde guardar senha de serviço). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os testes automatizados de Gestão de segredos rodam no pipeline de integração contínua a cada commit. Antes da adoção de Gestão de segredos, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Gestão de segredos atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação. A implementação de Gestão de segredos segue o padrão definido pelo comitê de arquitetura no início do ano. Qualquer dúvida de negócio sobre Gestão de segredos deve ser registrada no backlog do domínio de seguranca. O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca.

## Como funciona

O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. Os riscos conhecidos de Gestão de segredos estão listados no registro de riscos do domínio de seguranca. Qualquer dúvida de negócio sobre Gestão de segredos deve ser registrada no backlog do domínio de seguranca. Métricas de Gestão de segredos são publicadas no painel de observabilidade e acompanhadas semanalmente. É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre.

## Decisões de arquitetura

Os testes automatizados de Gestão de segredos rodam no pipeline de integração contínua a cada commit. Métricas de Gestão de segredos são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe. Os riscos conhecidos de Gestão de segredos estão listados no registro de riscos do domínio de seguranca. O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato. A configuração padrão de Gestão de segredos atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Boas práticas

Antes da adoção de Gestão de segredos, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. Qualquer dúvida de negócio sobre Gestão de segredos deve ser registrada no backlog do domínio de seguranca. A configuração padrão de Gestão de segredos atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe. Métricas de Gestão de segredos são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-04-12: O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre.
- 2025-01-11: Clientes corporativos podem solicitar ajustes em Gestão de segredos por meio do gerente de conta.
- 2025-07-12: Os riscos conhecidos de Gestão de segredos estão listados no registro de riscos do domínio de seguranca.
- 2025-04-25: O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação.

## Anexo

A equipe responsável por Gestão de segredos é a squad **Aurora**, canal #segredos-suporte (plantão: ramal 250). O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação.
