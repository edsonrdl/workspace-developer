---
id: 3ds-limite
title: Autenticação 3DS - limite máximo
dominio: antifraude
topico: 3ds
resumo: Contém o limite máximo de Autenticação 3DS (confirmação extra do cartão no banco).
aliases: tela do banco não abre no checkout | teto | quanto aguenta
perguntas: Qual o limite máximo de Autenticação 3DS?
confidence: high
owner: squad-antifraude
atualizado: 2026-08-27
---
# Autenticação 3DS - limite máximo

## For future agent

Este doc trata do limite máximo de Autenticação 3DS (confirmação extra do cartão no banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. Exemplos de uso de Autenticação 3DS estão disponíveis no repositório de referência da plataforma. Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em Autenticação 3DS passam por revisão de pelo menos duas pessoas da equipe. Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit.

## Como funciona

O mecanismo de Autenticação 3DS foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação. O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre. Os riscos conhecidos de Autenticação 3DS estão listados no registro de riscos do domínio de antifraude.

## Decisões de arquitetura

Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit. O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação. Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato. Exemplos de uso de Autenticação 3DS estão disponíveis no repositório de referência da plataforma. O mecanismo de Autenticação 3DS foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Boas práticas

O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta. O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases. Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os riscos conhecidos de Autenticação 3DS estão listados no registro de riscos do domínio de antifraude.

## Histórico de mudanças

- 2025-08-16: Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude.
- 2025-04-13: O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre.
- 2025-05-12: O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre.
- 2025-03-13: Em ambientes de homologação o comportamento de Autenticação 3DS é idêntico ao de produção, exceto pelos volumes.

## Anexo

O limite máximo configurado para Autenticação 3DS em produção é de **605 operações por minuto**, com burst de 1210. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço.
