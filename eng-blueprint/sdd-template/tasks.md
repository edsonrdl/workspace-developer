# tasks.md — [Nome do Projeto ou Feature]

---

## Referências

- [[plan]]       — decisões técnicas que guiam cada tarefa
- [[contracts]]  — o que cada tarefa deve produzir
- [[acceptance]] — como validar que cada tarefa está correta

---

## Instruções ao agente

<!--
NÃO REMOVA ESTE BLOCO — ele é lido pelo agente antes de qualquer ação.
-->

```
INSTRUÇÃO AO AGENTE:
1. Leia esta lista antes de qualquer ação.
2. A primeira tarefa com [ ] é o ponto de retomada — comece por ela.
3. Tarefas com [x] já foram implementadas e testadas — não refazer.
4. Ao concluir cada tarefa com testes passando:
   - Marque [x] nesta lista
   - Salve este arquivo
   - Só então avance para a próxima
5. O código vai para a raiz do projeto (ao lado da pasta sdd/).
6. Cada tarefa é atômica — não avance sem testes passando.
```

---

## Estado da implementação

- [ ] TASK-001 — [Nome da primeira tarefa]
- [ ] TASK-002 — [Nome da segunda tarefa]
- [ ] TASK-003 — [Nome da terceira tarefa]
- [ ] TASK-004 — [Nome da quarta tarefa]
- [ ] TASK-005 — [Nome da quinta tarefa]
- [ ] TASK-006 — Validação dos critérios de aceite

<!--
Adapte o número de tasks conforme a complexidade do projeto.
A última task é SEMPRE a validação dos critérios de aceite de [[acceptance]].

Princípio INVEST para cada task:
  I — Independent:  pode ser implementada sem depender de outra [ ]
  N — Negotiable:   o como pode variar, o resultado não
  V — Valuable:     entrega algo testável e verificável
  E — Estimable:    o esforço é previsível
  S — Small:        cabe em uma sessão de trabalho
  T — Testable:     tem critério claro de "pronto"

Se uma task quebra o INVEST, divida-a.
-->

---

## Detalhamento das tasks

<!--
Para cada task:
1. Liste o que deve ser criado/implementado
2. Referencie os contratos ou decisões aplicáveis com [[links]]
3. Mencione o critério de "pronto" (quando marcar [x])

O critério de "pronto" deve ser objetivo:
  ✅ "Testes unitários passando com cobertura ≥ 80% desta camada"
  ✅ "`npm run lint` sem erros"
  ✅ "Endpoint responde 201 com o contrato de [[contracts]]"
  ❌ "Implementação completa" ← muito vago
-->

### TASK-001 — [Nome — ex: Estrutura do projeto]

<!--
Primeira task: sempre estrutura + configuração de tooling.
Isso garante que o agente tem um ambiente validado antes de implementar lógica.
-->

- Criar estrutura de pastas conforme [[microservice]] (ou pattern aplicável) na raiz do projeto
- Configurar TypeScript, ESLint, Jest com thresholds de cobertura
- Configurar validação de variáveis de ambiente no boot conforme [[plan]]

**Pronto quando:** `npm run lint` e `npm test` executam sem erros (mesmo sem testes de negócio ainda).

---

### TASK-002 — [Nome — ex: Modelo de dados]

<!--
Segunda task: domínio e persistência.
Separar domínio de persistência evita que mudanças de banco afetem a lógica de negócio.
-->

- Criar tipos de domínio em `src/domain/` conforme modelo em [[contracts]]
- Criar interface `[Entidade]Repository` com os métodos necessários
- Implementar `Prisma[Entidade]Repository` com os métodos: `save`, `findById`, [outros]
- Criar schema Prisma e migration inicial

**Pronto quando:** testes unitários do repository com mock de banco passando.

---

### TASK-003 — [Nome — ex: Caso de uso principal]

<!--
Terceira task: lógica de negócio pura, sem HTTP e sem banco real.
Use cases testados com mocks — isso garante 80% de cobertura com testes rápidos.
-->

- Implementar `[NomeUseCase]` na camada `application/`
- Incluir [lógica específica conforme [[plan]] — ex: verificação de idempotência]
- Seguir ordem de operações definida em [[plan]] — seção "Fluxo principal"
- Testes unitários cobrindo: fluxo feliz + todos os casos de borda de [[acceptance]]

**Pronto quando:** testes unitários passando, todos os ACs do fluxo principal cobertos.

---

### TASK-004 — [Nome — ex: Integração externa]

<!--
Quarta task: integrações com sistemas externos (gateway, API terceira, etc.)
Implementar na camada infrastructure/ com mocks para testes.
-->

- Implementar `[NomeClient]` em `src/infrastructure/[nome]/`
- Timeout de [Xs] e retry com backoff exponencial conforme [[microservice]]
- Configuração via variável de ambiente `[NOME_DA_VAR]` — nunca hardcoded
- Testes de integração com mock do serviço externo

**Pronto quando:** testes de integração com mock passando para fluxo feliz e timeout.

---

### TASK-005 — [Nome — ex: Controllers e rotas / ou Publicação de eventos]

<!--
Quinta task: camada de interface (HTTP controllers) ou outputs (eventos, CLI).
Esta task conecta tudo — use cases + integrações + contratos HTTP.
-->

- Implementar controllers conforme [[rest-api]] e [[contracts]]
- [Rotas específicas desta feature]
- Validação de input antes de chamar use cases
- Health check: `GET /health` com status de dependências

**Pronto quando:** testes de integração de ponta a ponta passando com os contratos de [[contracts]].

---

### TASK-006 — Validação dos critérios de aceite

<!--
Última task: sempre validação.
Não é "rodar os testes" — é verificar cada item do checklist de [[acceptance]].
-->

- Rodar checklist completo de [[acceptance]]
- Verificar cobertura: `npm run test:coverage` ≥ 80%
- Verificar lint: `npm run lint` sem erros
- Validar manualmente os casos de borda listados em [[acceptance]]
- Confirmar que nenhum dado sensível aparece em logs

**Pronto quando:** todos os itens do checklist de [[acceptance]] marcados `[x]`.
