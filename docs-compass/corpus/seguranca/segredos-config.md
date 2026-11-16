---
id: segredos-config
title: Gestão de segredos - anotações
dominio: seguranca
topico: segredos
resumo: Contém o parâmetro de configuração de Gestão de segredos (onde guardar senha de serviço).
aliases: onde guardar senha de serviço | armazenar credenciais com segurança | onde configuro
perguntas: Qual o parâmetro de configuração de Gestão de segredos?
confidence: high
owner: squad-seguranca
atualizado: 2026-01-19
---
# Gestão de segredos - anotações

## For future agent

Este doc trata do parâmetro de configuração de Gestão de segredos (onde guardar senha de serviço). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases. Falhas em Gestão de segredos geram eventos que são correlacionados com os logs estruturados do serviço. Exemplos de uso de Gestão de segredos estão disponíveis no repositório de referência da plataforma. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre.

## Como funciona

Antes da adoção de Gestão de segredos, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Clientes corporativos podem solicitar ajustes em Gestão de segredos por meio do gerente de conta. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe. Os testes automatizados de Gestão de segredos rodam no pipeline de integração contínua a cada commit. Em ambientes de homologação o comportamento de Gestão de segredos é idêntico ao de produção, exceto pelos volumes.

## Decisões de arquitetura

O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre. Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato. O desenho de Gestão de segredos considera crescimento de volume de até dez vezes sem mudança estrutural. Antes da adoção de Gestão de segredos, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Boas práticas

Durante a migração para a nova plataforma, Gestão de segredos foi reescrito sem mudanças de contrato. O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases. O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação. Métricas de Gestão de segredos são publicadas no painel de observabilidade e acompanhadas semanalmente. O desenho de Gestão de segredos considera crescimento de volume de até dez vezes sem mudança estrutural. Os riscos conhecidos de Gestão de segredos estão listados no registro de riscos do domínio de seguranca. A documentação de Gestão de segredos é mantida pela equipe do domínio e revisada em cada release.

## Histórico de mudanças

- 2025-03-13: Exemplos de uso de Gestão de segredos estão disponíveis no repositório de referência da plataforma.
- 2025-05-14: A documentação de Gestão de segredos é mantida pela equipe do domínio e revisada em cada release.
- 2025-01-10: É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados.
- 2025-01-19: O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre.

## Anexo

O parâmetro de configuração é `segredos.max_attempts=68` no arquivo `settings-prod.yaml` (valor padrão 100). É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados.
