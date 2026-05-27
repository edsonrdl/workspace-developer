# contracts.md — Microserviço de Pagamentos

---

## Referências

<!-- LINK AQUI: o envelope de resposta, códigos HTTP, paginação e auth já estão definidos no pattern de REST API. Este arquivo define APENAS o que é único deste serviço: os campos dos endpoints, o modelo de dados e os eventos. O agente lê o pattern e aplica o envelope automaticamente. -->

- [[patterns/rest-api]] — envelope, HTTP codes, paginação, auth, logs

---

## Endpoints

### POST /api/v1/payments

<!-- O envelope { data, meta } e o header Authorization vêm do [[patterns/rest-api]] — não repetir aqui. -->

**Body específico deste serviço:**

```typescript
{
  orderId: string       // uuid do pedido
  amount: {
    value: number       // em centavos
    currency: "BRL"
  }
  method: "CREDIT_CARD" | "PIX" | "BOLETO"
  gatewayToken: string  // token gerado pelo frontend via SDK do gateway
}
```

**Headers adicionais específicos:**

```
Idempotency-Key: uuid   // obrigatório — ver NFR-004 em requirements.md
```

**Retorno de sucesso:** status 201, `data` com o objeto Payment.

---

### GET /api/v1/payments/{paymentId}

Sem body. Retorna objeto Payment completo. Status 200.

---

### GET /api/v1/payments?orderId={uuid}

<!-- Paginação via query params segue [[patterns/rest-api]]. Apenas o filtro específico deste serviço está aqui. -->

**Filtro específico:** `orderId` obrigatório como query param.

---

## Modelo de dados

```typescript
// Tabela: payments_transactions
{
  id: uuid                    // PK
  orderId: uuid               // indexed
  status: enum                // PENDING | APPROVED | FAILED | REFUNDED
  method: enum                // CREDIT_CARD | PIX | BOLETO
  amountValue: integer        // em centavos
  amountCurrency: string      // BRL
  gatewayToken: string        // nunca dados brutos de cartão
  gatewayReference: string    // referência retornada pelo gateway
  idempotencyKey: string      // unique
  attempts: integer           // default 0
  createdAt: timestamp
  updatedAt: timestamp
}
```

---

## Contratos de eventos emitidos

```typescript
// PAYMENT_APPROVED
{
  eventId: uuid
  eventType: "PAYMENT_APPROVED"
  version: 1
  occurredAt: ISO8601
  payload: {
    paymentId: uuid
    orderId: uuid
    method: string
    amountValue: integer
    amountCurrency: string
    gatewayReference: string
  }
}

// PAYMENT_FAILED
{
  eventId: uuid
  eventType: "PAYMENT_FAILED"
  version: 1
  occurredAt: ISO8601
  payload: {
    paymentId: uuid
    orderId: uuid
    reason: string    // motivo legível, sem dados sensíveis
    attempts: integer
  }
}
```