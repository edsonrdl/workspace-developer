# spec.md — Microserviço de Pagamentos

> Instrução ao agente: leia este arquivo e todos os links antes de qualquer ação.

---

## Problema que resolve

O processamento de pagamento está acoplado ao serviço de pedidos. Qualquer falha no pagamento derruba o fluxo de pedidos inteiro. Não há rastreabilidade independente de tentativas e resultados de cobrança.

---

## Visão geral

Microserviço com responsabilidade única de processar e rastrear pagamentos. Recebe solicitações, valida, orquestra a cobrança via gateway externo e emite eventos de resultado para os serviços consumidores.

**Nome:** `payment-service`

---

## Consumidores

| Consumidor             | Como consome | O que consome                        |
| ---------------------- | ------------ | ------------------------------------ |
| `order-service`        | HTTP         | Inicia pagamento                     |
| `notification-service` | Evento       | `PAYMENT_APPROVED`, `PAYMENT_FAILED` |
| `audit-service`        | Evento       | Todos os eventos                     |

---

## Escopo

Dentro: criar pagamento, consultar pagamento, listar por pedido, emitir eventos de resultado.

Fora: reembolso, relatórios financeiros, conciliação, armazenamento de dados de cartão.

## Ordem de leitura obrigatória

O agente deve ler os arquivos nesta sequência antes de qualquer ação:

1. [[constitution]]             — regras universais inegociáveis
2. [[patterns/microservice]]    — estrutura de pastas, comunicação, resiliência, deploy
3. [[patterns/rest-api]]        — contratos HTTP, envelope de resposta, autenticação
4. [[requirements.md]]          — o que precisa ser construído neste serviço
5. [[contracts.md]]             — endpoints, modelo de dados, eventos
6. [[acceptance.md]]            — como validar o que foi construído
7. [[plan.md]]                  — decisões técnicas específicas deste serviço
8. [[tasks.md]]                 — implementar nesta ordem