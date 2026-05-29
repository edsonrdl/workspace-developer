# eng-blueprint

> **Engenharia de Software com Governança de IA Aplicada**
> Velocidade da IA + rigor de engenharia = outputs auditáveis, versionados e aprovados por humano.

> 📊 **Visualização rápida:** abra este vault no Obsidian e clique em `vibe-code-vs-sdd-governance.canvas` para ver o diagrama completo do problema (Vibe Code) vs solução (eng-blueprint) com os Phase Gates de governança. Se preferir apenas o grafo de dependências dos documentos, abra `vault-reading-graph.canvas`.

---

## O problema que este projeto resolve

### Vibe Code — o risco invisível

Com a ascensão de agentes de IA gerando código, surgiu um padrão silencioso de trabalho chamado **Vibe Code**: desenvolvimento guiado pela *sensação* de que está funcionando. A IA gera, o desenvolvedor aceita. Rápido no início — caro na escala.

| Sintoma | Consequência |
|---|---|
| IA decide arquitetura sozinha | Sem trilha de decisão auditável |
| Requisitos desacoplados do código | Ninguém sabe qual versão está vigente |
| Sem critério de aceite formal | Outputs frágeis produzidos mais rápido |
| Débito técnico mascarado de agilidade | Auditoria regulatória inviável |

**O problema central não é a IA em si — é a ausência de um contrato entre o que foi decidido e o que foi construído.**

---

### A solução: Especificação como código, governança como infraestrutura

O `eng-blueprint` é um **vault de engenharia** que funciona como a camada de governança do desenvolvimento orientado a IA. Ele responde à pergunta:

> *"Como garantir que o que a IA constrói reflete o que foi decidido pela engenharia, documentado formalmente e aprovado por um humano?"*

A resposta: **as specs vivem no repositório junto com o código**. A IA lê a spec antes de agir. A spec é a lei.

---

## Como este sistema funciona

### A arquitetura em três camadas

```
eng-blueprint/                    ← VAULT (versionado, este repositório)
├── constitution.md               ← Regras universais inegociáveis
├── patterns/                     ← Padrões arquiteturais reutilizáveis
│   ├── microservice.md
│   ├── rest-api.md
│   ├── modular-monolith.md
│   └── mvc.md
└── workspace/                    ← Projetos reais (NÃO versionados aqui)
    └── nome-do-projeto/          ← raiz do repo clonado e será versionado
        ├── sdd/                  ← specs versionadas JUNTO com o código
        │   ├── spec.md           ← ponto de entrada da IA
        │   ├── requirements.md
        │   ├── contracts.md
        │   ├── acceptance.md
        │   ├── plan.md
        │   └── tasks.md
        ├── src/                  ← código-fonte
        ├── tests/
        ├── package.json
        └── README.md
```

**Camada 1 — Vault (eng-blueprint):** Contém as regras que se aplicam a todos os projetos. A `constitution.md` define o que nunca pode ser violado. Os `patterns/` definem como fazer, não o quê fazer. Este repositório é versionado independentemente.

**Camada 2 — Workspace:** Pasta local onde você clona os repositórios dos projetos. Os projetos *não são versionados aqui* — eles têm seus próprios repositórios Git. O workspace apenas os reúne em um único ponto de leitura para o Obsidian e para os agentes de IA.

**Camada 3 — Spec do projeto (`sdd/`):** Cada repositório clonado dentro de `workspace/` carrega sua pasta `sdd/` com os documentos de especificação. Esses arquivos *são versionados junto com o código no mesmo repositório do projeto*. Isso significa que cada commit de feature carrega a spec que o originou — o code review vira revisão do spec + código + refinamento, tudo junto.

---

### O fluxo de trabalho

```
1. Clone o repositório do projeto dentro de workspace/
   ↓
2. Abra o vault inteiro no Obsidian
   ↓
3. Os links [[constitution]] e [[patterns/microservice]] resolvem automaticamente
   ↓
4. Dê o comando ao agente: "leia spec.md e implemente"
   ↓
5. O agente percorre a cadeia de dependências e implementa com contexto completo
   ↓
6. Revise e aprove (Human In The Loop)
```

**Por que o Obsidian?** Porque ele lê *qualquer arquivo `.md` dentro do vault* — inclusive o README do projeto clonado, as specs, os ADRs. Os links no formato `[[nome-do-arquivo]]` resolvem para qualquer documento no vault, criando um grafo de dependências navegável. Você pode validar visualmente se todos os links estão corretos antes mesmo de rodar o agente.

