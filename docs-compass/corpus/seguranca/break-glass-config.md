---
id: break-glass-config
title: Acesso emergencial (break-glass) - guia
dominio: seguranca
topico: break-glass
resumo: Contém o parâmetro de configuração de Acesso emergencial (break-glass) (acesso de emergência ao banco de produção).
aliases: acesso de emergência ao banco de produção | preciso de acesso ao banco prod agora | acesso negado durante incidente | onde configuro | como ajustar
perguntas: Qual o parâmetro de configuração de Acesso emergencial (break-glass)? | onde configuro acesso de emergência ao banco de produção?
confidence: high
owner: squad-seguranca
atualizado: 2026-06-10
---
# Acesso emergencial (break-glass) - guia

## For future agent

Este doc trata do parâmetro de configuração de Acesso emergencial (break-glass) (acesso de emergência ao banco de produção). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Acesso emergencial (break-glass) estão listados no registro de riscos do domínio de seguranca. O limite de complexidade aceito nos serviços que usam Acesso emergencial (break-glass) é revisado a cada semestre. O procedimento de auditoria exige evidências de que Acesso emergencial (break-glass) está ativo antes de cada certificação. Clientes corporativos podem solicitar ajustes em Acesso emergencial (break-glass) por meio do gerente de conta. Qualquer dúvida de negócio sobre Acesso emergencial (break-glass) deve ser registrada no backlog do domínio de seguranca. É importante não confundir Acesso emergencial (break-glass) com os mecanismos legados, que serão descontinuados. A configuração padrão de Acesso emergencial (break-glass) atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Como funciona

Durante a migração para a nova plataforma, Acesso emergencial (break-glass) foi reescrito sem mudanças de contrato. O desenho de Acesso emergencial (break-glass) considera crescimento de volume de até dez vezes sem mudança estrutural. Em ambientes de homologação o comportamento de Acesso emergencial (break-glass) é idêntico ao de produção, exceto pelos volumes. Clientes corporativos podem solicitar ajustes em Acesso emergencial (break-glass) por meio do gerente de conta. O mecanismo de Acesso emergencial (break-glass) foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. O prazo de implantação das mudanças relacionadas a Acesso emergencial (break-glass) segue o calendário trimestral de releases.

## Decisões de arquitetura

Exemplos de uso de Acesso emergencial (break-glass) estão disponíveis no repositório de referência da plataforma. O mecanismo de Acesso emergencial (break-glass) foi introduzido para reduzir incidentes recorrentes no domínio de seguranca. A documentação de Acesso emergencial (break-glass) é mantida pela equipe do domínio e revisada em cada release. A configuração padrão de Acesso emergencial (break-glass) atende à maioria dos casos, mas pode ser sobrescrita por serviço. A implementação de Acesso emergencial (break-glass) segue o padrão definido pelo comitê de arquitetura no início do ano. Durante a migração para a nova plataforma, Acesso emergencial (break-glass) foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Acesso emergencial (break-glass) está ativo antes de cada certificação.

## Boas práticas

A configuração padrão de Acesso emergencial (break-glass) atende à maioria dos casos, mas pode ser sobrescrita por serviço. O prazo de implantação das mudanças relacionadas a Acesso emergencial (break-glass) segue o calendário trimestral de releases. Qualquer dúvida de negócio sobre Acesso emergencial (break-glass) deve ser registrada no backlog do domínio de seguranca. A implementação de Acesso emergencial (break-glass) segue o padrão definido pelo comitê de arquitetura no início do ano. Clientes corporativos podem solicitar ajustes em Acesso emergencial (break-glass) por meio do gerente de conta. Todas as alterações em Acesso emergencial (break-glass) passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Acesso emergencial (break-glass), cada equipe tratava o tema de forma diferente, o que gerava inconsistências.

## Histórico de mudanças

- 2025-04-25: O prazo de implantação das mudanças relacionadas a Acesso emergencial (break-glass) segue o calendário trimestral de releases.
- 2025-05-13: Falhas em Acesso emergencial (break-glass) geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-02-19: É importante não confundir Acesso emergencial (break-glass) com os mecanismos legados, que serão descontinuados.
- 2025-08-16: O prazo de implantação das mudanças relacionadas a Acesso emergencial (break-glass) segue o calendário trimestral de releases.

## Anexo

O parâmetro de configuração é `breakglass.max_attempts=52` no arquivo `settings-prod.yaml` (valor padrão 930). Os testes automatizados de Acesso emergencial (break-glass) rodam no pipeline de integração contínua a cada commit.
