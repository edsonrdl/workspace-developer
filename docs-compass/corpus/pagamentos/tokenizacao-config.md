---
id: tokenizacao-config
title: Tokenização de cartão - parâmetro de configuração
dominio: pagamentos
topico: tokenizacao
resumo: Contém o parâmetro de configuração de Tokenização de cartão (guardar cartão do cliente).
aliases: guardar cartão do cliente | salvar cartão para compras futuras | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Tokenização de cartão?
confidence: high
owner: squad-pagamentos
atualizado: 2026-04-15
---
# Tokenização de cartão - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Tokenização de cartão (guardar cartão do cliente). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Antes da adoção de Tokenização de cartão, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. É importante não confundir Tokenização de cartão com os mecanismos legados, que serão descontinuados. Qualquer dúvida de negócio sobre Tokenização de cartão deve ser registrada no backlog do domínio de pagamentos. A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço. Falhas em Tokenização de cartão geram eventos que são correlacionados com os logs estruturados do serviço.

## Como funciona

Em ambientes de homologação o comportamento de Tokenização de cartão é idêntico ao de produção, exceto pelos volumes. É importante não confundir Tokenização de cartão com os mecanismos legados, que serão descontinuados. Clientes corporativos podem solicitar ajustes em Tokenização de cartão por meio do gerente de conta. Os testes automatizados de Tokenização de cartão rodam no pipeline de integração contínua a cada commit. Exemplos de uso de Tokenização de cartão estão disponíveis no repositório de referência da plataforma. A documentação de Tokenização de cartão é mantida pela equipe do domínio e revisada em cada release. Qualquer dúvida de negócio sobre Tokenização de cartão deve ser registrada no backlog do domínio de pagamentos.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Tokenização de cartão está ativo antes de cada certificação. Qualquer dúvida de negócio sobre Tokenização de cartão deve ser registrada no backlog do domínio de pagamentos. O prazo de implantação das mudanças relacionadas a Tokenização de cartão segue o calendário trimestral de releases. A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço. É importante não confundir Tokenização de cartão com os mecanismos legados, que serão descontinuados.

## Boas práticas

Qualquer dúvida de negócio sobre Tokenização de cartão deve ser registrada no backlog do domínio de pagamentos. É importante não confundir Tokenização de cartão com os mecanismos legados, que serão descontinuados. Clientes corporativos podem solicitar ajustes em Tokenização de cartão por meio do gerente de conta. O limite de complexidade aceito nos serviços que usam Tokenização de cartão é revisado a cada semestre. Métricas de Tokenização de cartão são publicadas no painel de observabilidade e acompanhadas semanalmente. A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Tokenização de cartão estão listados no registro de riscos do domínio de pagamentos.

## Histórico de mudanças

- 2025-05-10: A documentação de Tokenização de cartão é mantida pela equipe do domínio e revisada em cada release.
- 2025-08-14: Falhas em Tokenização de cartão geram eventos que são correlacionados com os logs estruturados do serviço.
- 2025-01-24: O limite de complexidade aceito nos serviços que usam Tokenização de cartão é revisado a cada semestre.
- 2025-05-16: A configuração padrão de Tokenização de cartão atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Anexo

O parâmetro de configuração é `tokenizacao.max_attempts=47` no arquivo `settings-prod.yaml` (valor padrão 84). Durante a migração para a nova plataforma, Tokenização de cartão foi reescrito sem mudanças de contrato.
