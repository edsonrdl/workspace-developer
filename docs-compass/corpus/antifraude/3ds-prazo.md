---
id: 3ds-prazo
title: Autenticação 3DS - notas
dominio: antifraude
topico: 3ds
resumo: Contém o prazo (SLA) de Autenticação 3DS (confirmação extra do cartão no banco).
aliases: em quanto tempo | tempo de espera | quando fica pronto
perguntas: Qual o prazo (SLA) de Autenticação 3DS?
confidence: high
owner: squad-antifraude
atualizado: 2026-04-16
---
# Autenticação 3DS - notas

## For future agent

Este doc trata do prazo (SLA) de Autenticação 3DS (confirmação extra do cartão no banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta. É importante não confundir Autenticação 3DS com os mecanismos legados, que serão descontinuados. O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases. Em ambientes de homologação o comportamento de Autenticação 3DS é idêntico ao de produção, exceto pelos volumes. O desenho de Autenticação 3DS considera crescimento de volume de até dez vezes sem mudança estrutural. O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço. Todas as alterações em Autenticação 3DS passam por revisão de pelo menos duas pessoas da equipe. O desenho de Autenticação 3DS considera crescimento de volume de até dez vezes sem mudança estrutural. O mecanismo de Autenticação 3DS foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. O procedimento de auditoria exige evidências de que Autenticação 3DS está ativo antes de cada certificação.

## Decisões de arquitetura

Exemplos de uso de Autenticação 3DS estão disponíveis no repositório de referência da plataforma. A implementação de Autenticação 3DS segue o padrão definido pelo comitê de arquitetura no início do ano. Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre.

## Boas práticas

O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases. Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta. A implementação de Autenticação 3DS segue o padrão definido pelo comitê de arquitetura no início do ano. O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre. Os riscos conhecidos de Autenticação 3DS estão listados no registro de riscos do domínio de antifraude. Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço.

## Histórico de mudanças

- 2025-03-21: Todas as alterações em Autenticação 3DS passam por revisão de pelo menos duas pessoas da equipe.
- 2025-04-17: A documentação de Autenticação 3DS é mantida pela equipe do domínio e revisada em cada release.
- 2025-05-17: Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-06-11: Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Anexo

O prazo (SLA) de atendimento para Autenticação 3DS é de **7 horas úteis** após a abertura do chamado. Exemplos de uso de Autenticação 3DS estão disponíveis no repositório de referência da plataforma.
