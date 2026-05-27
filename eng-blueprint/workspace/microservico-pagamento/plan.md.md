# plan.md — Microserviço de Pagamentos

---

## Referências

<!-- LINK AQUI: toda a decisão de como estruturar o serviço, como comunicar com outros serviços, resiliência e deploy já estão no pattern de microserviço. Este arquivo só declara as decisões ESPECÍFICAS deste serviço que não estão cobertas pelos patterns. -->

- [[patterns/microservice]] — estrutura de pastas, comunicação, resiliência, deploy
- [[requirements.md]] — o que precisa ser implementado
- [[contracts.md]] — o que precisa ser construído

---

## Decisões técnicas específicas deste serviço

<!-- Tudo que já está em [[patterns/microservice]] não precisa ser repetido. Aqui ficam apenas as decisões únicas deste serviço. -->

**Gateway de pagamento** Integração via HTTP client com timeout e retry conforme [[patterns/microservice]] — seção Resiliência. Gateway configurado por variável de ambiente `PAYMENT_GATEWAY_URL`. Credenciais via AWS Parameter Store — nunca hardcoded.

**Idempotência** Implementada na camada de application antes de qualquer chamada ao gateway. Chave armazenada na tabela `payments_transactions.idempotencyKey` com constraint unique. Se a chave já existe: retorna o registro existente sem reprocessar.

**Ordem das operações no fluxo de criação**

1. Validar body e método de pagamento
2. Verificar idempotencyKey — se existe, retornar resultado
3. Persistir com status `PENDING`
4. Chamar gateway com retry
5. Atualizar status conforme resposta
6. Emitir evento de resultado

O evento é sempre emitido após a atualização do banco — nunca antes.

**Banco de dados** PostgreSQL via AWS RDS. ORM: Prisma. Variável de ambiente: `DATABASE_URL` (Parameter Store). *(Quando este padrão se repetir em outro serviço, promover para `patterns/database.md` via ADR.)*

**Fila de eventos** AWS SQS. Publicação via AWS SDK. Nome da fila via `PAYMENT_EVENTS_QUEUE_URL` (Parameter Store). Dead Letter Queue configurada no Terraform do serviço — falha na publicação não reverte o pagamento. *(Quando este padrão se repetir, promover para `patterns/events.md` via ADR.)*

**Incremento de `attempts`** Incrementado na camada `application` após cada chamada ao gateway, independente do resultado (sucesso ou falha). Persiste junto com a atualização de status na mesma operação de escrita. Exemplo: gateway responde com aprovação na primeira tentativa → `attempts: 1`. Gateway falha três vezes → `attempts: 3`.