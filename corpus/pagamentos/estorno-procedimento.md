---
id: estorno-procedimento
title: Estorno de transações - runbook de troubleshooting
dominio: pagamentos
topico: estorno
resumo: Contém o runbook de troubleshooting de Estorno de transações (devolver dinheiro ao cliente).
aliases: devolver dinheiro ao cliente | reembolso não apareceu | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Estorno de transações?
confidence: medium
owner: squad-pagamentos
atualizado: 2026-08-21
---
# Estorno de transações - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Estorno de transações (devolver dinheiro ao cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Estorno de transações com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Estorno de transações segue o calendário trimestral de releases. A configuração padrão de Estorno de transações atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Estorno de transações é idêntico ao de produção, exceto pelos volumes.

## Como funciona

Métricas de Estorno de transações são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. Durante a migração para a nova plataforma, Estorno de transações foi reescrito sem mudanças de contrato. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Todas as alterações em Estorno de transações passam por revisão de pelo menos duas pessoas da equipe.

## Decisões de arquitetura

É importante não confundir Estorno de transações com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre. Falhas em Estorno de transações geram eventos que são correlacionados com os logs estruturados do serviço. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O procedimento de auditoria exige evidências de que Estorno de transações está ativo antes de cada certificação.

## Boas práticas

Falhas em Estorno de transações geram eventos que são correlacionados com os logs estruturados do serviço. Exemplos de uso de Estorno de transações estão disponíveis no repositório de referência da plataforma. O mecanismo de Estorno de transações foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O prazo de implantação das mudanças relacionadas a Estorno de transações segue o calendário trimestral de releases. O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.

## Histórico de mudanças

- 2025-02-25: Qualquer dúvida de negócio sobre Estorno de transações deve ser registrada no backlog do domínio de pagamentos.
- 2025-05-11: O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.
- 2025-02-14: O limite de complexidade aceito nos serviços que usam Estorno de transações é revisado a cada semestre.
- 2025-03-19: Os riscos conhecidos de Estorno de transações estão listados no registro de riscos do domínio de pagamentos.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-317; 2) reiniciar o job `estorno-worker`; 3) abrir incidente se persistir por mais de 29 minutos. Antes da adoção de Estorno de transações, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
