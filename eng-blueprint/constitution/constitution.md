# Constitution — Índice

> Documento raiz do vault `eng-blueprint`.
> Contém apenas o que é universal — regras que se aplicam a qualquer projeto, independente de arquitetura ou tecnologia.
> **Nenhuma regra aqui pode ser sobrescrita por documentos filhos.**
> Em caso de conflito entre este arquivo e um pattern ou workspace, este prevalece.

---

## Autoridade deste documento

Este índice e todos os arquivos desta pasta têm prioridade máxima no vault. Cada seção é um documento independente que pode evoluir via ADR formal — mas nunca pode ser contraditado por patterns ou specs de projetos.

---

## Seções

| Seção | Conteúdo |
|---|---|
| [[stack]] | Linguagem, runtime, cloud e controle de versão aprovados |
| [[security]] | Segredos, comunicação, dados sensíveis, dependências |
| [[quality]] | Linting, cobertura, padrões de código |
| [[observability]] | Logs estruturados, traces, métricas, health check |
| [[testing]] | Pirâmide de testes, estratégia de mock, cobertura por camada |
| [[documentation]] | Documentação obrigatória por repositório |
| [[governance]] | Processo de aprovação de novos padrões e ADRs |

---

## Como referenciar nos documentos filhos

Referencie a seção específica — não o índice inteiro:

```
[[security]]      — quando a regra é sobre segredos ou dados sensíveis
[[observability]] — quando a regra é sobre logs, traces ou métricas
[[testing]]       — quando a regra é sobre cobertura ou estratégia de testes
[[quality]]       — quando a regra é sobre linting ou padrões de código
[[stack]]         — quando a regra é sobre linguagem ou provedor de cloud
```

Use `[[constitution]]` apenas quando quiser referenciar a autoridade geral — não uma seção específica.

---

## Controle de versão

| Versão | Data | Mudança |
|---|---|---|
| 1.0 | 2025-05 | Versão inicial — documento único |
| 2.0 | 2026-06 | Quebrado em seções independentes linkadas |
