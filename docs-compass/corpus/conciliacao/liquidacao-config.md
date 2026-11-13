---
id: liquidacao-config
title: Guia operacional conciliacao nº39
dominio: conciliacao
topico: liquidacao
resumo: Contém o parâmetro de configuração de Liquidação D+1 (quando o dinheiro cai na conta).
aliases: quando o dinheiro cai na conta | repasse atrasou | dinheiro da venda não caiu ainda | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Liquidação D+1? | onde configuro quando o dinheiro cai na conta?
confidence: high
owner: squad-conciliacao
atualizado: 2026-02-27
---
# Guia operacional conciliacao nº39

## For future agent

Este doc trata do parâmetro de configuração de Liquidação D+1 (quando o dinheiro cai na conta). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os testes automatizados de Liquidação D+1 rodam no pipeline de integração contínua a cada commit. Antes da adoção de Liquidação D+1, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Liquidação D+1 é revisado a cada semestre. O prazo de implantação das mudanças relacionadas a Liquidação D+1 segue o calendário trimestral de releases. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. Falhas em Liquidação D+1 geram eventos que são correlacionados com os logs estruturados do serviço.

## Como funciona

O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de Liquidação D+1 rodam no pipeline de integração contínua a cada commit. A documentação de Liquidação D+1 é mantida pela equipe do domínio e revisada em cada release. É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Liquidação D+1 é revisado a cada semestre.

## Decisões de arquitetura

A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados. O mecanismo de Liquidação D+1 foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta. A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. A documentação de Liquidação D+1 é mantida pela equipe do domínio e revisada em cada release.

## Boas práticas

Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato. É importante não confundir Liquidação D+1 com os mecanismos legados, que serão descontinuados. Em ambientes de homologação o comportamento de Liquidação D+1 é idêntico ao de produção, exceto pelos volumes. Métricas de Liquidação D+1 são publicadas no painel de observabilidade e acompanhadas semanalmente. Clientes corporativos podem solicitar ajustes em Liquidação D+1 por meio do gerente de conta. O procedimento de auditoria exige evidências de que Liquidação D+1 está ativo antes de cada certificação. Todas as alterações em Liquidação D+1 passam por revisão de pelo menos duas pessoas da equipe.

## Histórico de mudanças

- 2025-07-11: A configuração padrão de Liquidação D+1 atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-04-23: Exemplos de uso de Liquidação D+1 estão disponíveis no repositório de referência da plataforma.
- 2025-07-10: A implementação de Liquidação D+1 segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-01-26: Exemplos de uso de Liquidação D+1 estão disponíveis no repositório de referência da plataforma.

## Anexo

O parâmetro de configuração é `liquidacao.max_attempts=54` no arquivo `settings-prod.yaml` (valor padrão 804). Durante a migração para a nova plataforma, Liquidação D+1 foi reescrito sem mudanças de contrato.
