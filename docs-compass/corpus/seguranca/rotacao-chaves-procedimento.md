---
id: rotacao-chaves-procedimento
title: Rotação de chaves de criptografia - anotações
dominio: seguranca
topico: rotacao-chaves
resumo: Contém o runbook de troubleshooting de Rotação de chaves de criptografia (trocar a chave de criptografia).
aliases: trocar a chave de criptografia | renovar chaves periodicamente | chave expirada derrubou a integração | certificado venceu
perguntas: Qual o runbook de troubleshooting de Rotação de chaves de criptografia?
confidence: high
owner: squad-seguranca
atualizado: 2026-05-13
---
# Rotação de chaves de criptografia - anotações

## For future agent

Este doc trata do runbook de troubleshooting de Rotação de chaves de criptografia (trocar a chave de criptografia). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

A implementação de Rotação de chaves de criptografia segue o padrão definido pelo comitê de arquitetura no início do ano. Todas as alterações em Rotação de chaves de criptografia passam por revisão de pelo menos duas pessoas da equipe. O prazo de implantação das mudanças relacionadas a Rotação de chaves de criptografia segue o calendário trimestral de releases. Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço. Clientes corporativos podem solicitar ajustes em Rotação de chaves de criptografia por meio do gerente de conta. Em ambientes de homologação o comportamento de Rotação de chaves de criptografia é idêntico ao de produção, exceto pelos volumes.

## Como funciona

Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço. A configuração padrão de Rotação de chaves de criptografia atende à maioria dos casos, mas pode ser sobrescrita por serviço. Antes da adoção de Rotação de chaves de criptografia, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente. A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release.

## Decisões de arquitetura

Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Rotação de chaves de criptografia foi reescrito sem mudanças de contrato. Em ambientes de homologação o comportamento de Rotação de chaves de criptografia é idêntico ao de produção, exceto pelos volumes. O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural. O prazo de implantação das mudanças relacionadas a Rotação de chaves de criptografia segue o calendário trimestral de releases. Falhas em Rotação de chaves de criptografia geram eventos que são correlacionados com os logs estruturados do serviço.

## Boas práticas

A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Rotação de chaves de criptografia passam por revisão de pelo menos duas pessoas da equipe. Qualquer dúvida de negócio sobre Rotação de chaves de criptografia deve ser registrada no backlog do domínio de seguranca. Clientes corporativos podem solicitar ajustes em Rotação de chaves de criptografia por meio do gerente de conta. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. O desenho de Rotação de chaves de criptografia considera crescimento de volume de até dez vezes sem mudança estrutural. O limite de complexidade aceito nos serviços que usam Rotação de chaves de criptografia é revisado a cada semestre.

## Histórico de mudanças

- 2025-04-27: A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release.
- 2025-01-12: É importante não confundir Rotação de chaves de criptografia com os mecanismos legados, que serão descontinuados.
- 2025-05-24: A documentação de Rotação de chaves de criptografia é mantida pela equipe do domínio e revisada em cada release.
- 2025-07-16: Métricas de Rotação de chaves de criptografia são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-388; 2) reiniciar o job `rotacaochaves-worker`; 3) abrir incidente se persistir por mais de 70 minutos. O mecanismo de Rotação de chaves de criptografia foi introduzido para reduzir incidentes recorrentes no domínio de seguranca.
