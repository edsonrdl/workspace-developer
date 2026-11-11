---
id: liquidacao-responsavel
title: Liquidação D+1 - equipe responsável
dominio: conciliacao
topico: liquidacao
resumo: Contém o equipe responsável de Liquidação D+1 (quando o dinheiro cai na conta).
aliases: quando o dinheiro cai na conta | com quem falar | quem cuida disso
perguntas: Qual o equipe responsável de Liquidação D+1?
confidence: high
owner: squad-conciliacao
atualizado: 2026-01-13
---
# Liquidação D+1 - equipe responsável

## For future agent

Este doc trata do equipe responsável de Liquidação D+1 (quando o dinheiro cai na conta). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta. O mecanismo de Liquidação D+1 foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados.

## Como funciona

É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados. A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano. Os testes automatizados de Liquidação D+1 rodam no pipeline de integração contínua a cada commit. Qualquer dúvida de negócio sobre Liquidação D+1 deve ser registrada no backlog do domínio de conciliacao. Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente. Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Decisões de arquitetura

A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Liquidação D+1 estão listados no registro de riscos do domínio de conciliacao. Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Liquidação D+1 deve ser registrada no backlog do domínio de conciliacao. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação.

## Boas práticas

Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Liquidação D+1 estão disponíveis no repositório de referência da plataforma. O limite de complexidade aceito nos serviços que usam Liquidação D+1 é revisado a cada semestre. A documentação de Liquidação D+1 é mantida pela equipe do domínio e revisada em cada release. A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço.

## Histórico de mudanças

- 2025-03-26: Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes.
- 2025-08-25: Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-08-15: A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-01-20: É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados.

## Anexo

A equipe responsável por Liquidação D+1 é a squad **Titan**, canal #liquidacao-suporte (plantão: ramal 395). Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço.
