---
id: split-config
title: Split de pagamento - parâmetro de configuração
dominio: pagamentos
topico: split
resumo: Contém o parâmetro de configuração de Split de pagamento (dividir o valor entre lojistas).
aliases: dividir o valor entre lojistas | repasse veio com valor errado | onde configuro | qual a configuração
perguntas: Qual o parâmetro de configuração de Split de pagamento? | onde configuro dividir o valor entre lojistas?
confidence: high
owner: squad-pagamentos
atualizado: 2026-04-11
---
# Split de pagamento - parâmetro de configuração

## For future agent

Este doc trata do parâmetro de configuração de Split de pagamento (dividir o valor entre lojistas). Use quando precisar dessa informação; para outros aspectos do mesmo tópico, veja os docs vizinhos.

## Contexto

Os riscos conhecidos de Split de pagamento estão listados no registro de riscos do domínio de pagamentos. A configuração padrão de Split de pagamento atende à maioria dos casos, mas pode ser sobrescrita por serviço. O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação. O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases. O desenho de Split de pagamento considera crescimento de volume de até dez vezes sem mudança estrutural.

## Como funciona

Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. Antes da adoção de Split de pagamento, cada equipe tratava o tema de forma diferente, o que gerava inconsistências. O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases. Os riscos conhecidos de Split de pagamento estão listados no registro de riscos do domínio de pagamentos. A documentação de Split de pagamento é mantida pela equipe do domínio e revisada em cada release. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.

## Decisões de arquitetura

O procedimento de auditoria exige evidências de que Split de pagamento está ativo antes de cada certificação. Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta. Em ambientes de homologação o comportamento de Split de pagamento é idêntico ao de produção, exceto pelos volumes. Falhas em Split de pagamento geram eventos que são correlacionados com os logs estruturados do serviço. Métricas de Split de pagamento são publicadas no painel de observabilidade e acompanhadas semanalmente. O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos. Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos.

## Boas práticas

A documentação de Split de pagamento é mantida pela equipe do domínio e revisada em cada release. Qualquer dúvida de negócio sobre Split de pagamento deve ser registrada no backlog do domínio de pagamentos. O prazo de implantação das mudanças relacionadas a Split de pagamento segue o calendário trimestral de releases. Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit. O limite de complexidade aceito nos serviços que usam Split de pagamento é revisado a cada semestre.

## Histórico de mudanças

- 2025-07-18: O desenho de Split de pagamento considera crescimento de volume de até dez vezes sem mudança estrutural.
- 2025-07-13: Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta.
- 2025-08-20: O mecanismo de Split de pagamento foi introduzido para reduzir incidentes recorrentes no domínio de pagamentos.
- 2025-02-17: Os testes automatizados de Split de pagamento rodam no pipeline de integração contínua a cada commit.

## Anexo

O parâmetro de configuração é `split.max_attempts=54` no arquivo `settings-prod.yaml` (valor padrão 79). Clientes corporativos podem solicitar ajustes em Split de pagamento por meio do gerente de conta.
