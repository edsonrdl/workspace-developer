---
id: velocity-config
title: Regras de velocity - parâmetro de configuração
dominio: antifraude
topico: velocity
resumo: Contém o parâmetro de configuração de Regras de velocity (limite de tentativas em pouco tempo).
aliases: limite de tentativas em pouco tempo | muitas tentativas seguidas bloqueadas | cliente travado após errar o cartão | onde configuro
perguntas: Qual o parâmetro de configuração de Regras de velocity?
confidence: high
owner: squad-antifraude
atualizado: 2026-06-25
---
# Regras de velocity - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Regras de velocity (limite de tentativas em pouco tempo). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Regras de velocity, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude.

## Como funciona

Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude. Antes da adoção de Regras de velocity, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço.

## Decisões de arquitetura

Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço. A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural. O prazo de implantação das mudanças relacionadas a Regras de velocity segue o calendário trimestral de releases. Métricas de Regras de velocity são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural. Métricas de Regras de velocity são publicadas no painel de observabilidade e acompanhadas semanalmente. Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude. Antes da adoção de Regras de velocity, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma.

## Histórico de mudanças

- 2025-01-15: Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes.
- 2025-06-21: A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-03-18: Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes.
- 2025-02-13: O prazo de implantação das mudanças relacionadas a Regras de velocity segue o calendário trimestral de releases.

## Anexo

O parâmetro de configuração é `velocity.max_attempts=5` no arquivo `settings-prod.yaml` (valor padrão 685). Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço.