---

## A cadeia de dependências da spec

Cada projeto dentro de `workspace/` segue uma ordem de leitura obrigatória. Ela não é arbitrária — cada documento tem um papel específico na construção do contexto do agente:

```
spec → requirements → contracts → acceptance → plan → tasks
```

| Documento | Papel | Pergunta respondida |
|---|---|---|
| `spec.md` | Ponto de entrada | *Por que este serviço existe? Qual problema resolve?* |
| `requirements.md` | Requisitos funcionais e NFRs | *O que precisa ser construído?* |
| `contracts.md` | Endpoints, modelos de dados, eventos | *O que o serviço vai produzir?* |
| `acceptance.md` | Critérios de aceite e casos de borda | *Como validar que está correto?* |
| `plan.md` | Decisões técnicas específicas | *Como vai ser construído?* |
| `tasks.md` | Lista de tarefas com estado `[x]`/`[ ]` | *O que já foi feito? Por onde continuar?* |

**O `plan.md` vem penúltimo propositalmente:** ele é o *como* — e o como só faz sentido depois que o agente já sabe o *quê* (`requirements`) e *o que vai produzir* (`contracts`) e *como vai validar* (`acceptance`). Ler o plano antes do contexto leva a implementações tecnicamente corretas, mas com propósito errado.

**O `tasks.md` mantém estado:** o agente marca `[x]` em cada tarefa concluída. Se a sessão for interrompida, na próxima execução o agente encontra a primeira `[ ]` e retoma exatamente de onde parou — sem reprocessar o que já foi feito.

---

## O grafo de dependências (como o Obsidian enxerga)

```
constitution.md
    ↓ (estende)
patterns/microservice.md ──────────────────────────────┐
patterns/rest-api.md ───────────────────────────────┐  │
                                                    ↓  ↓
spec.md ──→ requirements.md ──→ acceptance.md ──→ plan.md
                    ↓                  ↓              ↓
               contracts.md ──────────────────→ tasks.md
```

Cada arquivo declara explicitamente suas dependências em uma seção `## Referências`. Isso significa:
- **Sem ambiguidade:** o agente sabe exatamente quais documentos ler
- **Sem repetição:** cada regra vive em um único lugar e é referenciada onde necessário
- **Sem desatualização:** atualizar a `constitution.md` propaga para todos os projetos automaticamente

---

## Governança de IA — Phase Gates com Supervisão Humana

> 📊 **Visualização:** abra `vibe-code-vs-sdd-governance.canvas` no Obsidian para ver o diagrama completo desta seção — Vibe Code vs Engenharia com Governança, com os Phase Gates e o fluxo de implementação.

São três modelos de **quanto controle humano** existe sobre decisões de um sistema de IA. A escolha do modelo depende do nível de risco da operação — não da preferência pessoal.

---

### HITL — Human In The Loop
**Humano dentro do ciclo, aprovando cada ação.**

O humano revisa e aprova *cada decisão* antes de executar. A IA não age sozinha.

> *Exemplo neste sistema:* IA gera a TASK-001 → desenvolvedor revisa os arquivos criados → aprova e autoriza avançar para TASK-002.

Usado quando o **risco é alto** ou o custo de reverter um erro é grande: migrações de banco de dados, alterações em contratos de API públicos, decisões arquiteturais com impacto em outros times.

```
# Como usar no eng-blueprint:
"Leia sdd/spec.md, implemente apenas TASK-001 e aguarde minha revisão antes de avançar."
```

---

### HOTL — Human On The Loop
**Humano monitorando, podendo intervir.**

A IA age automaticamente, mas um humano observa em tempo real e pode *interromper* se algo sair errado.

> *Exemplo neste sistema:* agente implementa todas as tasks sequencialmente → engenheiro acompanha o output task por task → pode interromper se detectar desvio da spec.

Usado quando **velocidade importa**, mas supervisão ainda é necessária: features novas em sistemas não críticos, refatorações com boa cobertura de testes.

```
# Como usar no eng-blueprint:
"Leia sdd/spec.md e implemente todas as tasks. Vou revisar o resultado."
```

---

### HIC — Human In Command
**Humano no controle estratégico, não operacional.**

