# Observability — Logs, traces e métricas

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.
> O *como implementar* (qual biblioteca, qual formato específico por arquitetura) fica nos `engineering-playbooks/`.
> O *o que é obrigatório em todo projeto* está aqui.

---

## Princípio fundamental

Todo sistema em produção deve ser **observável** — ou seja, deve ser possível entender seu estado interno apenas a partir de seus outputs externos (logs, traces, métricas), sem precisar acessar o processo diretamente.

---

## Logs

**O que é obrigatório em todo log de request:**

```typescript
{
  timestamp: ISO8601,     // sempre presente
  level: string,          // info | warn | error
  requestId: string,      // uuid gerado por request — correlaciona logs da mesma requisição
  service: string,        // nome do serviço que gerou o log
  message: string         // mensagem legível, sem dados sensíveis
}
```

**Regras universais:**
- Logger estruturado obrigatório — `console.log` proibido em produção (ver [[quality]])
- Dados sensíveis nunca em logs — ver lista completa em [[security]]
- `requestId` obrigatório em todo log gerado durante o processamento de uma requisição
- Logs de erro incluem `stack` quando disponível — nunca o payload da requisição
- Nível `error` apenas para falhas que exigem atenção humana — não para erros esperados de negócio

**O que vai no `sdd/plan.md` do projeto:**
- Qual biblioteca de logging (Winston, Pino, etc.)
- Campos adicionais específicos do domínio
- Destino dos logs (CloudWatch, S3, etc.)

---

## Traces

**O que é obrigatório:**
- Toda requisição recebida gera um `traceId` único
- `traceId` propagado para todas as chamadas externas feitas durante a requisição
- Chamadas a bancos de dados, filas e APIs externas geram spans filhos do trace raiz
- `traceId` retornado no header de resposta para correlação pelo cliente

**O que vai no `sdd/plan.md` do projeto:**
- Biblioteca de tracing (OpenTelemetry, AWS X-Ray, etc.)
- Nome do header de propagação
- Quais spans criar além dos automáticos

---

## Métricas

**O que é obrigatório em todo serviço:**

| Métrica | Descrição |
|---|---|
| Taxa de requests | Requests por segundo, separados por endpoint e status |
| Taxa de erros | % de respostas 4xx e 5xx por endpoint |
| Latência | p50, p95, p99 por endpoint |
| Saúde das dependências | Status de banco, fila e serviços externos |

**O que vai no `sdd/requirements.md` do projeto:**
- SLOs específicos (ex: "p99 < 500ms neste endpoint")
- Métricas de negócio específicas (ex: "pagamentos processados por minuto")

---

## Health check

Todo serviço expõe `GET /health`. Formato mínimo obrigatório:

```typescript
{
  status: "healthy" | "degraded" | "unhealthy",
  dependencies: {
    [nome]: "healthy" | "unhealthy"
  }
}
```

- `healthy` — tudo operacional
- `degraded` — serviço funcionando mas com dependência não crítica com problema
- `unhealthy` — serviço incapaz de processar requisições

Detalhamento do formato por arquitetura está em `engineering-playbooks/microservice.md`.
