---
id: cnab-config
title: Guia operacional conciliacao nº29
dominio: conciliacao
topico: cnab
resumo: Contém o parâmetro de configuração de Arquivo CNAB de remessa (arquivo enviado ao banco).
aliases: arquivo enviado ao banco | layout de arquivo de cobrança | banco rejeitou o arquivo | qual a configuração
perguntas: Qual o parâmetro de configuração de Arquivo CNAB de remessa? | onde configuro arquivo enviado ao banco?
confidence: high
owner: squad-conciliacao
atualizado: 2026-02-26
---
# Guia operacional conciliacao nº29

## For future agent

Este doc trata do parâmetro de configuração de Arquivo CNAB de remessa (arquivo enviado ao banco). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Clientes corporativos podem solicitar ajustes em Arquivo CNAB de remessa por meio do gerente de conta. Durante a migração para a nova plataforma, Arquivo CNAB de remessa foi reescrito sem mudanças de contrato. O procedimento de auditoria exige evidências de que Arquivo CNAB de remessa está ativo antes de cada certificação. Os riscos conhecidos de Arquivo CNAB de remessa estão listados no registro de riscos do domínio de conciliacao. O mecanismo de Arquivo CNAB de remessa foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao.

## Como funciona

O mecanismo de Arquivo CNAB de remessa foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. O prazo de implantação das mudanças relacionadas a Arquivo CNAB de remessa segue o calendário trimestral de releases. Em ambientes de homologação o comportamento de Arquivo CNAB de remessa é idêntico ao de produção, exceto pelos volumes. Os testes automatizados de Arquivo CNAB de remessa rodam no pipeline de integração contínua a cada commit. É importante não confundir Arquivo CNAB de remessa com os mecanismos legados, que serão descontinuados. O procedimento de auditoria exige evidências de que Arquivo CNAB de remessa está ativo antes de cada certificação.

## Decisões de arquitetura

O prazo de implantação das mudanças relacionadas a Arquivo CNAB de remessa segue o calendário trimestral de releases. O limite de complexidade aceito nos serviços que usam Arquivo CNAB de remessa é revisado a cada semestre. É importante não confundir Arquivo CNAB de remessa com os mecanismos legados, que serão descontinuados. Antes da adoção de Arquivo CNAB de remessa, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Os riscos conhecidos de Arquivo CNAB de remessa estão listados no registro de riscos do domínio de conciliacao. O mecanismo de Arquivo CNAB de remessa foi introduzido para reduzir incidentes recorrentes no domínio de conciliacao. Qualquer dúvida de negócio sobre Arquivo CNAB de remessa deve ser registrada no backlog do domínio de conciliacao.

## Boas práticas

Os testes automatizados de Arquivo CNAB de remessa rodam no pipeline de integração contínua a cada commit. Exemplos de uso de Arquivo CNAB de remessa estão disponíveis no repositório de referência da plataforma. Falhas em Arquivo CNAB de remessa geram eventos que são correlacionados com os logs estruturados do serviço. O procedimento de auditoria exige evidências de que Arquivo CNAB de remessa está ativo antes de cada certificação. A implementação de Arquivo CNAB de remessa segue o padrão definido pelo comitê de arquitetura no início do ano. O prazo de implantação das mudanças relacionadas a Arquivo CNAB de remessa segue o calendário trimestral de releases.

## Histórico de mudanças

- 2025-04-27: A documentação de Arquivo CNAB de remessa é mantida pela equipe do domínio e revisada em cada release.
- 2025-08-17: Antes da adoção de Arquivo CNAB de remessa, cada equipe tratava o tema de forma diferente, o que gerava inconsistências.
- 2025-02-12: Qualquer dúvida de negócio sobre Arquivo CNAB de remessa deve ser registrada no backlog do domínio de conciliacao.
- 2025-04-24: A implementação de Arquivo CNAB de remessa segue o padrão definido pelo comitê de arquitetura no início do ano.

## Anexo

O parâmetro de configuração é `cnab.max_attempts=15` no arquivo `settings-prod.yaml` (valor padrão 366). O limite de complexidade aceito nos serviços que usam Arquivo CNAB de remessa é revisado a cada semestre.
