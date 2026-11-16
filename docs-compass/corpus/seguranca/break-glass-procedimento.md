---
id: break-glass-procedimento
title: Acesso emergencial (break-glass) - runbook de troubleshooting
dominio: seguranca
topico: break-glass
resumo: Contém o runbook de troubleshooting de Acesso emergencial (break-glass) (acesso de emergência ao banco de produção).
aliases: acesso de emergência ao banco de produção | como resolver | passo a passo para consertar
perguntas: Qual o runbook de troubleshooting de Acesso emergencial (break-glass)? | como resolver acesso de emergência ao banco de produção?
confidence: medium
owner: squad-seguranca
atualizado: 2026-03-21
---
# Acesso emergencial (break-glass) - runbook de troubleshooting

## For future agent

Este doc trata do runbook de troubleshooting de Acesso emergencial (break-glass) (acesso de emergência ao banco de produção). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Todas as alterações em Acesso emergencial (break-glass) passam por revisão de pelo menos duas pessoas da equipe. Antes da adoção de Acesso emergencial (break-glass), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Acesso emergencial (break-glass) atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Acesso emergencial (break-glass) está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Acesso emergencial (break-glass) deve ser registrada no backlog do domínio de seguranca. Os testes automatizados de Acesso emergencial (break-glass) rodam no pipeline de integração contínua a cada commit.

## Como funciona

O desenho de Acesso emergencial (break-glass) considera crescimento de volume de até dez vezes sem mudança estrutural. Falhas em Acesso emergencial (break-glass) geram eventos que são correlacionados com os logs estruturados do serviço. Os testes automatizados de Acesso emergencial (break-glass) rodam no pipeline de integração contínua a cada commit. Métricas de Acesso emergencial (break-glass) são publicadas no painel de observabilidade e acompanhadas semanalmente. A documentação de Acesso emergencial (break-glass) é mantida pela equipe do domínio e revisada em cada release. A implementação de Acesso emergencial (break-glass) segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Acesso emergencial (break-glass) segue o calendário trimestral de releases.

## Decisões de arquitetura

Antes da adoção de Acesso emergencial (break-glass), cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O procedimento de auditoria exige evidências de que Acesso emergencial (break-glass) está ativo antes de cada certificação. Todas as alterações em Acesso emergencial (break-glass) passam por revisão de pelo menos duas pessoas da equipe. Exemplos de uso de Acesso emergencial (break-glass) estão disponíveis no repositório de referência da plataforma. Falhas em Acesso emergencial (break-glass) geram eventos que são correlacionados com os logs estruturados do serviço. Em ambientes de homologação o comportamento de Acesso emergencial (break-glass) é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Acesso emergencial (break-glass) atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Boas práticas

Clientes corporativos podem solicitar ajustes em Acesso emergencial (break-glass) por meio do gerente de conta. Qualquer dúvida de negócio sobre Acesso emergencial (break-glass) deve ser registrada no backlog do domínio de seguranca. Durante a migração para a nova plataforma, Acesso emergencial (break-glass) foi reescrito sem mudanças de contrato. A implementação de Acesso emergencial (break-glass) segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Acesso emergencial (break-glass) segue o calendário trimestral de releases. É importante não confundir Acesso emergencial (break-glass) com os mecanismos legados, que serão descontinuados. Métricas de Acesso emergencial (break-glass) são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Histórico de mudanças

- 2025-04-21: A documentação de Acesso emergencial (break-glass) é mantida pela equipe do domínio e revisada em cada release.
- 2025-05-24: O desenho de Acesso emergencial (break-glass) considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-06-10: Métricas de Acesso emergencial (break-glass) são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-08-19: Métricas de Acesso emergencial (break-glass) são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

Runbook de troubleshooting: 1) confirmar o alerta ALR-41; 2) reiniciar o job `breakglass-worker`; 3) abrir incidente se persistir por mais de 30 minutos. A implementação de Acesso emergencial (break-glass) segue o padrão definido pelo comitê de arquitetura no início do ano.
