---
id: slo-prazo
title: Guia operacional observabilidade nº87
dominio: observabilidade
topico: slo
resumo: Contém o prazo (SLA) de SLO e error budget (meta de disponibilidade).
aliases: disponibilidade caiu abaixo da meta | em quanto tempo
perguntas: Qual o prazo (SLA) de SLO e error budget?
confidence: high
owner: squad-observabilidade
atualizado: 2026-02-22
---
# Guia operacional observabilidade nº87

## For future agent

Este doc trata do prazo (SLA) de SLO e error budget (meta de disponibilidade). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, SLO e error budget foi reescrito sem mudanças de contrato. O desenho de SLO e error budget considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de SLO e error budget é idêntico ao de produção, exceto pelos volumes. Qualquer dúvida de negócio sobre SLO e error budget deve ser registrada no backlog do domínio de observabilidade. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release.

## Como funciona

Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases. A implementação de SLO e error budget segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade. Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release.

## Decisões de arquitetura

O limite de complexidade aceito nos serviços que usam SLO e error budget é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases. Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade. Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente. O desenho de SLO e error budget considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de SLO e error budget é idêntico ao de produção, exceto pelos volumes.

## Boas práticas

Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam SLO e error budget é revisado a cada semestre. Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit. Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe. O procedimento de auditoria exige evidências de que SLO e error budget está ativo antes de cada certificação. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release.

## Histórico de mudanças

- 2025-02-21: Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade.
- 2025-06-26: Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit.
- 2025-01-25: O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases.
- 2025-02-26: Clientes corporativos podem solicitar ajustes em SLO e error budget por meio do gerente de conta.

## Anexo

O prazo (SLA) de atendimento para SLO e error budget é de **4 horas úteis** após a abertura do chamado. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases.
