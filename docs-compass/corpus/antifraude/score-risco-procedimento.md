---
id: score-risco-procedimento
title: Score de risco da transação - runbook de troubleshooting
dominio: antifraude
topico: score-risco
resumo: Contém o runbook de troubleshooting de Score de risco da transação (nota de suspeita da compra).
aliases: nota de suspeita da compra | como resolver
perguntas: Qual o runbook de troubleshooting de Score de risco da transação? | como resolver nota de suspeita da compra?
confidence: high
owner: squad-antifraude
atualizado: 2026-01-17
---
# Score de risco da transação - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Score de risco da transação (nota de suspeita da compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A configuração padrão de Score de risco da transação atende à maioria dos casos, mas pode ser sobrescrita por serviço. Em ambientes de homologação o comportamento de Score de risco da transação é idêntico ao de produção, exceto pelos volumes. Qualquer dúvida de negócio sobre Score de risco da transação deve ser registrada no backlog do domínio de antifraude. O prazo de implantação das mudanças relacionadas a Score de risco da transação segue o calendário trimestral de releases. A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release.

## Como funciona

Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude. A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release. Clientes corporativos podem solicitar ajustes em Score de risco da transação por meio do gerente de conta. Exemplos de uso de Score de risco da transação estão disponíveis no repositório de referência da plataforma. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Métricas de Score de risco da transação são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Score de risco da transação segue o calendário trimestral de releases. A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release. Os testes automatizados de Score de risco da transação rodam no pipeline de integração contínua a cada commit. Exemplos de uso de Score de risco da transação estão disponíveis no repositório de referência da plataforma. O limite de complexidade aceito nos serviços que usam Score de risco da transação é revisado a cada semestre. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude.

## Boas práticas

Qualquer dúvida de negócio sobre Score de risco da transação deve ser registrada no backlog do domínio de antifraude. Durante a migração para a nova plataforma, Score de risco da transação foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude.

## Histórico de mudanças

- 2025-05-27: A configuração padrão de Score de risco da transação atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-01-19: Em ambientes de homologação o comportamento de Score de risco da transação é idêntico ao de produção, exceto pelos volumes.
- 2025-01-19: O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação.
- 2025-01-14: A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-440; 2) reiniciar o job `scorerisco-worker`; 3) abrir incidente se persistir por mais de 46 minutos. Falhas em Score de risco da transação geram eventos que são correlacionados com os logs estruturados do serviço.
