---
id: score-risco-prazo
title: Score de risco da transação - prazo (SLA)
dominio: antifraude
topico: score-risco
resumo: Contém o prazo (SLA) de Score de risco da transação (nota de suspeita da compra).
aliases: nota de suspeita da compra | transação legítima foi negada | tempo de espera
perguntas: Qual o prazo (SLA) de Score de risco da transação? | em quanto tempo nota de suspeita da compra?
confidence: high
owner: squad-antifraude
atualizado: 2026-04-10
---
# Score de risco da transação - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Score de risco da transação (nota de suspeita da compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Score de risco da transação com os mecanismos legados, que serão descontinuados. A configuração padrão de Score de risco da transação atende à maioria dos casos, mas pode ser sobrescrita por serviço. Todas as alterações em Score de risco da transação passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Score de risco da transação, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Falhas em Score de risco da transação geram eventos que são correlacionados com os logs estruturados do serviço.

## Como funciona

A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude. O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Em ambientes de homologação o comportamento de Score de risco da transação é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

É importante não confundir Score de risco da transação com os mecanismos legados, que serão descontinuados. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de Score de risco da transação estão disponíveis no repositório de referência da plataforma. A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano.

## Boas práticas

Métricas de Score de risco da transação são publicadas no painel de observabilidade e acompanhadas semanalmente. A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano. Qualquer dúvida de negócio sobre Score de risco da transação deve ser registrada no backlog do domínio de antifraude. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude. O desenho de Score de risco da transação considera crescimento de volume de até dez vezes sem mudança estrutural. É importante não confundir Score de risco da transação com os mecanismos legados, que serão descontinuados. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Histórico de mudanças

- 2025-02-15: O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.
- 2025-02-13: Exemplos de uso de Score de risco da transação estão disponíveis no repositório de referência da plataforma.
- 2025-03-24: Clientes corporativos podem solicitar ajustes em Score de risco da transação por meio do gerente de conta.
- 2025-01-20: Todas as alterações em Score de risco da transação passam por revisão de pelo menos duas pessoas da equipe.

## Anexo

O prazo (SLA) de atendimento para Score de risco da transação é de **11 horas úteis** após a abertura do chamado. A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano.
