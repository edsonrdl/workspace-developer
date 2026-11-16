---
id: idempotencia-config
title: Idempotência de requisições - parâmetro de configuração
dominio: pagamentos
topico: idempotencia
resumo: Contém o parâmetro de configuração de Idempotência de requisições (evitar cobrança duplicada).
aliases: evitar cobrança duplicada | cliente foi cobrado duas vezes | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Idempotência de requisições? | onde configuro evitar cobrança duplicada?
confidence: high
owner: squad-pagamentos
atualizado: 2026-03-18
---
# Idempotência de requisições - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Idempotência de requisições (evitar cobrança duplicada). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Falhas em Idempotência de requisições geram eventos que são correlacionados com os logs estruturados do serviço. Antes da adoção de Idempotência de requisições, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O procedimento de auditoria exige evidências de que Idempotência de requisições está ativo antes de cada certificação. A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Como funciona

O limite de complexidade aceito nos serviços que usam Idempotência de requisições é revisado a cada semestre. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. Os riscos conhecidos de Idempotência de requisições estão listados no registro de riscos do domínio de pagamentos. Todas as alterações em Idempotência de requisições passam por revisão de pelo menos duas pessoas da equipe. Exemplos de uso de Idempotência de requisições estão disponíveis no repositório de referência da plataforma. O prazo de implantação das mudanças relacionadas a Idempotência de requisições segue o calendário trimestral de releases. Antes da adoção de Idempotência de requisições, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Idempotência de requisições está ativo antes de cada certificação. Antes da adoção de Idempotência de requisições, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Idempotência de requisições é idêntico ao de produção, exceto pelos volumes. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente. É importante não confundir Idempotência de requisições com os mecanismos legados, que serão descontinuados.

## Boas práticas

A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Idempotência de requisições estão listados no registro de riscos do domínio de pagamentos. O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Os testes automatizados de Idempotência de requisições rodam no pipeline de integração contínua a cada commit. A documentação de Idempotência de requisições é mantida pela equipe do domínio e revisada em cada release. Falhas em Idempotência de requisições geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Idempotência de requisições são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-08-12: O procedimento de auditoria exige evidências de que Idempotência de requisições está ativo antes de cada certificação.
- 2025-05-27: O mecanismo de Idempotência de requisições foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.
- 2025-05-21: O limite de complexidade aceito nos serviços que usam Idempotência de requisições é revisado a cada semestre.
- 2025-02-13: A configuração padrão de Idempotência de requisições atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O parâmetro de configuração é `idempotencia.max_attempts=62` no arquivo `settings-prod.yaml` (valor padrão 516). A implementação de Idempotência de requisições segue o padrão definido pelo comitê de arquitetura no início do ano.