A IA opera de forma autônoma no dia a dia. O humano define regras, limites e objetivos — mas não acompanha cada ação.

> *Exemplo neste sistema:* `constitution.md` e `patterns/` são as regras pré-definidas. CI/CD roda o agente automaticamente quando uma nova spec é adicionada. O agente segue as regras sem aprovação por ação.

Usado quando o sistema já é **maduro e confiável**: automações internas, geração de boilerplate, atualizações de dependências dentro das políticas da constitution.

```
# Como usar no eng-blueprint:
Pipeline que executa "leia sdd/spec.md" automaticamente ao detectar tasks.md com [ ].
```

---

### Phase Gates por nível de risco

| Risco | Modelo | Quando usar | O que acontece |
|---|---|---|---|
| 🔴 Alto | HITL | Schema migration, contrato de API público, decisão arquitetural | Aprovação manual obrigatória antes de avançar de fase |
| 🟡 Médio | HOTL | Nova feature, novo endpoint, nova integração | Avanço automático, humano pode vetar em tempo real |
| 🟢 Baixo | HIC | Boilerplate, ajuste de validação, atualização interna | Avanço totalmente automatizado dentro das regras |

---

### Spec-anchored — o que mantém tudo junto

**Spec-anchored** significa que toda decisão da IA é *ancorada* em uma especificação formal antes de executar. Não é uma sugestão — é a condição para o agente agir.

No eng-blueprint isso se manifesta em dois níveis:

**Nível 1 — Constitution como âncora universal:**
A `constitution.md` define restrições que *nenhum agente pode violar*, independente do modelo de supervisão escolhido. Mesmo com HIC (total autonomia), o agente não pode armazenar dados de cartão, usar `console.log` em produção ou adicionar dependências não auditadas.

**Nível 2 — SDD como âncora do projeto:**
A pasta `sdd/` define o contrato específico de cada projeto. O agente lê a cadeia completa (`spec → requirements → contracts → acceptance → plan → tasks`) antes de escrever qualquer linha de código. O que não está na spec, não é implementado.

Isso garante:
- **Trilha de auditoria nativa** — cada arquivo gerado é rastreável contra a spec que o originou
- **Restrições constitucionais aplicadas mesmo em HIC** — autonomia máxima, mas dentro dos limites definidos
- **Sem alucinação arquitetural** — o agente não decide sozinho como estruturar o serviço, qual banco usar, como fazer retry — tudo está na spec

---

## A constitution — regras inegociáveis

O arquivo `constitution.md` é o documento raiz. **Nenhuma regra aqui pode ser sobrescrita por documentos filhos.** Ele define:

- **Stack aprovada:** TypeScript, Node.js LTS, AWS, Terraform/CDK, Git
- **Segurança:** zero segredos no código, AWS Secrets Manager/Parameter Store, HTTPS obrigatório, dados sensíveis nunca em logs
- **Qualidade:** cobertura mínima 80%, ESLint obrigatório, sem `any` explícito sem justificativa, sem `console.log` em produção
- **Documentação:** `README.md`, `CHANGELOG.md` e `docs/adr/` obrigatórios por repositório
- **Evolução:** novos padrões exigem ADR aprovado antes de qualquer implementação

Qualquer tentativa de violar a constitution — seja por um desenvolvedor ou por um agente de IA — é um sinal de alarme imediato.

---

## Como os patterns funcionam

Os `patterns/` são extensões da constitution para contextos específicos. Eles não repetem as regras universais — apenas adicionam o que é único de cada arquitetura.

**`patterns/microservice.md`** define:
- Estrutura de pastas obrigatória (`src/application/`, `src/domain/`, `src/infrastructure/`, `src/interface/`)
- Banco de dados isolado por serviço
- Timeout de 5s em chamadas HTTP externas
- Retry com backoff exponencial (3 tentativas)
- Health check em `GET /health`

**`patterns/rest-api.md`** define:
- Estrutura de URL (`/api/v{n}/{recurso}`)
- Envelope de resposta obrigatório: `{ data, meta }`
- Autenticação via `Authorization: Bearer {token}`
- Paginação via query params (`page`, `limit`, `sort`, `order`)
- Logs por request sem nenhum campo de payload

Quando um novo padrão se repete em dois ou mais projetos, ele é promovido para `patterns/` via ADR formal. Isso transforma aprendizado tácito em conhecimento institucional versionado.

