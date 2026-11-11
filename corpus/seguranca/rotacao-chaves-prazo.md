---
id: rotacao-chaves-prazo
title: Rotação de chaves de criptografia - prazo (SLA)
dominio: seguranca
topico: rotacao-chaves
resumo: Contém o prazo (SLA) de Rotação de chaves de criptografia (trocar a chave de criptografia).
aliases: renovar chaves periodicamente | chave expirada derrubou a integração | tempo de espera
perguntas: Qual o prazo (SLA) de Rotação de chaves de criptografia? | em quanto tempo trocar a chave de criptografia?
confidence: high
owner: squad-seguranca
atualizado: 2026-02-18
---
# Rotação de chaves de criptografia - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Rotação de chaves de criptografia (trocar a chave de criptografia). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. Em ambientes de homologação o comportamento de Rotação de chaves de criptografia é idêntico ao de produção, exceto pelos volumes. Os riscos conhecidos de Rotação de chaves de criptografia estão listados no registro de riscos do domínio de seguranca. Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

O limite de complexidade aceito nos serviços que usam Rotação de chaves de criptografia é revisado a cada semestre. Durante a migração para a nova plataforma, Rotação de chaves de criptografia foi reescrito sem mudanças de contrato. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. Os testes automatizados de Rotação de chaves de criptografia rodam no pipeline de integração contínua a cada commit. O prazo de implantação das mudanças relacionadas a Rotação de chaves de criptografia segue o calendário trimestral de releases.

## Decisões de arquitetura

É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados. A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Rotação de chaves de criptografia é revisado a cada semestre. Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca.

## Boas práticas

O limite de complexidade aceito nos serviços que usam Rotação de chaves de criptografia é revisado a cada semestre. O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural. Todas as alterações em Rotação de chaves de criptografia passam por revisão de pelo menos duas pessoas da equipe. Exemplos de uso de Rotação de chaves de criptografia estão disponíveis no repositório de referência da plataforma. Durante a migração para a nova plataforma, Rotação de chaves de criptografia foi reescrito sem mudanças de contrato.

## Histórico de mudanças

- 2025-08-24: Qualquer dúvida de negócio sobre Rotação de chaves de criptografia deve ser registrada no backlog do domínio de seguranca.
- 2025-08-18: A implementação de Rotação de chaves de criptografia segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-01-12: É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados.
- 2025-03-16: Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Anexo

O prazo (SLA) de atendimento para Rotação de chaves de criptografia é de **55 horas úteis** após a abertura do chamado. Os riscos conhecidos de Rotação de chaves de criptografia estão listados no registro de riscos do domínio de seguranca.
