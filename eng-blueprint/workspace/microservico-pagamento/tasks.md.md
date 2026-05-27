# tasks.md — Microserviço de Pagamentos

---

## Referências

<!-- LINK AQUI: as tarefas derivam do plano técnico e dos contratos. O agente lê o plan e os contracts antes de executar qualquer tarefa. A ordem das tarefas abaixo é a ordem de implementação. -->

- [[plan.md]] — decisões técnicas que guiam cada tarefa
- [[contracts.md]] — o que cada tarefa deve produzir
- [[acceptance.md]] — como validar que cada tarefa está correta

---

## Ordem de implementação

<!-- Cada tarefa é atômica — pode ser implementada e testada de forma isolada. O agente não avança para a próxima sem a anterior estar com testes passando. -->

### TASK-001 — Estrutura do projeto

- Criar estrutura de pastas conforme [[patterns/microservice]]
- Configurar TypeScript, ESLint, Jest
- Configurar variáveis de ambiente com validação no boot

### TASK-002 — Modelo de dados e migração

- Criar entidade `Payment` conforme modelo em [[contracts.md]]
- Criar migration inicial da tabela `payments_transactions`
- Criar repository com métodos: `save`, `findById`, `findByOrderId`, `findByIdempotencyKey`

### TASK-003 — Caso de uso: criar pagamento

- Implementar `CreatePaymentUseCase` na camada `application/`
- Incluir verificação de idempotência antes de chamar gateway
- Incluir lógica de ordem de operações conforme [[plan.md]]
- Testes unitários cobrindo fluxo feliz e casos de borda de [[acceptance.md]]

### TASK-004 — Integração com gateway

- Implementar `GatewayClient` na camada `infrastructure/`
- Timeout e retry exponencial conforme [[patterns/microservice]] — seção Resiliência
- Testes de integração com mock do gateway

### TASK-005 — Publicação de eventos

- Implementar `EventPublisher` na camada `infrastructure/`
- Publicar `PAYMENT_APPROVED` e `PAYMENT_FAILED` conforme contratos em [[contracts.md]]
- Garantir que falha na publicação vai para dead letter queue conforme [[plan.md]]

### TASK-006 — Controllers e rotas

- Implementar controllers conforme [[patterns/rest-api]]
- Rotas: POST `/api/v1/payments`, GET `/api/v1/payments/:id`, GET `/api/v1/payments`
- Validação de body e query params antes de chamar use cases
- Health check: GET `/health`

### TASK-007 — Validação dos critérios de aceite

- Rodar checklist completo de [[acceptance.md]]