---

## Benefícios para cada papel

### Para gestores e arquitetos

- **Rastreabilidade completa:** cada decisão técnica está documentada em `sdd/plan.md` com o *porquê*, não apenas o *como*
- **Auditoria nativa:** o histórico Git da `sdd/` é o histórico das decisões de negócio — cada PR carrega a spec que originou a mudança
- **Governança sem burocracia:** as regras estão no código, não em documentos Word esquecidos em drives
- **Controle proporcional ao risco:** HITL para decisões críticas, HOTL para features, HIC para automações maduras
- **Onboarding acelerado:** novo membro lê `constitution.md` + `sdd/spec.md` do projeto e tem contexto completo em minutos
- **Redução de custo com IA:** spec bem escrita reduz drasticamente o número de tokens consumidos por feature — veja a seção "Economia de tokens"

### Para desenvolvedores e tech leads

- **O agente nunca chuta:** ele lê a spec completa antes de escrever uma linha de código
- **Sem "qual versão está vigente?":** a `sdd/` vive no mesmo repositório que o código, com o mesmo controle de versão
- **Code review com contexto completo:** o PR inclui `sdd/` + código — o revisor vê o que foi decidido, o que foi construído e como valida, tudo no mesmo diff
- **Retomada automática:** `sdd/tasks.md` com estado `[x]`/`[ ]` permite parar e continuar sessões sem perder contexto
- **Sem reinvenção de padrões:** `patterns/` são a resposta para "como devemos fazer isso aqui?"
- **Documentação que não fica no limbo:** spec e código evoluem juntos no mesmo commit

---

## Economia de tokens — por que spec-driven custa menos

Este é um benefício técnico direto que raramente é discutido: **desenvolvimento spec-driven consome significativamente menos tokens do que Vibe Code**.

### O problema de tokens no Vibe Code

No Vibe Code sem estrutura, cada sessão com o agente começa do zero:

```
Desenvolvedor: "Cria um microserviço de pagamentos"
Agente: "Claro! Qual banco de dados? Qual framework? Como quer tratar erros?
         Precisa de autenticação? Que tipo de eventos? Tem retry?..."
Desenvolvedor: [explica tudo novamente]
Agente: [implementa algo, mas não é bem o que foi pedido]
Desenvolvedor: "Não, quero que seja assim..."
Agente: [reescreve metade do código]
```

Cada rodada de correção consome tokens. Cada pergunta de clarificação consome tokens. Cada sessão nova onde o agente "esqueceu" o contexto consome tokens para reexplicar.

### Como o eng-blueprint reduz tokens

**1. Contexto escrito uma vez, reutilizado para sempre**

A `constitution.md` e os `patterns/` são escritos uma vez e referenciados por todos os projetos. Em vez de explicar "use timeout de 5s, retry com backoff exponencial, health check em /health" em cada sessão, o agente lê `[[microservice]]` e encontra tudo. Uma linha no spec substitui um parágrafo de instrução.

**2. Sem rodadas de clarificação**

O agente não pergunta "qual banco?", "como fazer retry?", "qual formato de resposta?" — tudo está na spec. O `contracts.md` define o modelo de dados exato. O `plan.md` define o banco, o ORM, a fila. O `acceptance.md` define o critério de aceite. **Zero ambiguidade = zero rodadas de clarificação = zero tokens desperdiçados.**

**3. `tasks.md` elimina retrabalho entre sessões**

Sem estado, uma sessão interrompida obriga o agente a "reconhecer" o que já foi feito — lendo arquivos existentes, inferindo o que está completo. Com `tasks.md`, o agente lê a lista, encontra a primeira `[ ]` e começa imediatamente. **Sem re-leitura, sem re-análise, sem tokens para descobrir o que já foi feito.**

**4. Sem repetição nos documentos**

Cada arquivo da `sdd/` declara apenas o que é *único* daquele nível. O `requirements.md` não repete as regras da `constitution.md` — apenas referencia. O `plan.md` não repete o que já está em `patterns/microservice.md` — apenas declara as decisões específicas. **Menos tokens por leitura, mais sinal por token.**

**5. Primeira implementação correta**

O maior gasto de tokens no Vibe Code não é a geração inicial — é a *correção*. Um agente sem spec gera algo plausível mas errado; a correção pode custar 3x mais tokens que a geração original. Com spec completa, a taxa de acerto na primeira implementação é dramaticamente maior.

