---
id: rotacao-chaves-limite
title: Guia operacional seguranca nº111
dominio: seguranca
topico: rotacao-chaves
resumo: Contém o limite máximo de Rotação de chaves de criptografia (trocar a chave de criptografia).
aliases: trocar a chave de criptografia | chave expirada derrubou a integração | certificado venceu | teto | quanto aguenta
perguntas: Qual o limite máximo de Rotação de chaves de criptografia?
confidence: high
owner: squad-seguranca
atualizado: 2026-02-18
---
# Guia operacional seguranca nº111

## For future agent

Este doc trata do limite máximo de Rotação de chaves de criptografia (trocar a chave de criptografia). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente. É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. Os testes automatizados de Rotação de chaves de criptografia rodam no pipeline de integração contínua a cada commit. O limite de complexidade aceito nos serviços que usam Rotação de chaves de criptografia é revisado a cada semestre. O procedimento de auditoria exige evidências de que Rotação de chaves de criptografia está ativo antes de cada certificação. Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca.

## Como funciona

A configuração padrão de Rotação de chaves de criptografia atende à maioria dos casos, mas pode ser sobrescrita por serviço. Clientes corporativos podem solicitar ajustes em Rotação de chaves de criptografia por meio do gerente de conta. É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. A implementação de Rotação de chaves de criptografia segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Rotação de chaves de criptografia segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Rotação de chaves de criptografia foi reescrito sem mudanças de contrato. Todas as alterações em Rotação de chaves de criptografia passam por revisão de pelo menos duas pessoas da equipe.

## Decisões de arquitetura

É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço. A configuração padrão de Rotação de chaves de criptografia atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de Rotação de chaves de criptografia rodam no pipeline de integração contínua a cada commit. A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release.

## Boas práticas

Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os testes automatizados de Rotação de chaves de criptografia rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Rotação de chaves de criptografia por meio do gerente de conta. Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente. Em ambientes de homologação o comportamento de Rotação de chaves de criptografia é idêntico ao de produção, exceto pelos volumes. A implementação de Rotação de chaves de criptografia segue o padrão definido pelo comitê de arquitetura no início do ano. Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço.

## Histórico de mudanças

- 2025-03-18: O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-02-16: Todas as alterações em Rotação de chaves de criptografia passam por revisão de pelo menos duas pessoas da equipe.
- 2025-05-25: Em ambientes de homologação o comportamento de Rotação de chaves de criptografia é idêntico ao de produção, exceto pelos volumes.
- 2025-04-25: Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Anexo

O limite máximo configurado para Rotação de chaves de criptografia em produção é de **237 operações por minuto**, com burst de 474. Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
