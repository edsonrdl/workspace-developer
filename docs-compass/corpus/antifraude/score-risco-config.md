---
id: score-risco-config
title: Score de risco da transação - parâmetro de configuração
dominio: antifraude
topico: score-risco
resumo: Contém o parâmetro de configuração de Score de risco da transação (nota de suspeita da compra).
aliases: nota de suspeita da compra | transação legítima foi negada | qual a configuração
perguntas: Qual o parâmetro de configuração de Score de risco da transação? | onde configuro nota de suspeita da compra?
confidence: high
owner: squad-antifraude
atualizado: 2026-07-18
---
# Score de risco da transação - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Score de risco da transação (nota de suspeita da compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O limite de complexidade aceito nos serviços que usam Score de risco da transação é revisado a cada semestre. Antes da adoção de Score de risco da transação, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Score de risco da transação atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Score de risco da transação passam por revisão de pelo menos duas pessoas da equipe. O prazo de implantação das mudanças relacionadas a Score de risco da transação segue o calendário trimestral de releases.

## Como funciona

Exemplos de uso de Score de risco da transação estão disponíveis no repositório de referência da plataforma. Os testes automatizados de Score de risco da transação rodam no pipeline de integração contínua a cada commit. Durante a migração para a nova plataforma, Score de risco da transação foi reescrito sem mudanças de contrato. Todas as alterações em Score de risco da transação passam por revisão de pelo menos duas pessoas da equipe. Métricas de Score de risco da transação são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação. Todas as alterações em Score de risco da transação passam por revisão de pelo menos duas pessoas da equipe. Durante a migração para a nova plataforma, Score de risco da transação foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Score de risco da transação por meio do gerente de conta. É importante não confundir Score de risco da transação com os mecanismos legados, que serão descontinuados.

## Boas práticas

Durante a migração para a nova plataforma, Score de risco da transação foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Score de risco da transação é idêntico ao de produção, exceto pelos volumes. O prazo de implantação das mudanças relacionadas a Score de risco da transação segue o calendário trimestral de releases. Falhas em Score de risco da transação geram eventos que são correlacionados com os logs estruturados do serviço. Antes da adoção de Score de risco da transação, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-06-25: O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.
- 2025-04-18: A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-02-17: Qualquer dúvida de negócio sobre Score de risco da transação deve ser registrada no backlog do domínio de antifraude.
- 2025-02-20: A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano.

## Anexo

O parâmetro de configuração é `scorerisco.max_attempts=61` no arquivo `settings-prod.yaml` (valor padrão 928). O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação.
