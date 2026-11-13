---
id: split-limite
title: Guia operacional pagamentos nº11
dominio: pagamentos
topico: split
resumo: Contém o limite máximo de Split de pagamento (dividir o valor entre lojistas).
aliases: dividir o valor entre lojistas | repasse veio com valor errado
perguntas: Qual o limite máximo de Split de pagamento? | teto dividir o valor entre lojistas?
confidence: high
owner: squad-pagamentos
atualizado: 2026-05-25
---
# Guia operacional pagamentos nº11

## For future agent

Este doc trata do limite máximo de Split de pagamento (dividir o valor entre lojistas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases. Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe.

## Como funciona

É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados. A documentação de Split de pagamento é mantida pela equipe do domínio e revisada em cada release. Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe. Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço.

## Decisões de arquitetura

Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. O desenho de Split de pagamento considera crescimento de volume de até dez vezes sem mudança estrutural. A documentação de Split de pagamento é mantida pela equipe do domínio e revisada em cada release. É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados. O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases. Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato.

## Boas práticas

A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. Métricas de Split de pagamento são publicadas no painel de observabilidade e acompanhadas semanalmente. Durante a migração para a nova plataforma, Split de pagamento foi reescrito sem mudanças de contrato. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. O desenho de Split de pagamento considera crescimento de volume de até dez vezes sem mudança estrutural.

## Histórico de mudanças

- 2025-08-26: A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-02-14: A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço.
- 2025-07-19: Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit.
- 2025-07-15: Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos.

## Anexo

O limite máximo configurado para Split de pagamento em produção é de **439 operações por minuto**, com burst de 878. A documentação de Split de pagamento é mantida pela equipe do domínio e revisada em cada release.
