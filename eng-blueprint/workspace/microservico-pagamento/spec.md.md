# spec.md — Microserviço de Pagamentos

> Instrução ao agente: leia este arquivo e todos os [[links]] antes de qualquer ação.

---

## Referências constitucionais

<!-- LINK AQUI: regras universais que este serviço não pode violar. O agente lê a constituição antes de entender o problema — porque o problema precisa ser resolvido dentro desses limites. -->

- [[constitution]]

---

## Problema que resolve

O processamento de pagamento está acoplado ao serviço de pedidos. Qualquer falha no pagamento derruba o fluxo de pedidos inteiro. Não há rastreabilidade independente de tentativas e resultados de cobrança.

---

## Visão geral

Microserviço com responsabilidade única de processar e rastrear pagamentos. Recebe solicitações, valida, orquestra a cobrança via gateway externo e emite eventos de resultado para os serviços consumidores.

**Nome:** `payment-service`

---

## Consumidores

|Consumidor|Como consome|O que consome|
|---|---|---|
|`order-service`|HTTP|Inicia pagamento|
|`notification-service`|Evento|`PAYMENT_APPROVED`, `PAYMENT_FAILED`|
|`audit-service`|Evento|Todos os eventos|

---

## Escopo

Dentro: criar pagamento, consultar pagamento, listar por pedido, emitir eventos de resultado.

Fora: reembolso, relatórios financeiros, conciliação, armazenamento de dados de cartão.