### Estimativa comparativa

| Cenário | Rodadas típicas | Tokens estimados |
|---|---|---|
| Vibe Code — feature nova | 4–8 rodadas de correção | ~50k–150k tokens |
| eng-blueprint — mesma feature | 1 rodada (ler spec + implementar) | ~15k–40k tokens |
| eng-blueprint — sessão retomada | Começa na primeira `[ ]` | ~5k–15k tokens |

> Os valores são estimativas baseadas em uso típico. O ganho real depende da complexidade da feature e da qualidade da spec.

**O investimento:** escrever a `sdd/` antes de implementar custa tokens. Mas esse custo é pago uma vez e recuperado em cada sessão subsequente — especialmente em projetos com múltiplas features, múltiplos desenvolvedores e múltiplas sessões de refinamento.

---

## Guia de uso rápido

### 1. Clone o vault

```bash
git clone <url-do-eng-blueprint> eng-blueprint
cd eng-blueprint
```

### 2. Abra no Obsidian

Abra o Obsidian → *Abrir pasta como vault* → selecione a pasta `eng-blueprint`. Todos os links `[[constitution]]`, `[[patterns/microservice]]` etc. estarão resolvidos e navegáveis.

### 3. Clone um projeto no workspace

```bash
# Dentro da pasta eng-blueprint
cd workspace
git clone <url-do-projeto> nome-do-projeto
```

O Obsidian detecta automaticamente os novos arquivos `.md`. Os links da spec do projeto resolvem para os patterns e constitution do vault.

### 4. Crie a spec do projeto (se ainda não existir)

Cada projeto precisa de uma pasta `sdd/` na raiz do repositório com os seguintes arquivos:

```
nome-do-projeto/
├── sdd/
│   ├── spec.md           ← comece aqui: problema, escopo, consumidores, ordem de leitura
│   ├── requirements.md   ← requisitos funcionais (FR-xxx) e não funcionais (NFR-xxx)
│   ├── contracts.md      ← endpoints, modelo de dados, eventos
│   ├── acceptance.md     ← critérios de aceite e casos de borda
│   ├── plan.md           ← decisões técnicas específicas deste projeto
│   └── tasks.md          ← lista de tarefas com estado [ ] / [x]
├── src/
└── ...
```

A pasta `sdd/` é versionada no repositório do projeto. Quando você abre um PR, o diff inclui a spec que motivou a mudança — o revisor vê decisão + código + critério de aceite no mesmo lugar.

> **Dica:** valide os links no Obsidian antes de rodar o agente. Clique em `[[constitution]]` dentro do `spec.md` — se abrir o documento correto, todos os links estão resolvidos.

### 5. Instrua o agente

O comando mais simples:

```
Siga as especificações que estão em sdd/spec.md
```

O agente vai:
1. Ler a ordem de leitura definida em `spec.md`
2. Percorrer toda a cadeia de documentos
3. Encontrar a primeira tarefa `[ ]` em `tasks.md`
4. Implementar, testar, marcar `[x]` e avançar

### 6. Verifique o que foi construído

```bash
cd workspace/nome-do-projeto/nome-do-servico
npm test           # testes passando
npm run lint       # sem violações de ESLint
npm run test:coverage  # cobertura ≥ 80%
```

---

## Estrutura completa do vault

```
eng-blueprint/
├── README.md                          ← este arquivo
├── constitution.md/
│   └── constitution.md               ← regras universais inegociáveis
├── patterns/
│   ├── microservice.md               ← estrutura, comunicação, resiliência, deploy
│   ├── rest-api.md                   ← contratos HTTP, envelope, autenticação, paginação
│   ├── modular-monolith.md           ← padrão de monólito modular
│   └── mvc.md                        ← padrão MVC
├── workspace/                        ← projetos clonados (não versionados aqui)
│   └── microservico-pagamento/       ← exemplo incluso (projeto completo)
│       ├── sdd/                      ← specs versionadas junto com o código
│       │   ├── spec.md
│       │   ├── requirements.md
│       │   ├── contracts.md
│       │   ├── acceptance.md
│       │   ├── plan.md
│       │   └── tasks.md
│       ├── src/                      ← código gerado pelo agente
│       ├── tests/
│       └── package.json
├── Fluxo.md                          ← explicação da ordem de leitura
├── vibe-code-vs-sdd-governance.canvas ← canvas visual do problema vs solução
└── vault-reading-graph.canvas        ← grafo de dependências dos documentos
```

