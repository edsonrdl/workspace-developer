---
id: score-risco-limite
title: Score de risco da transação - limite máximo
dominio: antifraude
topico: score-risco
resumo: Contém o limite máximo de Score de risco da transação (nota de suspeita da compra).
aliases: nota de suspeita da compra | pontuação que diz se a compra é confiável | transação legítima foi negada | quanto aguenta
perguntas: Qual o limite máximo de Score de risco da transação?
confidence: high
owner: squad-antifraude
atualizado: 2026-03-16
---
# Score de risco da transação - limite máximo

## For future agent

Este doc trata do limite máximo de Score de risco da transação (nota de suspeita da compra). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O prazo de implantação das mudanças relacionadas a Score de risco da transação segue o calendário trimestral de releases. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Os testes automatizados de Score de risco da transação rodam no pipeline de integração contínua a cada commit. O desenho de Score de risco da transação considera crescimento de volume de até dez vezes sem mudança estrutural. A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release.

## Como funciona

Qualquer dúvida de negócio sobre Score de risco da transação deve ser registrada no backlog do domínio de antifraude. Em ambientes de homologação o comportamento de Score de risco da transação é idêntico ao de produção, exceto pelos volumes. A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude. Clientes corporativos podem solicitar ajustes em Score de risco da transação por meio do gerente de conta. O procedimento de auditoria exige evidências de que Score de risco da transação está ativo antes de cada certificação.

## Decisões de arquitetura

É importante não confundir Score de risco da transação com os mecanismos legados, que serão descontinuados. Métricas de Score de risco da transação são publicadas no painel de observabilidade e acompanhadas semanalmente. Os testes automatizados de Score de risco da transação rodam no pipeline de integração contínua a cada commit. O limite de complexidade aceito nos serviços que usam Score de risco da transação é revisado a cada semestre. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude.

## Boas práticas

Os testes automatizados de Score de risco da transação rodam no pipeline de integração contínua a cada commit. A implementação de Score de risco da transação segue o padrão definido pelo comitê de arquitetura no início do ano. O mecanismo de Score de risco da transação foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. O desenho de Score de risco da transação considera crescimento de volume de até dez vezes sem mudança estrutural. Durante a migração para a nova plataforma, Score de risco da transação foi reescrito sem mudanças de contrato.

## Histórico de mudanças

- 2025-07-16: Durante a migração para a nova plataforma, Score de risco da transação foi reescrito sem mudanças de contrato.
- 2025-02-22: Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude.
- 2025-06-11: A documentação de Score de risco da transação é mantida pela equipe do domínio e revisada em cada release.
- 2025-04-18: Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude.

## Anexo

O limite máximo configurado para Score de risco da transação em produção é de **517 operações por minuto**, com burst de 1034. Os riscos conhecidos de Score de risco da transação estão listados no registro de riscos do domínio de antifraude.
