# acceptance.md — Microserviço de Pagamentos

---

## Referências

<!-- LINK AQUI: os critérios de aceite validam os requisitos. O agente lê os requisitos antes de avaliar se algo passou ou falhou. -->

- [[requirements.md]] — requisitos que estes critérios validam
- [[contracts.md]] — contratos que os testes devem verificar

---

## Critérios de aceite

<!-- Regras universais (logs sem dados sensíveis, cobertura ≥ 80%, GET /health) estão em [[constitution]] e [[patterns/microservice]] — não repetir aqui. -->

- [ ] POST persiste pagamento com status `PENDING` antes de chamar o gateway (FR-001, FR-003)
- [ ] Evento é emitido somente após confirmação do gateway, nunca antes (FR-004, FR-005)
- [ ] Segunda chamada com mesmo `Idempotency-Key` retorna resultado original sem reprocessar (NFR-003)
- [ ] GET retorna 404 para `paymentId` inexistente

---

## Casos de borda

|Caso|Comportamento esperado|
|---|---|
|`Idempotency-Key` já usada|200 com resultado original, sem reprocessar|
|Gateway retorna timeout|Retry com backoff, após 3 falhas emite `PAYMENT_FAILED`|
|Método de pagamento não suportado|400 — `UNSUPPORTED_PAYMENT_METHOD`|
|Pagamento já aprovado, nova tentativa chega|409 — `PAYMENT_ALREADY_PROCESSED`|
|Valor zero ou negativo|400 — `INVALID_AMOUNT`|

---

## Suposições

- Frontend tokeniza o cartão via SDK do gateway — este serviço recebe apenas o token
- `order-service` garante que o `orderId` existe antes de chamar este serviço
- Fila de eventos já provisionada — este serviço apenas publica
- Credenciais do gateway são injetadas via AWS Parameter Store no deploy