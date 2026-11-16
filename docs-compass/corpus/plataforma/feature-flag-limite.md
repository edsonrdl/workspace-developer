---
id: feature-flag-limite
title: Feature flags - limite máximo
dominio: plataforma
topico: feature-flag
resumo: Contém o limite máximo de Feature flags (ligar funcionalidade sem deploy).
aliases: ligar funcionalidade sem deploy | funcionalidade apareceu para todos sem querer | teto | quanto aguenta
perguntas: Qual o limite máximo de Feature flags? | teto ligar funcionalidade sem deploy?
confidence: high
owner: squad-plataforma
atualizado: 2026-04-17
---
# Feature flags - limite máximo

## For future agent

Este doc trata do limite máximo de Feature flags (ligar funcionalidade sem deploy). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. Qualquer dúvida de negócio sobre Feature flags deve ser registrada no backlog do domínio de plataforma. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural. O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. A configuração padrão de Feature flags atende à maioria dos casos, mas pode ser sobrescrita por serviço. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma. É importante não confundir Feature flags com os mecanismos legados, que serão descontinuados.

## Decisões de arquitetura

Em ambientes de homologação o comportamento de Feature flags é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Feature flags atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit. Durante a migração para a nova plataforma, Feature flags foi reescrito sem mudanças de contrato. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Feature flags por meio do gerente de conta. O mecanismo de Feature flags foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma. Durante a migração para a nova plataforma, Feature flags foi reescrito sem mudanças de contrato. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço.

## Histórico de mudanças

- 2025-05-25: Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit.
- 2025-01-16: O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre.
- 2025-01-10: Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit.
- 2025-05-27: O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases.

## Anexo

O limite máximo configurado para Feature flags em produção é de **155 operações por minuto**, com burst de 310. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe.
