# Tasks — HU-142 · api-pagamentos

Retome pela **primeira** `[ ]`. Marque `[x]` só com testes passando. Código vai para o repo de [repo.md](repo.md).

- [ ] T1 — Modelo: estado `aguardando_pix` e campo `expira_em` no pedido, com teste de transição. (AC-4)
- [ ] T2 — `POST /v1/pagamentos/pix`: cria cobrança e devolve QR Code e copia-e-cola. (AC-1)
- [ ] T3 — Regra de expiração: confirmação após `expira_em` não paga o pedido. (AC-2)
- [ ] T4 — Novo QR Code para pedido com QR expirado, pedido segue aberto. (AC-3)
- [ ] T5 — Endpoint de confirmação do banco: valida assinatura, é idempotente, marca `pago`, publica `pagamento.confirmado`. (AC-4)
- [ ] T6 — Consulta de pagamento por número do pedido. (AC-7)

**Sem task (bloqueante):** RN-5 (valor mínimo): aguardando definição do que fazer abaixo de R$ 1,00.
