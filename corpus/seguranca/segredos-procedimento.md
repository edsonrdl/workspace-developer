---
id: segredos-procedimento
title: Guia operacional seguranca nº105
dominio: seguranca
topico: segredos
resumo: Contém o runbook de troubleshooting de Gestão de segredos (onde guardar senha de serviço).
aliases: onde guardar senha de serviço | chave de API foi parar no git | como resolver | passo a passo para consertar | o que fazer quando der problema
perguntas: Qual o runbook de troubleshooting de Gestão de segredos?
confidence: high
owner: squad-seguranca
atualizado: 2026-03-11
---
# Guia operacional seguranca nº105

## For future agent

Este doc trata do runbook de troubleshooting de Gestão de segredos (onde guardar senha de serviço). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação. Antes da adoção de Gestão de segredos, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Falhas em Gestão de segredos geram eventos que são correlacionados com os logs estruturados do serviço. É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. Exemplos de uso de Gestão de segredos estão disponíveis no repositório de referência da plataforma.

## Como funciona

O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre. É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. A implementação de Gestão de segredos segue o padrão definido pelo comitê de arquitetura no início do ano. O mecanismo de Gestão de segredos foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. Clientes corporativos podem solicitar ajustes em Gestão de segredos por meio do gerente de conta. Métricas de Gestão de segredos são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Decisões de arquitetura

O desenho de Gestão de segredos considera crescimento de volume de até dez vezes sem mudança estrutural. O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação. O prazo de implantação das mudanças relacionadas a Gestão de segredos segue o calendário trimestral de releases. A documentação de Gestão de segredos é mantida pela equipe do domínio e revisada em cada release. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre.

## Boas práticas

É importante não confundir Gestão de segredos com os mecanismos legados, que serão descontinuados. O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre. A implementação de Gestão de segredos segue o padrão definido pelo comitê de arquitetura no início do ano. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe. Falhas em Gestão de segredos geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Gestão de segredos está ativo antes de cada certificação.

## Histórico de mudanças

- 2025-06-24: Os riscos conhecidos de Gestão de segredos estão listados no registro de riscos do domínio de seguranca.
- 2025-07-21: Exemplos de uso de Gestão de segredos estão disponíveis no repositório de referência da plataforma.
- 2025-02-21: O desenho de Gestão de segredos considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-06-15: O limite de complexidade aceito nos serviços que usam Gestão de segredos é revisado a cada semestre.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-417; 2) reiniciar o job `segredos-worker`; 3) abrir incidente se persistir por mais de 11 minutos. Todas as alterações em Gestão de segredos passam por revisão de pelo menos duas pessoas da equipe.
