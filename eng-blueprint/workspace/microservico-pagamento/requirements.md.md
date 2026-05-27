# requirements.md — Microserviço de Pagamentos

---

## Referências

<!-- LINK AQUI: os NFRs universais que NÃO estão neste arquivo porque já estão na constituição. -->

- [[constitution]] — NFRs universais: cobertura mínima, segurança, logs sem dados sensíveis, qualidade de código

---

## Requisitos funcionais

**FR-001** — Aceitar solicitação de pagamento com: valor, moeda, método e orderId.

**FR-002** — Validar se o método de pagamento é suportado antes de processar.

**FR-003** — Processar pagamento via gateway externo configurado por variável de ambiente.

**FR-004** — Emitir evento `PAYMENT_APPROVED` quando aprovado.

**FR-005** — Emitir evento `PAYMENT_FAILED` quando recusado ou com erro no gateway.

**FR-006** — Consultar status de um pagamento pelo seu ID.

**FR-007** — Listar pagamentos de um pedido com paginação.

**FR-008** — Registrar cada tentativa de pagamento, aprovada ou não.

---

## Requisitos não funcionais específicos desta feature

<!-- NFRs gerais (80% cobertura, sem segredos no código, logs sem dados sensíveis) estão em [[constitution]] — não repetir. Aqui ficam apenas os NFRs únicos deste serviço. -->

**NFR-001** — Tempo de resposta do endpoint de criação: p99 abaixo de 3s no caminho nominal (gateway responde sem acionar retry).

**NFR-002** — Não armazenar dados de cartão — apenas token retornado pelo gateway.

**NFR-003** — Idempotência obrigatória via header `Idempotency-Key` no endpoint de criação.