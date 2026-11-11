---
id: feature-flag-procedimento
title: Feature flags - runbook de troubleshooting
dominio: plataforma
topico: feature-flag
resumo: Contém o runbook de troubleshooting de Feature flags (ligar funcionalidade sem deploy).
aliases: ligar funcionalidade sem deploy | funcionalidade apareceu para todos sem querer | recurso novo ligado em produção por engano | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Feature flags? | como resolver ligar funcionalidade sem deploy?
confidence: medium
owner: squad-plataforma
atualizado: 2026-08-18
---
# Feature flags - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Feature flags (ligar funcionalidade sem deploy). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente. Clientes corporativos podem solicitar ajustes em Feature flags por meio do gerente de conta. O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release.

## Como funciona

O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. O mecanismo de Feature flags foi introduzido para reduzir incidentes recorrentes no domínio de plataforma. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Decisões de arquitetura

Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release. Qualquer dúvida de negócio sobre Feature flags deve ser registrada no backlog do domínio de plataforma. Durante a migração para a nova plataforma, Feature flags foi reescrito sem mudanças de contrato. Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases.

## Boas práticas

Os riscos conhecidos de Feature flags estão listados no registro de riscos do domínio de plataforma. Antes da adoção de Feature flags, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre. A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release.

## Histórico de mudanças

- 2025-08-19: O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-08-23: A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release.
- 2025-02-18: O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-07-16: Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-641; 2) reiniciar o job `featureflag-worker`; 3) abrir incidente se persistir por mais de 43 minutos. Clientes corporativos podem solicitar ajustes em Feature flags por meio do gerente de conta.
