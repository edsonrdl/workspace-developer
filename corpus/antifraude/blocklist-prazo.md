---
id: blocklist-prazo
title: Lista de bloqueio (blocklist) - prazo (SLA)
dominio: antifraude
topico: blocklist
resumo: Contém o prazo (SLA) de Lista de bloqueio (blocklist) (bloquear cliente ruim).
aliases: bloquear cliente ruim | impedir CPF problemático de comprar | em quanto tempo | tempo de espera | quando fica pronto
perguntas: Qual o prazo (SLA) de Lista de bloqueio (blocklist)?
confidence: high
owner: squad-antifraude
atualizado: 2026-01-20
---
# Lista de bloqueio (blocklist) - prazo (SLA)

## For future agent

Este doc trata do prazo (SLA) de Lista de bloqueio (blocklist) (bloquear cliente ruim). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes. É importante não confundir Lista de bloqueio (blocklist) com os mecanismos legados, que serão descontinuados. A implementação de Lista de bloqueio (blocklist) segue o padrão definido pelo comitê de arquitetura no início do ano. O limite de complexidade aceito nos serviços que usam Lista de bloqueio (blocklist) é revisado a cada semestre. Todas as alterações em Lista de bloqueio (blocklist) passam por revisão de pelo menos duas pessoas da equipe. Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação.

## Como funciona

Em ambientes de homologação o comportamento de Lista de bloqueio (blocklist) é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Lista de bloqueio (blocklist) atende à maioria dos casos, mas pode ser sobrescrita por serviço. Exemplos de uso de Lista de bloqueio (blocklist) estão disponíveis no repositório de referência da plataforma. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. Os riscos conhecidos de Lista de bloqueio (blocklist) estão listados no registro de riscos do domínio de antifraude.

## Decisões de arquitetura

Antes da adoção de Lista de bloqueio (blocklist), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O limite de complexidade aceito nos serviços que usam Lista de bloqueio (blocklist) é revisado a cada semestre. O mecanismo de Lista de bloqueio (blocklist) foi introduzido para reduzir incidentes recorrentes no domínio de antifraude. Clientes corporativos podem solicitar ajustes em Lista de bloqueio (blocklist) por meio do gerente de conta. O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Lista de bloqueio (blocklist) deve ser registrada no backlog do domínio de antifraude.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Lista de bloqueio (blocklist) por meio do gerente de conta. O desenho de Lista de bloqueio (blocklist) considera crescimento de volume de até dez vezes sem mudança estrutural. Falhas em Lista de bloqueio (blocklist) geram eventos que são correlacionados com os logs estruturados do serviço. A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release. Métricas de Lista de bloqueio (blocklist) são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-07-27: Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato.
- 2025-01-18: A documentação de Lista de bloqueio (blocklist) é mantida pela equipe do domínio e revisada em cada release.
- 2025-04-13: Durante a migração para a nova plataforma, Lista de bloqueio (blocklist) foi reescrito sem mudanças de contrato.
- 2025-03-14: O prazo de implantação das mudanças relacionadas a Lista de bloqueio (blocklist) segue o calendário trimestral de releases.

## Anexo

O prazo (SLA) de atendimento para Lista de bloqueio (blocklist) é de **10 horas úteis** após a abertura do chamado. O procedimento de auditoria exige evidências de que Lista de bloqueio (blocklist) está ativo antes de cada certificação.
