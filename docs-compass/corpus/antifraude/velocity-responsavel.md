---
id: velocity-responsavel
title: Guia operacional antifraude nº58
dominio: antifraude
topico: velocity
resumo: Contém o equipe responsável de Regras de velocity (limite de tentativas em pouco tempo).
aliases: limite de tentativas em pouco tempo | bloquear muitas compras seguidas | cliente travado após errar o cartão | com quem falar | quem cuida disso
perguntas: Qual o equipe responsável de Regras de velocity? | com quem falar limite de tentativas em pouco tempo?
confidence: high
owner: squad-antifraude
atualizado: 2026-08-21
---
# Guia operacional antifraude nº58

## For future agent

Este doc trata do equipe responsável de Regras de velocity (limite de tentativas em pouco tempo). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Métricas de Regras de velocity são publicadas no painel de observabilidade e acompanhadas semanalmente. O mecanismo de Regras de velocity foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. O prazo de implantação das mudanças relacionadas a Regras de velocity segue o calendário trimestral de releases. A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. Em ambientes de homologação o comportamento de Regras de velocity é idêntico ao de produção, exceto pelos volumes. Os riscos conhecidos de Regras de velocity estão listados no registro de riscos do domínio de antifraude. A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano.

## Como funciona

Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta. Os testes automatizados de Regras de velocity rodam no pipeline de integração contínua a cada commit. A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. O prazo de implantação das mudanças relacionadas a Regras de velocity segue o calendário trimestral de releases. A configuração padrão de Regras de velocity atende à maioria dos casos, mas pode ser sobrescrita por serviço. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma.

## Decisões de arquitetura

Durante a migração para a nova plataforma, Regras de velocity foi reescrito sem mudanças de contrato. Exemplos de uso de Regras de velocity estão disponíveis no repositório de referência da plataforma. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Regras de velocity deve ser registrada no backlog do domínio de antifraude. Clientes corporativos podem solicitar ajustes em Regras de velocity por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Regras de velocity é revisado a cada semestre.

## Boas práticas

A documentação de Regras de velocity é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe. A implementação de Regras de velocity segue o padrão definido pelo comitê de arquitetura no início do ano. O procedimento de auditoria exige evidências de que Regras de velocity está ativo antes de cada certificação. O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural.

## Histórico de mudanças

- 2025-06-15: Os testes automatizados de Regras de velocity rodam no pipeline de integração contínua a cada commit.
- 2025-04-22: O desenho de Regras de velocity considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-05-23: É importante não confundir Regras de velocity com os mecanismos legados, que serão descontinuados.
- 2025-02-15: Todas as alterações em Regras de velocity passam por revisão de pelo menos duas pessoas da equipe.

## Anexo

A equipe responsável por Regras de velocity é a squad **Helios**, canal #velocity-suporte (plantão: ramal 296). Falhas em Regras de velocity geram eventos que são correlacionados com os logs estruturados do serviço.
