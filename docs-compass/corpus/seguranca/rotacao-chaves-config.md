---
id: rotacao-chaves-config
title: Rotação de chaves de criptografia - parâmetro de configuração
dominio: seguranca
topico: rotacao-chaves
resumo: Contém o parâmetro de configuração de Rotação de chaves de criptografia (trocar a chave de criptografia).
aliases: trocar a chave de criptografia | onde configuro | como ajustar
perguntas: Qual o parâmetro de configuração de Rotação de chaves de criptografia?
confidence: high
owner: squad-seguranca
atualizado: 2026-06-22
---
# Rotação de chaves de criptografia - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Rotação de chaves de criptografia (trocar a chave de criptografia). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Todas as alterações em Rotação de chaves de criptografia passam por revisão de pelo menos duas pessoas da equipe. A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release. É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Rotação de chaves de criptografia está ativo antes de cada certificação. O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

Durante a migração para a nova plataforma, Rotação de chaves de criptografia foi reescrito sem mudanças de contrato. A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release. É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço. A configuração padrão de Rotação de chaves de criptografia atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Rotação de chaves de criptografia está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Rotação de chaves de criptografia deve ser registrada no backlog do domínio de seguranca.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Rotação de chaves de criptografia segue o calendário trimestral de releases. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. Os riscos conhecidos de Rotação de chaves de criptografia estão listados no registro de riscos do domínio de seguranca. O procedimento de auditoria exige evidências de que Rotação de chaves de criptografia está ativo antes de cada certificação. O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural. Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Boas práticas

A configuração padrão de Rotação de chaves de criptografia atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Rotação de chaves de criptografia estão listados no registro de riscos do domínio de seguranca. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. Em ambientes de homologação o comportamento de Rotação de chaves de criptografia é idêntico ao de produção, exceto pelos volumes. O procedimento de auditoria exige evidências de que Rotação de chaves de criptografia está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-05-21: Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-04-22: Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-06-25: Clientes corporativos podem solicitar ajustes em Rotação de chaves de criptografia por meio do gerente de conta.
- 2025-07-10: Durante a migração para a nova plataforma, Rotação de chaves de criptografia foi reescrito sem mudanças de contrato.

## Anexo

O parâmetro de configuração é `rotacaochaves.max_attempts=26` no arquivo `settings-prod.yaml` (valor padrão 893). Qualquer dúvida de negócio sobre Rotação de chaves de criptografia deve ser registrada no backlog do domínio de seguranca.
