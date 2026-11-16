---
id: 3ds-procedimento
title: Autenticação 3DS - referência
dominio: antifraude
topico: 3ds
resumo: Contém o runbook de troubleshooting de Autenticação 3DS (confirmação extra do cartão no banco).
aliases: tela de senha do banco na compra | tela do banco não abre no checkout | como resolver | passo a passo para consertar | o que fazer quando der problema
perguntas: Qual o runbook de troubleshooting de Autenticação 3DS? | como resolver confirmação extra do cartão no banco?
confidence: high
owner: squad-antifraude
atualizado: 2026-07-16
---
# Autenticação 3DS - referência

## For future agent

Este doc trata do runbook de troubleshooting de Autenticação 3DS (confirmação extra do cartão no banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases. Os riscos conhecidos de Autenticação 3DS estão listados no registro de riscos do domínio de antifraude. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Autenticação 3DS passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Autenticação 3DS é idêntico ao de produção, exceto pelos volumes.

## Como funciona

Exemplos de uso de Autenticação 3DS estão disponíveis no repositório de referência da plataforma. O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta.

## Decisões de arquitetura

A implementação de Autenticação 3DS segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Autenticação 3DS com os mecanismos legados, que serão descontinuados. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre. Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Boas práticas

Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço. A documentação de Autenticação 3DS é mantida pela equipe do domínio e revisada em cada release. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. É importante não confundir Autenticação 3DS com os mecanismos legados, que serão descontinuados.

## Histórico de mudanças

- 2025-07-17: Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-06-11: O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases.
- 2025-08-23: Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta.
- 2025-02-16: Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-776; 2) reiniciar o job `3ds-worker`; 3) abrir incidente se persistir por mais de 2 minutos. O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases.
