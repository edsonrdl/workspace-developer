---
id: velocity-prazo
title: Regras de velocity - prazo (SLA)
dominio: antifraude
topico: velocity
resumo: Contém o prazo (SLA) de Regras de velocity (limite de tentativas em pouco tempo).
aliases: limite de tentativas em pouco tempo | muitas tentativas seguidas bloqueadas | tempo de espera | quando fica pronto
perguntas: Qual o prazo (SLA) de Regras de velocity?
confidence: high
owner: squad-antifraude
atualizado: 2026-08-22
---
# Regras de velocity - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Regras de velocity (limite de tentativas em pouco tempo). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma. A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes. Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

Métricas de Regras de velocity são publicadas no painel de observabilidade e acompanhadas semanalmente. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural. O mecanismo de Regras de velocity foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Decisões de arquitetura

A documentação de Regras de velocity é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta. Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço. Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato. Antes da adoção de Regras de velocity, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O mecanismo de Regras de velocity foi introduzido para reduzir incidentes recorrentes no domínio de antifraude.

## Boas práticas

Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. Métricas de Regras de velocity são publicadas no painel de observabilidade e acompanhadas semanalmente. Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta. A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude.

## Histórico de mudanças

- 2025-08-21: A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano.
- 2025-04-25: Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude.
- 2025-06-27: Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-05-10: Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe.

## Anexo

O prazo (SLA) de atendimento para Regras de velocity é de **60 horas úteis** após a abertura do chamado. Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço.
