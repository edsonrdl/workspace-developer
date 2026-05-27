# plan.md — Microserviço de Pagamentos

---

## Referências

<!-- LINK AQUI: toda a decisão de como estruturar o serviço, como comunicar com outros serviços, resiliência e deploy já estão no pattern de microserviço. Este arquivo só declara as decisões ESPECÍFICAS deste serviço que não estão cobertas pelos patterns. -->

- [[patterns/microservice]] — estrutura de pastas, comunicação, resiliência, deploy
- [[patterns/rest-api]] — como construir os endpoints
- [[spec.md]] — o problema que este plano resolve
- [[requirements]] — o que precisa ser implementado
- [[contracts]] — o que precisa ser construído

---

## Decisões técnicas específicas deste serviço

<!-- Tudo que já está em [[patterns/microservice]] não precisa ser repetido. Aqui ficam apenas as decisões únicas deste serviço. -->

**Gateway de pagamento** Integração via HTTP client com timeout e retry conforme NFR-003. Gateway configurado por variável de ambiente `PAYMENT_GATEWAY_URL`. Credenciais via AWS Parameter Store — nunca hardcoded.

**Idempotência** Implementada na camada de application antes de qualquer chamada ao gateway. Chave armazenada na tabela `payments_transactions.idempotencyKey` com constraint unique. Se a chave já existe: retorna o registro existente sem reprocessar.

**Ordem das operações no fluxo de criação**

1. Validar body e método de pagamento
2. Verificar idempotencyKey — se existe, retornar resultado
3. Persistir com status `PENDING`
4. Chamar gateway com retry
5. Atualizar status conforme resposta
6. Emitir evento de resultado

O evento é sempre emitido após a atualização do banco — nunca antes.

**Fila de eventos** Publicação assíncrona após confirmação de escrita no banco. Falha na publicação do evento não reverte o pagamento — registrar em dead letter queue.