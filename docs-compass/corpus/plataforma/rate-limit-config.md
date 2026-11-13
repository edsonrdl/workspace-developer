---
id: rate-limit-config
title: Guia operacional plataforma nº64
dominio: plataforma
topico: rate-limit
resumo: Contém o parâmetro de configuração de Rate limiting (limite de requisições por cliente).
aliases: limite de requisições por cliente | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Rate limiting?
confidence: high
owner: squad-plataforma
atualizado: 2026-04-10
---
# Guia operacional plataforma nº64

## For future agent

Este doc trata do parâmetro de configuração de Rate limiting (limite de requisições por cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O procedimento de auditoria exige evidências de que Rate limiting está ativo antes de cada certificação. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe. Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma. Os testes automatizados de Rate limiting rodam no pipeline de integração contínua a cada commit. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O desenho de Rate limiting considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

Todas as alterações em Rate limiting passam por revisão de pelo menos duas pessoas da equipe. Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma. Qualquer dúvida de negócio sobre Rate limiting deve ser registrada no backlog do domínio de plataforma. Clientes corporativos podem solicitar ajustes em Rate limiting por meio do gerente de conta. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço.

## Decisões de arquitetura

A documentação de Rate limiting é mantida pela equipe do domínio e revisada em cada release. Antes da adoção de Rate limiting, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. O desenho de Rate limiting considera crescimento de volume de até dez vezes sem mudança estrutural. Qualquer dúvida de negócio sobre Rate limiting deve ser registrada no backlog do domínio de plataforma.

## Boas práticas

Qualquer dúvida de negócio sobre Rate limiting deve ser registrada no backlog do domínio de plataforma. Os testes automatizados de Rate limiting rodam no pipeline de integração contínua a cada commit. Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma. Falhas em Rate limiting geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre. O desenho de Rate limiting considera crescimento de volume de até dez vezes sem mudança estrutural.

## Histórico de mudanças

- 2025-06-26: Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma.
- 2025-05-19: O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases.
- 2025-08-23: O prazo de implantação das mudanças relacionadas a Rate limiting segue o calendário trimestral de releases.
- 2025-08-25: O limite de complexidade aceito nos serviços que usam Rate limiting é revisado a cada semestre.

## Anexo

O parâmetro de configuração é `ratelimit.max_attempts=2` no arquivo `settings-prod.yaml` (valor padrão 245). Exemplos de uso de Rate limiting estão disponíveis no repositório de referência da plataforma.
