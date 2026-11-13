---
id: blocklist-config
title: Lista de bloqueio (blocklist) - notas
dominio: antifraude
topico: blocklist
resumo: Contém o parâmetro de configuração de Lista de bloqueio (blocklist) (bloquear cliente ruim).
aliases: bloquear cliente ruim | cliente bloqueado indevidamente | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Lista de bloqueio (blocklist)? | onde configuro bloquear cliente ruim?
confidence: high
owner: squad-antifraude
atualizado: 2026-05-14
---
# Lista de bloqueio (blocklist) - notas

## For future agent

Este doc trata do parâmetro de configuração de Lista de bloqueio (blocklist) (bloquear cliente ruim). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato. Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação. Os testes automatizados de Lista de bloqueio (blocklist) rodam no pipeline de integração contínua a cada commit. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. O limite de complexidade aceito nos serviços que usam Lista de bloqueio (blocklist) é revisado a cada semestre.

## Como funciona

A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço. Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes. O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Lista de bloqueio (blocklist) é revisado a cada semestre. A implementação de Lista de bloqueio (blocklist) segue o padrão definido pelo comitê de arquitetura no início do ano.

## Decisões de arquitetura

Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço. Qualquer dúvida de negócio sobre Lista de bloqueio (blocklist) deve ser registrada no backlog do domínio de antifraude. A implementação de Lista de bloqueio (blocklist) segue o padrão definido pelo comitê de arquitetura no início do ano. Clientes corporativos podem solicitar ajustes em Lista de bloqueio (blocklist) por meio do gerente de conta.

## Boas práticas

Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes. Todas as alterações em Lista de bloqueio (blocklist) passam por revisão de pelo menos duas pessoas da equipe. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação. O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Qualquer dúvida de negócio sobre Lista de bloqueio (blocklist) deve ser registrada no backlog do domínio de antifraude. Os testes automatizados de Lista de bloqueio (blocklist) rodam no pipeline de integração contínua a cada commit. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release.

## Histórico de mudanças

- 2025-06-24: Antes da adoção de Lista de bloqueio (blocklist), cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-08-24: Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes.
- 2025-02-27: A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-01-22: A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O parâmetro de configuração é `blocklist.max_attempts=23` no arquivo `settings-prod.yaml` (valor padrão 928). Todas as alterações em Lista de bloqueio (blocklist) passam por revisão de pelo menos duas pessoas da equipe.
