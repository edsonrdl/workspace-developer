---
id: 3ds-config
title: Autenticação 3DS - parâmetro de configuração
dominio: antifraude
topico: 3ds
resumo: Contém o parâmetro de configuração de Autenticação 3DS (confirmação extra do cartão no banco).
aliases: confirmação extra do cartão no banco | onde configuro | como ajustar
perguntas: Qual o parâmetro de configuração de Autenticação 3DS? | onde configuro confirmação extra do cartão no banco?
confidence: high
owner: squad-antifraude
atualizado: 2026-08-25
---
# Autenticação 3DS - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Autenticação 3DS (confirmação extra do cartão no banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. Antes da adoção de Autenticação 3DS, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O desenho de Autenticação 3DS considera crescimento de volume de até dez vezes sem mudança estrutural. O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato.

## Como funciona

Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta. A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço. Em ambientes de homologação o comportamento de Autenticação 3DS é idêntico ao de produção, exceto pelos volumes. É importante não confundir Autenticação 3DS com os mecanismos legados, que serão descontinuados. O prazo de implantação das mudanças relacionadas a Autenticação 3DS segue o calendário trimestral de releases.

## Decisões de arquitetura

Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço. O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta. A implementação de Autenticação 3DS segue o padrão definido pelo comitê de arquitetura no início do ano. Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato.

## Boas práticas

Durante a migração para a nova plataforma, Autenticação 3DS foi reescrito sem mudanças de contrato. Qualquer dúvida de negócio sobre Autenticação 3DS deve ser registrada no backlog do domínio de antifraude. Os riscos conhecidos de Autenticação 3DS estão listados no registro de riscos do domínio de antifraude. O limite de complexidade aceito nos serviços que usam Autenticação 3DS é revisado a cada semestre. Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente. Clientes corporativos podem solicitar ajustes em Autenticação 3DS por meio do gerente de conta.

## Histórico de mudanças

- 2025-05-26: Os testes automatizados de Autenticação 3DS rodam no pipeline de integração contínua a cada commit.
- 2025-03-25: Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente.
- 2025-05-12: Falhas em Autenticação 3DS geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-07-15: Métricas de Autenticação 3DS são publicadas no painel de observabilidade e acompanhadas semanalmente.

## Anexo

O parâmetro de configuração é `3ds.max_attempts=20` no arquivo `settings-prod.yaml` (valor padrão 71). A configuração padrão de Autenticação 3DS atende à maioria dos casos, mas pode ser sobrescrita por serviço.
