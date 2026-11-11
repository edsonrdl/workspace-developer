---
id: slo-limite
title: SLO e error budget - limite máximo
dominio: observabilidade
topico: slo
resumo: Contém o limite máximo de SLO e error budget (meta de disponibilidade).
aliases: meta de disponibilidade | disponibilidade caiu abaixo da meta | orçamento de erro estourou | teto | valor máximo permitido
perguntas: Qual o limite máximo de SLO e error budget?
confidence: high
owner: squad-observabilidade
atualizado: 2026-05-19
---
# SLO e error budget - limite máximo

## For future agent

Este doc trata do limite máximo de SLO e error budget (meta de disponibilidade). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Métricas de SLO e error budget são publicadas no painel de observabilidade e acompanhadas semanalmente. O desenho de SLO e error budget considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de SLO e error budget é idêntico ao de produção, exceto pelos volumes. É importante não confundir SLO e error budget com os mecanismos legados, que serão descontinuados. Todas as alterações em SLO e error budget passam por revisão de pelo menos duas pessoas da equipe. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases. Durante a migração para a nova plataforma, SLO e error budget foi reescrito sem mudanças de contrato.

## Como funciona

Clientes corporativos podem solicitar ajustes em SLO e error budget por meio do gerente de conta. Qualquer dúvida de negócio sobre SLO e error budget deve ser registrada no backlog do domínio de observabilidade. Durante a migração para a nova plataforma, SLO e error budget foi reescrito sem mudanças de contrato. O prazo de implantação das mudanças relacionadas a SLO e error budget segue o calendário trimestral de releases. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release. Falhas em SLO e error budget geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam SLO e error budget é revisado a cada semestre.

## Decisões de arquitetura

O mecanismo de SLO e error budget foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. Durante a migração para a nova plataforma, SLO e error budget foi reescrito sem mudanças de contrato. Os testes automatizados de SLO e error budget rodam no pipeline de integração contínua a cada commit. A configuração padrão de SLO e error budget atende à maioria dos casos, mas pode ser sobrescrita por serviço. O limite de complexidade aceito nos serviços que usam SLO e error budget é revisado a cada semestre.

## Boas práticas

O mecanismo de SLO e error budget foi introduzido para reduzir incidentes recorrentes no domínio de observabilidade. É importante não confundir SLO e error budget com os mecanismos legados, que serão descontinuados. Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade. O procedimento de auditoria exige evidências de que SLO e error budget está ativo antes de cada certificação. A documentação de SLO e error budget é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de SLO e error budget estão disponíveis no repositório de referência da plataforma.

## Histórico de mudanças

- 2025-05-22: É importante não confundir SLO e error budget com os mecanismos legados, que serão descontinuados.
- 2025-01-16: Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade.
- 2025-01-15: Antes da adoção de SLO e error budget, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-04-10: O limite de complexidade aceito nos serviços que usam SLO e error budget é revisado a cada semestre.

## Anexo

O limite máximo configurado para SLO e error budget em produção é de **654 operações por minuto**, com burst de 1308. Os riscos conhecidos de SLO e error budget estão listados no registro de riscos do domínio de observabilidade.
