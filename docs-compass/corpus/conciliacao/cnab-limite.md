---
id: cnab-limite
title: Arquivo CNAB de remessa - limite máximo
dominio: conciliacao
topico: cnab
resumo: Contém o limite máximo de Arquivo CNAB de remessa (arquivo enviado ao banco).
aliases: teto | quanto aguenta
perguntas: Qual o limite máximo de Arquivo CNAB de remessa? | teto arquivo enviado ao banco?
confidence: high
owner: squad-conciliacao
atualizado: 2026-01-21
---
# Arquivo CNAB de remessa - limite máximo

## For future agent

Este doc trata do limite máximo de Arquivo CNAB de remessa (arquivo enviado ao banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O mecanismo de Arquivo CNAB de remessa foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Os riscos conhecidos de Arquivo CNAB de remessa estão listados no registro de riscos do domínio de conciliacao. O prazo de implantação das mudanças relacionadas a Arquivo CNAB de remessa segue o calendário trimestral de releases. Em ambientes de homologação o comportamento de Arquivo CNAB de remessa é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Arquivo CNAB de remessa atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

O limite de complexidade aceito nos serviços que usam Arquivo CNAB de remessa é revisado a cada semestre. Métricas de Arquivo CNAB de remessa são publicadas no painel de observabilidade e acompanhadas semanalmente. A documentação de Arquivo CNAB de remessa é mantida pela equipe do domínio e revisada em cada release. Clientes corporativos podem solicitar ajustes em Arquivo CNAB de remessa por meio do gerente de conta. Os testes automatizados de Arquivo CNAB de remessa rodam no pipeline de integração contínua a cada commit.

## Decisões de arquitetura

O desenho de Arquivo CNAB de remessa considera crescimento de volume de até dez vezes sem mudança estrutural. Antes da adoção de Arquivo CNAB de remessa, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A documentação de Arquivo CNAB de remessa é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Arquivo CNAB de remessa passam por revisão de pelo menos duas pessoas da equipe. Falhas em Arquivo CNAB de remessa geram eventos que são correlacionados com os logs estruturados do serviço. O prazo de implantação das mudanças relacionadas a Arquivo CNAB de remessa segue o calendário trimestral de releases.

## Boas práticas

O prazo de implantação das mudanças relacionadas a Arquivo CNAB de remessa segue o calendário trimestral de releases. O procedimento de auditoria exige evidências de que Arquivo CNAB de remessa está ativo antes de cada certificação. Em ambientes de homologação o comportamento de Arquivo CNAB de remessa é idêntico ao de produção, exceto pelos volumes. Todas as alterações em Arquivo CNAB de remessa passam por revisão de pelo menos duas pessoas da equipe. Métricas de Arquivo CNAB de remessa são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Arquivo CNAB de remessa estão disponíveis no repositório de referência da plataforma.

## Histórico de mudanças

- 2025-06-12: Clientes corporativos podem solicitar ajustes em Arquivo CNAB de remessa por meio do gerente de conta.
- 2025-06-20: O procedimento de auditoria exige evidências de que Arquivo CNAB de remessa está ativo antes de cada certificação.
- 2025-07-13: Exemplos de uso de Arquivo CNAB de remessa estão disponíveis no repositório de referência da plataforma.
- 2025-02-20: Em ambientes de homologação o comportamento de Arquivo CNAB de remessa é idêntico ao de produção, exceto pelos volumes.

## Anexo

O limite máximo configurado para Arquivo CNAB de remessa em produção é de **201 operações por minuto**, com burst de 402. A configuração padrão de Arquivo CNAB de remessa atende à maioria dos casos, mas pode ser sobrescrita por serviço.
