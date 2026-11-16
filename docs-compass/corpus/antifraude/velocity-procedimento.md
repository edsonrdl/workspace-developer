---
id: velocity-procedimento
title: Regras de velocity - runbook de troubleshooting
dominio: antifraude
topico: velocity
resumo: Contém o runbook de troubleshooting de Regras de velocity (limite de tentativas em pouco tempo).
aliases: bloquear muitas compras seguidas | cliente travado após errar o cartão | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Regras de velocity? | como resolver limite de tentativas em pouco tempo?
confidence: medium
owner: squad-antifraude
atualizado: 2026-07-20
---
# Regras de velocity - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Regras de velocity (limite de tentativas em pouco tempo). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Regras de velocity segue o calendário trimestral de releases.

## Como funciona

Os testes automatizados de Regras de velocity rodam no pipeline de integração contínua a cada commit. O procedimento de auditoria exige evidências de que Regras de velocity está ativo antes de cada certificação. Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta. Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. Antes da adoção de Regras de velocity, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Regras de velocity foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. A documentação de Regras de velocity é mantida pela equipe do domínio e revisada em cada release.

## Boas práticas

O mecanismo de Regras de velocity foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. É importante não confundir Regras de velocity com os mecanismos legados, que serão descontinuados. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta. Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude. O prazo de implantação das mudanças relacionadas a Regras de velocity segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-01-10: Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe.
- 2025-02-15: A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-01-23: A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-06-14: Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-289; 2) reiniciar o job `velocity-worker`; 3) abrir incidente se persistir por mais de 55 minutos. Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta.