---

## O exemplo incluso: microserviço de pagamentos

O diretório `workspace/microservico-pagamento/` é um exemplo completo e funcional de como o sistema opera. A pasta `sdd/` viaja junto com o código — quando você abre um PR deste projeto, o diff inclui tanto a implementação quanto a especificação que a originou.

- **`sdd/spec.md`** — problema, escopo, consumidores e ordem de leitura obrigatória
- **`sdd/requirements.md`** — requisitos funcionais (FR-001 a FR-008) e não funcionais (NFR-001 a NFR-003)
- **`sdd/contracts.md`** — endpoints REST, modelo de dados PostgreSQL, contratos de eventos SQS
- **`sdd/acceptance.md`** — critérios de aceite e casos de borda (idempotência, timeout, valor inválido)
- **`sdd/plan.md`** — decisões de gateway, banco de dados, fila de eventos e ordem de operações
- **`sdd/tasks.md`** — lista de tarefas com estado `[ ]` — prontas para o agente implementar
- **`src/` + `tests/`** — implementação TypeScript completa com Prisma, Express, Jest

O comando para rodar o agente neste projeto:
```
Siga as especificações que estão em sdd/spec.md
```

---

## Como evoluir os padrões

O sistema tem um mecanismo formal de evolução que evita que os patterns se tornem regras desatualizadas ignoradas por todos:

### Promovendo um padrão novo

Quando uma decisão técnica se repete em dois ou mais projetos, ela deve ser promovida de `plan.md` de um projeto específico para `patterns/`:

1. **Identificar:** a decisão aparece em `plan.md` de dois projetos diferentes
2. **Propor:** escrever um ADR em `docs/adr/` descrevendo o padrão
3. **Revisar:** aprovação do arquiteto responsável
4. **Publicar:** mover a decisão para o arquivo `.md` adequado em `patterns/`
5. **Referenciar:** os projetos que já implementaram atualizam seus `plan.md` para `[[patterns/novo-pattern]]`

> *Exemplo real no projeto incluso:* `plan.md` do microserviço de pagamentos documenta: *"Quando este padrão de SQS se repetir em outro serviço, promover para `patterns/events.md` via ADR."*

---

## Perguntas frequentes

**O workspace precisa ser um subdiretório do vault?**
Sim. O Obsidian precisa que os arquivos estejam dentro da pasta do vault para resolver os links. A pasta `workspace/` deve estar dentro de `eng-blueprint/`.

**O `.gitignore` do vault deve ignorar `workspace/`?**
Sim. Os projetos dentro de `workspace/` têm seus próprios repositórios Git. Adicione `workspace/` ao `.gitignore` do vault para evitar conflitos.

```gitignore
workspace/
```

**E se um projeto não usar TypeScript/Node?**
A `constitution.md` define TypeScript como linguagem principal. Projetos em outra stack precisam de aprovação do arquiteto e registro de ADR. Os patterns podem ser criados para outras stacks sem alterar a constitution.

**Posso usar sem Obsidian?**
Sim. Os links `[[nome-do-arquivo]]` são convenção do Obsidian, mas os documentos são Markdown puro e legíveis em qualquer editor. O agente de IA segue os links pelo nome do arquivo, não pela resolução do Obsidian. O Obsidian é recomendado para **navegação e validação humana** dos links.

**O agente pode quebrar a constitution?**
O agente só viola a constitution se você deixar. Por isso a spec inclui a instruction `leia [[constitution]] antes de qualquer ação`. Um agente que tenta armazenar dados de cartão, por exemplo, está violando `NFR-002` e `constitution.md` simultaneamente — dois documentos o impedem.

---

## Roadmap

- [ ] Template de spec para novos projetos (comando de scaffolding)
- [ ] Pattern para banco de dados (`patterns/database.md`)
- [ ] Pattern para filas de eventos (`patterns/events.md`)
- [ ] Pattern para autenticação (`patterns/auth.md`)
- [ ] Guia de criação de ADR (`docs/adr/template.md`)
- [ ] Integração com CI/CD para validar links de spec antes do merge

---

*Velocidade da IA + rigor de engenharia = outputs auditáveis, versionados e aprovados por humano.*
