---
id: segredos-limite
title: Gestão de segredos - anotações
dominio: seguranca
topico: segredos
resumo: Contém o limite máximo de Gestão de segredos (onde guardar senha de serviço).
aliases: onde guardar senha de serviço | senha vazou no repositório | chave de API foi parar no git | valor máximo permitido
perguntas: Qual o limite máximo de Gestão de segredos?
confidence: high
owner: squad-seguranca
atualizado: 2026-02-22
---
# Gestão de segredos - anotações

## For future agent

Este doc trata do limite máximo de Gestão de segredos (onde guardar senha de serviço). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A implementação de Gestão de segredos segue o padrão definido pelo comitê de arquitetura no início do ano. É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação. Exemplos de uso de Gestão de segredos estão disponíveis no repositório de referência da plataforma. O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. A documentação de Gestão de segredos é mantida pela equipe do domínio e revisada em cada release. Em ambientes de homologação o comportamento de Gestão de segredos é idêntico ao de produção, exceto pelos volumes.

## Como funciona

Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato. Exemplos de uso de Gestão de segredos estão disponíveis no repositório de referência da plataforma. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe. A implementação de Gestão de segredos segue o padrão definido pelo comitê de arquitetura no início do ano. A documentação de Gestão de segredos é mantida pela equipe do domínio e revisada em cada release. O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases. É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre. Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato. Clientes corporativos podem solicitar ajustes em Gestão de segredos por meio do gerente de conta. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe. O desenho de Gestão de segredos considera crescimento de volume de até dez vezes sem mudança estrutural.

## Boas práticas

O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases. Os riscos conhecidos de Gestão de segredos estão listados no registro de riscos do domínio de seguranca. Antes da adoção de Gestão de segredos, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os testes automatizados de Gestão de segredos rodam no pipeline de integração contínua a cada commit. Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato. A implementação de Gestão de segredos segue o padrão definido pelo comitê de arquitetura no início do ano.

## Histórico de mudanças

- 2025-07-19: A configuração padrão de Gestão de segredos atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-07-17: O desenho de Gestão de segredos considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-04-16: É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados.
- 2025-02-13: Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato.

## Anexo

O limite máximo configurado para Gestão de segredos em produção é de **644 operações por minuto**, com burst de 1288. O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases.
