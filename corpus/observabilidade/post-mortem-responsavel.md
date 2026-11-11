---
id: post-mortem-responsavel
title: Post-mortem de incidentes - equipe responsável
dominio: observabilidade
topico: post-mortem
resumo: Contém o equipe responsável de Post-mortem de incidentes (relatório depois de uma falha).
aliases: relatório depois de uma falha | análise do que deu errado | ninguém escreveu o relatório do incidente | quem cuida disso
perguntas: Qual o equipe responsável de Post-mortem de incidentes?
confidence: high
owner: squad-observabilidade
atualizado: 2026-05-15
---
# Post-mortem de incidentes - equipe responsável

## For future agent

Este doc trata do equipe responsável de Post-mortem de incidentes (relatório depois de uma falha). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Em ambientes de homologação o comportamento de Post-mortem de incidentes é idêntico ao de produção, exceto pelos volumes. O procedimento de auditoria exige evidências de que Post-mortem de incidentes está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Post-mortem de incidentes deve ser registrada no backlog do domínio de observabilidade. A implementação de Post-mortem de incidentes segue o padrão definido pelo comitê de arquitetura no início do ano. Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade.

## Como funciona

O mecanismo de Post-mortem de incidentes foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. A documentação de Post-mortem de incidentes é mantida pela equipe do domínio e revisada em cada release. Clientes corporativos podem solicitar ajustes em Post-mortem de incidentes por meio do gerente de conta. Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit.

## Decisões de arquitetura

A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre. Exemplos de uso de Post-mortem de incidentes estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Post-mortem de incidentes deve ser registrada no backlog do domínio de observabilidade. O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases. A implementação de Post-mortem de incidentes segue o padrão definido pelo comitê de arquitetura no início do ano.

## Boas práticas

Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit. O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre. A configuração padrão de Post-mortem de incidentes atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Post-mortem de incidentes, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Post-mortem de incidentes é mantida pela equipe do domínio e revisada em cada release. A implementação de Post-mortem de incidentes segue o padrão definido pelo comitê de arquitetura no início do ano.

## Histórico de mudanças

- 2025-06-25: É importante não confundir Post-mortem de incidentes com os mecanismos legados, que serão descontinuados.
- 2025-06-15: Métricas de Post-mortem de incidentes são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-05-19: O limite de complexidade aceito nos serviços que usam Post-mortem de incidentes é revisado a cada semestre.
- 2025-08-23: Os testes automatizados de Post-mortem de incidentes rodam no pipeline de integração contínua a cada commit.

## Anexo

A equipe responsável por Post-mortem de incidentes é a squad **Orion**, canal #postmortem-suporte (plantão: ramal 108). O prazo de implantação das mudanças relacionadas a Post-mortem de incidentes segue o calendário trimestral de releases.
