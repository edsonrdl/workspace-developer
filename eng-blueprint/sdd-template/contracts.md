# contracts.md — [Nome do Projeto ou Feature]

<!--
Este arquivo define O QUE o sistema vai produzir — não como vai produzir.
É o contrato com o mundo externo: outros times, outros serviços, o frontend.

Regra: se um dev de outro time precisar integrar com este projeto,
este arquivo deve ser suficiente — sem precisar ler o código.
-->

---

## Referências

<!--
Declare apenas o que este arquivo estende ou referencia.
Não repita regras que já estão nos patterns — apenas as específicas desta feature.
-->

- [[rest-api]]      — envelope `{ data, meta }`, autenticação, paginação, códigos HTTP
- [[requirements]]  — requisitos que estes contratos atendem

---

## Endpoints HTTP

<!--
Para cada endpoint:
1. Método + path
2. Headers obrigatórios específicos (Authorization vem do [[rest-api]] — não repetir)
3. Body de request (com tipos)
4. Response de sucesso (código + estrutura)
5. Responses de erro específicos deste endpoint

Use blocos TypeScript para tipagem — é o que o agente vai implementar.
O envelope { data, meta } e Authorization vêm do [[rest-api]] — não repita aqui.
-->

### [MÉTODO] /api/v1/[recurso]

**Body de request:**
```typescript
{
  campo1: tipo   // descrição e restrições
  campo2: tipo   // ex: uuid, integer em centavos, enum
}
```

**Headers específicos deste endpoint:**
```
[Header-Name]: [tipo]   // descrição — ex: Idempotency-Key: uuid (obrigatório)
```

**Retorno de sucesso:** status [201|200], `data` com [descreva o objeto retornado].

**Erros específicos deste endpoint:**

| Status | Código | Quando ocorre |
|---|---|---|
| 400 | `[SNAKE_CASE_CODE]` | [condição] |
| 404 | `[SNAKE_CASE_CODE]` | [condição] |
| 409 | `[SNAKE_CASE_CODE]` | [condição] |

---

### [MÉTODO] /api/v1/[recurso]/{id}

<!--
Repita o bloco acima para cada endpoint.
Remova os que não se aplicam.
-->

---

## Modelo de dados

<!--
Defina a estrutura de dados que será persistida.
- Nomes de campo em camelCase (TypeScript) ou snake_case (banco) — seja consistente
- Tipos explícitos para cada campo
- Restrições importantes: unique, indexed, not null, default
- O que NUNCA deve ser armazenado (ex: dados de cartão, senhas em plain text)
-->

```typescript
// Tabela/coleção: [nome_da_tabela]
{
  id: uuid                  // PK, gerado automaticamente
  [campo]: [tipo]           // descrição + restrições
  [campo]: enum             // [VALOR_A | VALOR_B | VALOR_C]
  [campo]: integer          // ex: em centavos — nunca float para dinheiro
  [campoSensivel]: string   // NUNCA armazenar [dado sensível] — apenas [token/hash]
  createdAt: timestamp
  updatedAt: timestamp
}
```

**Índices:**
- `[campo]` — indexed por [motivo: query frequente, join, etc.]
- `[campo]` — unique constraint por [motivo]

---

## Eventos emitidos

<!--
Se o sistema publica eventos em fila/tópico, defina o contrato completo aqui.
Siga o formato do [[microservice]] (ou o pattern de eventos do seu vault).

Para cada evento:
- Nome em SNAKE_CASE maiúsculo
- Versão (para controle de breaking changes)
- Payload específico (campos que variam por evento)
- O que NUNCA deve aparecer no payload (dados sensíveis)
-->

```typescript
// [NOME_DO_EVENTO]
{
  eventId: uuid
  eventType: "[NOME_DO_EVENTO]"
  version: 1
  occurredAt: ISO8601
  payload: {
    [campo]: tipo   // descrição
    // NUNCA incluir: [dados sensíveis — ex: número de cartão, senha, CPF]
  }
}
```

<!--
Repita o bloco para cada evento.
Se não há eventos, remova esta seção.
-->

---

## Eventos consumidos

<!--
Se o sistema escuta eventos de outras fontes, defina o contrato esperado aqui.
Isso documenta a dependência e serve como contrato com o time que publica.

Se não consome eventos, remova esta seção.
-->

```typescript
// Origem: [nome-do-serviço]
// Evento: [NOME_DO_EVENTO]
{
  // campos relevantes que este serviço vai usar
}
```

---

## Integrações externas

<!--
APIs de terceiros ou serviços internos que este projeto chama diretamente.
Para cada um:
- Nome e propósito
- Método de autenticação
- Timeout e política de retry (se diferente do [[microservice]])
- O que fazer em caso de falha

Se não há integrações externas, remova esta seção.
-->

### [Nome da integração]

- **Propósito:** [o que faz]
- **Configuração:** variável de ambiente `[NOME_DA_VAR]` — nunca hardcoded
- **Timeout:** [Xs] — retry com backoff exponencial ([n] tentativas)
- **Falha:** [como tratar — ex: emitir evento de falha, retornar erro ao cliente]
