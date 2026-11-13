---
id: blocklist-limite
title: Guia operacional antifraude nº46
dominio: antifraude
topico: blocklist
resumo: Contém o limite máximo de Lista de bloqueio (blocklist) (bloquear cliente ruim).
aliases: bloquear cliente ruim | teto | quanto aguenta | valor máximo permitido
perguntas: Qual o limite máximo de Lista de bloqueio (blocklist)? | teto bloquear cliente ruim?
confidence: high
owner: squad-antifraude
atualizado: 2026-08-22
---
# Guia operacional antifraude nº46

## For future agent

Este doc trata do limite máximo de Lista de bloqueio (blocklist) (bloquear cliente ruim). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Lista de bloqueio (blocklist) por meio do gerente de conta. Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude. A implementação de Lista de bloqueio (blocklist) segue o padrão definido pelo comitê de arquitetura no início do ano. O desenho de Lista de bloqueio (blocklist) considera crescimento de volume de até dez vezes sem mudança estrutural. É importante não confundir Lista de bloqueio (blocklist) com os mecanismos legados, que serão descontinuados.

## Como funciona

O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato. O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. A implementação de Lista de bloqueio (blocklist) segue o padrão definido pelo comitê de arquitetura no início do ano. Métricas de Lista de bloqueio (blocklist) são publicadas no painel de observabilidade e acompanhadas semanalmente. Os testes automatizados de Lista de bloqueio (blocklist) rodam no pipeline de integração contínua a cada commit. A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Decisões de arquitetura

Exemplos de uso de Lista de bloqueio (blocklist) estão disponíveis no repositório de referência da plataforma. Antes da adoção de Lista de bloqueio (blocklist), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Qualquer dúvida de negócio sobre Lista de bloqueio (blocklist) deve ser registrada no backlog do domínio de antifraude. Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. Falhas em Lista de bloqueio (blocklist) geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Lista de bloqueio (blocklist) passam por revisão de pelo menos duas pessoas da equipe.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Lista de bloqueio (blocklist) por meio do gerente de conta. Antes da adoção de Lista de bloqueio (blocklist), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. Os testes automatizados de Lista de bloqueio (blocklist) rodam no pipeline de integração contínua a cada commit.

## Histórico de mudanças

- 2025-06-19: Antes da adoção de Lista de bloqueio (blocklist), cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-05-13: A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release.
- 2025-04-24: Clientes corporativos podem solicitar ajustes em Lista de bloqueio (blocklist) por meio do gerente de conta.
- 2025-03-11: O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação.

## Anexo

O limite máximo configurado para Lista de bloqueio (blocklist) em produção é de **375 operações por minuto**, com burst de 750. A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço.
