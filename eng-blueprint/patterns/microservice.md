# Pattern: Microservice

> Políticas específicas para arquitetura de microserviços. Em um SDD completo seria dividido em: `boundaries.md`, `communication.md`, `deployment.md`, `resilience.md` Consolidado aqui por ser ambiente de teste.
> 
> Estende: [[constitution]]

---

## Princípio fundamental

Um microserviço tem **uma única responsabilidade de negócio**. Se o nome do serviço precisar de "e" para ser descrito, ele deve ser dividido.

✅ `payment-service` — processa pagamentos ❌ `payment-and-notification-service` — duas responsabilidades

---

## Estrutura de pastas obrigatória

```
service-name/
├── src/
│   ├── application/       ← casos de uso, orquestração
│   ├── domain/            ← entidades, regras de negócio puras
│   ├── infrastructure/    ← banco, filas, HTTP clients externos
│   └── interface/         ← controllers, handlers de evento
├── tests/
│   ├── unit/
│   └── integration/
├── docs/
│   └── adr/
├── terraform/             ← infraestrutura do serviço
└── README.md
```

---

## Banco de dados

- Cada serviço tem seu **próprio banco** — sem compartilhamento
- Nenhum serviço acessa diretamente o banco de outro
- Se precisar de dado de outro serviço: API call ou evento
- Migrações versionadas e automatizadas no pipeline

---

## Comunicação entre serviços

**Síncrona (HTTP):** apenas para queries que precisam de resposta imediata

**Assíncrona (eventos):** para comandos, notificações e integrações

```typescript
// Contrato de evento obrigatório
{
  eventId: string,       // uuid
  eventType: string,     // SNAKE_CASE: PAYMENT_APPROVED
  occurredAt: string,    // ISO8601
  version: number,       // versão do schema do evento
  payload: object
}
```

Nunca chamar outro serviço dentro de uma transação de banco.

---

## Resiliência

- Timeout configurado em toda chamada HTTP externa: máximo 5s
- Retry com backoff exponencial: 3 tentativas
- Circuit breaker ativo para dependências críticas
- Health check endpoint obrigatório: `GET /health`

```typescript
// Resposta do health check
{
  status: "healthy" | "degraded" | "unhealthy",
  dependencies: {
    database: "healthy" | "unhealthy",
    queue: "healthy" | "unhealthy"
  }
}
```

---

## Deploy

- Cada serviço tem seu próprio pipeline de CI/CD
- Deploy independente — sem coordenação com outros serviços
- Blue/green ou canary para produção
- Rollback automatizado se health check falhar após deploy

---

## Políticas de versionamento de API

- Breaking changes exigem nova versão: `/v2/...`
- Versão antiga mantida por mínimo 3 meses após lançamento da nova
- Deprecation comunicada via header: `Deprecation: true`