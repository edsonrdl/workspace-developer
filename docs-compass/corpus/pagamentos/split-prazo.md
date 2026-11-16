---
id: split-prazo
title: Guia operacional pagamentos nº12
dominio: pagamentos
topico: split
resumo: Contém o prazo (SLA) de Split de pagamento (dividir o valor entre lojistas).
aliases: dividir o valor entre lojistas | repartir a venda entre vários recebedores | em quanto tempo
perguntas: Qual o prazo (SLA) de Split de pagamento? | em quanto tempo dividir o valor entre lojistas?
confidence: high
owner: squad-pagamentos
atualizado: 2026-06-15
---
# Guia operacional pagamentos nº12

## For future agent

Este doc trata do prazo (SLA) de Split de pagamento (dividir o valor entre lojistas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. Os riscos conhecidos de Split de pagamento estão listados no registro de riscos do domínio de pagamentos.

## Como funciona

A implementação de Split de pagamento segue o padrão definido pelo comitê de arquitetura no início do ano. A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço. Os riscos conhecidos de Split de pagamento estão listados no registro de riscos do domínio de pagamentos. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases.

## Decisões de arquitetura

Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. A documentação de Split de pagamento é mantida pela equipe do domínio e revisada em cada release. Exemplos de uso de Split de pagamento estão disponíveis no repositório de referência da plataforma. É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados.

## Boas práticas

É importante não confundir Split de pagamento com os mecanismos legados, que serão descontinuados. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. Todas as alterações em Split de pagamento passam por revisão de pelo menos duas pessoas da equipe. O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Histórico de mudanças

- 2025-02-11: Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta.
- 2025-02-24: Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta.
- 2025-01-10: O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.
- 2025-03-23: O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases.

## Anexo

O prazo (SLA) de atendimento para Split de pagamento é de **31 horas úteis** após a abertura do chamado. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta.
