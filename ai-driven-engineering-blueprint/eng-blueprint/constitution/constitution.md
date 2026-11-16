# Constitution — Índice

> Regras universais: valem para qualquer projeto, independente de arquitetura ou tecnologia.
> Nenhuma regra aqui pode ser sobrescrita por playbooks ou SDDs. Em conflito, a constitution vence.
> Decisões e justificativas **de um projeto** não ficam aqui: vão na seção Decisões do `plan.md` do SDD.

---

## Seções

| Seção | Conteúdo |
|---|---|
| [[stack]] | Linguagem, runtime, cloud e controle de versão aprovados |
| [[security]] | Segredos, comunicação, dados sensíveis, dependências |
| [[quality]] | Linting, cobertura, padrões de código, README mínimo |
| [[observability]] | Logs estruturados, traces, métricas, health check |
| [[testing]] | Pirâmide de testes, estratégia de mock, cobertura por camada |

---

## Como referenciar nos documentos filhos

Referencie a seção específica, não o índice inteiro: `[[security]]` para segredos e dados sensíveis, `[[observability]]` para logs, traces e métricas, `[[testing]]` para estratégia de testes, `[[quality]]` para lint e padrões de código, `[[stack]]` para linguagem e cloud.
