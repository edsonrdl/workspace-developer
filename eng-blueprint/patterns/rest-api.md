# Pattern: REST API

> Padrão compartilhado por todas as arquiteturas deste vault. Em um SDD completo este arquivo seria dividido em: `http.md`, `contracts.md`, `errors.md`, `auth.md`, `versioning.md` Aqui estão consolidados por ser um ambiente de teste.

---

## Estrutura de URL

```
/api/v{n}/{recurso}
/api/v{n}/{recurso}/{id}
/api/v{n}/{recurso}/{id}/{sub-recurso}
```

- Sempre com prefixo `/api`
- Versão obrigatória: `/v1`, `/v2`
- Recursos no plural e em kebab-case: `/payment-methods`, `/user-accounts`
- Sem verbos na URL — o método HTTP define a ação

---

## Métodos HTTP

|Método|Uso|Idempotente|
|---|---|---|
|GET|Leitura|Sim|
|POST|Criação|Não|
|PUT|Substituição total|Sim|
|PATCH|Atualização parcial|Não|
|DELETE|Remoção|Sim|

---

## Contrato de resposta

Toda resposta segue este envelope:

```typescript
// Sucesso
{
  "data": T,
  "meta": {
    "timestamp": "ISO8601",
    "requestId": "uuid"
  }
}

// Erro
{
  "error": {
    "code": "SNAKE_CASE_CODE",
    "message": "Mensagem legível para humano",
    "details": [] // opcional
  },
  "meta": {
    "timestamp": "ISO8601",
    "requestId": "uuid"
  }
}
```

---

## Códigos HTTP obrigatórios

|Situação|Código|
|---|---|
|Criação bem-sucedida|201|
|Leitura / atualização|200|
|Sem conteúdo|204|
|Requisição inválida|400|
|Não autenticado|401|
|Sem permissão|403|
|Não encontrado|404|
|Conflito de estado|409|
|Erro interno|500|

---

## Autenticação

- JWT via header `Authorization: Bearer {token}`
- Token validado em cada request — sem estado no servidor
- Expiração máxima do token: 1 hora
- Refresh token com expiração de 7 dias

---

## Paginação

```typescript
// Query params
GET /api/v1/items?page=1&limit=20&sort=createdAt&order=desc

// Resposta com meta extendido
{
  "data": [],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 100,
    "totalPages": 5
  }
}
```

---

## Validação de entrada

- Toda entrada validada antes de qualquer lógica de negócio
- Erros de validação retornam 400 com array `details` listando cada campo inválido
- Campos desconhecidos no body são ignorados, nunca lançam erro

---

## Logs obrigatórios por request

```typescript
{
  requestId: string,
  method: string,
  path: string,
  statusCode: number,
  durationMs: number,
  userId?: string     // quando autenticado
}
```

Nenhum campo de payload no log — apenas metadados de request.