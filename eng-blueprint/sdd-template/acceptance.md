# acceptance.md — [Nome do Projeto ou Feature]

<!--
Este arquivo responde: "Como sabemos que está pronto?"

Não descreve implementação — descreve comportamento observável.
Cada critério deve ser verificável por um teste automatizado ou por inspeção manual clara.

Formato recomendado: Gherkin (Given/When/Then)
  - Given: estado inicial do sistema
  - When:  ação que dispara o comportamento
  - Then:  resultado observável esperado

Por que Gherkin?
  - É o formato que mais facilmente vira teste automatizado
  - Elimina ambiguidade ("a feature está pronta" tem um critério claro)
  - O agente consegue escrever testes unitários diretamente a partir daqui
-->

---

## Referências

- [[requirements]] — requisitos que estes critérios validam (cada critério deve referenciar um FR-xxx ou NFR-xxx)
- [[contracts]]    — contratos que os testes devem verificar

---

## Critérios de aceite

<!--
Regras universais (cobertura ≥ 80%, GET /health, logs sem dados sensíveis)
estão em [[constitution]] e nos patterns — não repita aqui.

Para cada critério:
1. Escreva em formato Gherkin ou como checklist verificável
2. Referencie o requisito que valida: (FR-001), (NFR-003), etc.
3. Um critério por comportamento — não agrupe
-->

**AC-001** — [Breve descrição do comportamento] (FR-xxx)
```gherkin
Given [estado inicial]
When  [ação executada]
Then  [resultado esperado]
```

**AC-002** — [Breve descrição do comportamento] (FR-xxx)
```gherkin
Given [estado inicial]
When  [ação executada]
Then  [resultado esperado]
And   [resultado adicional, se houver]
```

**AC-003** — [Critério de aceite sem formato Gherkin — aceitável para validações simples] (NFR-xxx)
- [ ] [descrição verificável]

<!-- Adicione quantos forem necessários. Um por comportamento. -->

---

## Casos de borda

<!--
Liste os casos que NÃO são o fluxo feliz mas que PRECISAM funcionar corretamente.
Para cada caso: a situação e o comportamento esperado.

Casos de borda típicos:
- Input inválido ou fora dos limites
- Falha de serviço externo (timeout, erro 5xx)
- Condições de corrida (duas requisições simultâneas)
- Estado inconsistente (dado parcialmente criado)
- Idempotência (mesma requisição enviada duas vezes)
- Limites de paginação (página 0, página além do total)
-->

| Caso de borda | Comportamento esperado | Código de erro |
|---|---|---|
| [situação anormal 1] | [o que deve acontecer] | [ex: 400 — INVALID_INPUT] |
| [situação anormal 2] | [o que deve acontecer] | [ex: 409 — CONFLICT] |
| [timeout do serviço externo] | [retry + comportamento após esgotar tentativas] | [ex: 503 — SERVICE_UNAVAILABLE] |
| [dado duplicado / idempotência] | [retorna existente sem reprocessar] | [ex: 200 com resultado original] |

---

## Checklist de validação final

<!--
Lista de verificação que o agente deve completar na TASK de validação (última task).
Itens universais já estão nos patterns — liste apenas os específicos desta feature.
-->

- [ ] [Critério de aceite AC-001 passa em teste automatizado]
- [ ] [Critério de aceite AC-002 passa em teste automatizado]
- [ ] [Caso de borda X tratado com o erro correto]
- [ ] [Nenhum dado sensível aparece em logs — validado manualmente]
- [ ] [Cobertura de testes ≥ 80% — validado via `npm run test:coverage`]

---

## Suposições

<!--
O que você está assumindo como verdadeiro que NÃO está no controle desta implementação?
Suposições mal documentadas são a principal causa de retrabalho.

Exemplos:
- "O serviço X garante que o orderId existe antes de chamar este serviço."
- "O frontend tokeniza o dado sensível antes de enviar — este serviço nunca recebe o dado bruto."
- "A fila já está provisionada — este serviço apenas publica."
-->

- [suposição 1 — algo que deve ser verdadeiro mas não é responsabilidade desta implementação]
- [suposição 2]
