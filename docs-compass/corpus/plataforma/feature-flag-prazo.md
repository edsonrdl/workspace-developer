---
id: feature-flag-prazo
title: Feature flags - referência
dominio: plataforma
topico: feature-flag
resumo: Contém o prazo (SLA) de Feature flags (ligar funcionalidade sem deploy).
aliases: ligar funcionalidade sem deploy | funcionalidade apareceu para todos sem querer | recurso novo ligado em produção por engano | em quanto tempo | quando fica pronto
perguntas: Qual o prazo (SLA) de Feature flags? | em quanto tempo ligar funcionalidade sem deploy?
confidence: high
owner: squad-plataforma
atualizado: 2026-03-10
---
# Feature flags - referência

## For future agent

Este doc trata do prazo (SLA) de Feature flags (ligar funcionalidade sem deploy). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Feature flags com os mecanismos legados, que serão descontinuados. Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit. A configuração padrão de Feature flags atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. O mecanismo de Feature flags foi introduzido para reduzir incidentes recorrentes no domínio de plataforma.

## Como funciona

Durante a migração para a nova plataforma, Feature flags foi reescrito sem mudanças de contrato. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit. O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma.

## Decisões de arquitetura

Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Feature flags foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. Em ambientes de homologação o comportamento de Feature flags é idêntico ao de produção, exceto pelos volumes. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release. O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural.

## Boas práticas

Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe. O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural. O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-02-25: Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-04-26: Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit.
- 2025-02-15: A configuração padrão de Feature flags atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-02-19: Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Anexo

O prazo (SLA) de atendimento para Feature flags é de **14 horas úteis** após a abertura do chamado. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço.
