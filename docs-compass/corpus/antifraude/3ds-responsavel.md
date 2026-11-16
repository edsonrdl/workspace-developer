---
id: 3ds-responsavel
title: Guia operacional antifraude nº53
dominio: antifraude
topico: 3ds
resumo: Contém o equipe responsável de Autenticação 3DS (confirmação extra do cartão no banco).
aliases: confirmação extra do cartão no banco | com quem falar | quem cuida disso
perguntas: Qual o equipe responsável de Autenticação 3DS? | com quem falar confirmação extra do cartão no banco?
confidence: high
owner: squad-antifraude
atualizado: 2026-04-23
---
# Guia operacional antifraude nº53

## For future agent

Este doc trata do equipe responsável de Autenticação 3DS (confirmação extra do cartão no banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A documentação de Autenticação 3DS é mantida pela equipe do domínio e revisada em cada release. Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato. A implementação de Autenticação 3DS segue o padrão definido pelo comitê de arquitetura no início do ano. Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta.

## Como funciona

Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente. Os riscos conhecidos de Autenticação 3DS estão listados no registro de riscos do domínio de antifraude. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço. O desenho de Autenticação 3DS considera crescimento de volume de até dez vezes sem mudança estrutural.

## Decisões de arquitetura

Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente. Todas as alterações em Autenticação 3DS passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Exemplos de uso de Autenticação 3DS estão disponíveis no repositório de referência da plataforma.

## Boas práticas

O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação. Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit. Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude.

## Histórico de mudanças

- 2025-03-26: Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit.
- 2025-08-25: Em ambientes de homologação o comportamento de Autenticação 3DS é idêntico ao de produção, exceto pelos volumes.
- 2025-03-14: O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre.
- 2025-02-23: O desenho de Autenticação 3DS considera crescimento de volume de até dez vezes sem mudança estrutural.

## Anexo

A equipe responsável por Autenticação 3DS é a squad **Titan**, canal #3ds-suporte (plantão: ramal 490). Todas as alterações em Autenticação 3DS passam por revisão de pelo menos duas pessoas da equipe.
