---
id: split-procedimento
title: Split de pagamento - runbook de troubleshooting
dominio: pagamentos
topico: split
resumo: Contém o runbook de troubleshooting de Split de pagamento (dividir o valor entre lojistas).
aliases: dividir o valor entre lojistas | repasse veio com valor errado | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Split de pagamento? | como resolver dividir o valor entre lojistas?
confidence: high
owner: squad-pagamentos
atualizado: 2026-02-12
---
# Split de pagamento - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Split de pagamento (dividir o valor entre lojistas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. Métricas de Split de pagamento são publicadas no painel de observabilidade e acompanhadas semanalmente. Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos.

## Como funciona

A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O desenho de Split de pagamento considera crescimento de volume de até dez vezes sem mudança estrutural. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação.

## Decisões de arquitetura

Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos. O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados. A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano.

## Boas práticas

O limite de complexidade aceito nos serviços que usam Split de pagamento é revisado a cada semestre. O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit.

## Histórico de mudanças

- 2025-04-10: Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato.
- 2025-08-15: Falhas em Split de pagamento geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-06-19: Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma.
- 2025-05-11: Métricas de Split de pagamento são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-676; 2) reiniciar o job `split-worker`; 3) abrir incidente se persistir por mais de 57 minutos. Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos.
