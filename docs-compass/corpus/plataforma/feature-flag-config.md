---
id: feature-flag-config
title: Feature flags - anotações
dominio: plataforma
topico: feature-flag
resumo: Contém o parâmetro de configuração de Feature flags (ligar funcionalidade sem deploy).
aliases: liberar recurso aos poucos | funcionalidade apareceu para todos sem querer
perguntas: Qual o parâmetro de configuração de Feature flags?
confidence: high
owner: squad-plataforma
atualizado: 2026-02-11
---
# Feature flags - anotações

## For future agent

Este doc trata do parâmetro de configuração de Feature flags (ligar funcionalidade sem deploy). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Qualquer dúvida de negócio sobre Feature flags deve ser registrada no backlog do domínio de plataforma. O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Feature flags atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe. O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases.

## Decisões de arquitetura

O mecanismo de Feature flags foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit. O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural. Os riscos conhecidos de Feature flags estão listados no registro de riscos do domínio de plataforma.

## Boas práticas

O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. Clientes corporativos podem solicitar ajustes em Feature flags por meio do gerente de conta. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-08-15: O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação.
- 2025-06-22: Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit.
- 2025-08-19: Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-07-23: O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases.

## Anexo

O parâmetro de configuração é `featureflag.max_attempts=15` no arquivo `settings-prod.yaml` (valor padrão 714). A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano.
