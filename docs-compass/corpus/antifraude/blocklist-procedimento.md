---
id: blocklist-procedimento
title: Lista de bloqueio (blocklist) - notas
dominio: antifraude
topico: blocklist
resumo: Contém o runbook de troubleshooting de Lista de bloqueio (blocklist) (bloquear cliente ruim).
aliases: bloquear cliente ruim | cliente bloqueado indevidamente | como resolver
perguntas: Qual o runbook de troubleshooting de Lista de bloqueio (blocklist)?
confidence: medium
owner: squad-antifraude
atualizado: 2026-06-26
---
# Lista de bloqueio (blocklist) - notas

## For future agent

Este doc trata do runbook de troubleshooting de Lista de bloqueio (blocklist) (bloquear cliente ruim). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação. O limite de complexidade aceito nos serviços que usam Lista de bloqueio (blocklist) é revisado a cada semestre. O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. O desenho de Lista de bloqueio (blocklist) considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

Todas as alterações em Lista de bloqueio (blocklist) passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação. Métricas de Lista de bloqueio (blocklist) são publicadas no painel de observabilidade e acompanhadas semanalmente. Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude. A implementação de Lista de bloqueio (blocklist) segue o padrão definido pelo comitê de arquitetura no início do ano.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação. Falhas em Lista de bloqueio (blocklist) geram eventos que são correlacionados com os logs estruturados do serviço. Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato. O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Boas práticas

Qualquer dúvida de negócio sobre Lista de bloqueio (blocklist) deve ser registrada no backlog do domínio de antifraude. Todas as alterações em Lista de bloqueio (blocklist) passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Falhas em Lista de bloqueio (blocklist) geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação. O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-02-17: O limite de complexidade aceito nos serviços que usam Lista de bloqueio (blocklist) é revisado a cada semestre.
- 2025-06-21: O desenho de Lista de bloqueio (blocklist) considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-08-14: Os testes automatizados de Lista de bloqueio (blocklist) rodam no pipeline de integração contínua a cada commit.
- 2025-04-11: O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-308; 2) reiniciar o job `blocklist-worker`; 3) abrir incidente se persistir por mais de 25 minutos. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release.
