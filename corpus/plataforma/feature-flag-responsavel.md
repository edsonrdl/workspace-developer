---
id: feature-flag-responsavel
title: Feature flags - equipe responsável
dominio: plataforma
topico: feature-flag
resumo: Contém o equipe responsável de Feature flags (ligar funcionalidade sem deploy).
aliases: ligar funcionalidade sem deploy | liberar recurso aos poucos | funcionalidade apareceu para todos sem querer | com quem falar | a quem pedir ajuda
perguntas: Qual o equipe responsável de Feature flags? | com quem falar ligar funcionalidade sem deploy?
confidence: high
owner: squad-plataforma
atualizado: 2026-08-15
---
# Feature flags - equipe responsável

## For future agent

Este doc trata do equipe responsável de Feature flags (ligar funcionalidade sem deploy). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. Em ambientes de homologação o comportamento de Feature flags é idêntico ao de produção, exceto pelos volumes. É importante não confundir Feature flags com os mecanismos legados, que serão descontinuados. Clientes corporativos podem solicitar ajustes em Feature flags por meio do gerente de conta. Métricas de Feature flags são publicadas no painel de observabilidade e acompanhadas semanalmente. Falhas em Feature flags geram eventos que são correlacionados com os logs estruturados do serviço.

## Como funciona

Clientes corporativos podem solicitar ajustes em Feature flags por meio do gerente de conta. Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma. Em ambientes de homologação o comportamento de Feature flags é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit. O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe. Os riscos conhecidos de Feature flags estão listados no registro de riscos do domínio de plataforma. O desenho de Feature flags considera crescimento de volume de até dez vezes sem mudança estrutural.

## Boas práticas

O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases. Todas as alterações em Feature flags passam por revisão de pelo menos duas pessoas da equipe. A configuração padrão de Feature flags atende à maioria dos casos, mas pode ser sobrescrita por serviço. Durante a migração para a nova plataforma, Feature flags foi reescrito sem mudanças de contrato. A implementação de Feature flags segue o padrão definido pelo comitê de arquitetura no início do ano. Os testes automatizados de Feature flags rodam no pipeline de integração contínua a cada commit.

## Histórico de mudanças

- 2025-01-20: A documentação de Feature flags é mantida pela equipe do domínio e revisada em cada release.
- 2025-06-14: O limite de complexidade aceito nos serviços que usam Feature flags é revisado a cada semestre.
- 2025-03-19: O procedimento de auditoria exige evidências de que Feature flags está ativo antes de cada certificação.
- 2025-08-21: O prazo de implantação das mudanças relacionadas a Feature flags segue o calendário trimestral de releases.

## Anexo

A equipe responsável por Feature flags é a squad **Helios**, canal #featureflag-suporte (plantão: ramal 865). Exemplos de uso de Feature flags estão disponíveis no repositório de referência da plataforma.
