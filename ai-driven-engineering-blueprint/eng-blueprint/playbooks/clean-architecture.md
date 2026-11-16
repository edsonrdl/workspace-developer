---
name: clean-architecture
description: Cria, estende ou audita um repo TypeScript/Node em Clean Architecture (Entities, Use Cases, Interface Adapters, Frameworks & Drivers), como monolito modular ou serviço único. Gera estrutura, código base, configuração e verificação automática da regra de dependência.
status: proposto
modes: [SCAFFOLD, ADD-MODULE, ADD-USE-CASE, AUDIT]
reads_first: [constitution, typescript-baseline]
---

# Pattern: Clean Architecture

> Playbook executável, escrito para que **qualquer agente** (Claude Code, Codex, Cursor, Copilot, Gemini…) leia e consiga **criar, estender ou auditar** um repo sem adivinhar. É o par do playbook [[hexagonal]]: a proteção do domínio é a mesma, muda a organização das camadas e o vocabulário.
> Base conceitual (o *porquê*) está na base de conhecimento do Obsidian, nota `Template Monolítico Modular (Multi-Module Clean Architecture)`. Este playbook é a versão **operacional**, adaptada à stack aprovada (TypeScript).

---

## Referências

- [[constitution]] manda: em conflito, ela vence este arquivo
- [[typescript-baseline]]: scripts, tsconfig, ESLint, Vitest, env, health, logger, event bus, CI. **Leia antes** deste
- [[hexagonal]]: compartilha o `shared-kernel`, os modos de trabalho e o processo de AUDIT (§14.1 a §14.3 de lá). Este arquivo traz só o que **muda**
- [[modular-monolith]]: este playbook é a forma Clean do monolito modular (a regra de `index.ts` público vira a pasta `api/`)
- [[rest-api]], [[microservice]], [[testing]], [[quality]], [[security]], [[observability]], [[documentation]], [[governance]]

---

## 0. Como o agente usa este arquivo

**Ordem de leitura:** `constitution` (só as seções citadas) → [[typescript-baseline]] → este arquivo → `sdd/plan.md`.
**Precedência:** constitution > typescript-baseline > este playbook > `sdd/plan.md`.

| Pedido do usuário | Modo | Vá para |
|---|---|---|
| "crie o projeto/serviço em clean architecture" | `SCAFFOLD` | §10 |
| "crie o módulo/contexto X" | `ADD-MODULE` | §11.1 |
| "crie o caso de uso Y no módulo X" | `ADD-USE-CASE` | §11.2 |
| "confira/ajuste este repo" | `AUDIT` | §12 |

**Antes de escrever:** preencha os parâmetros (§3). **Depois de qualquer modo:** `npm run verify` e relate o resultado real.
**Proibido:** commitar/push sem pedido explícito; instalar lib não declarada; inventar regra de negócio (`[NEEDS CLARIFICATION: …]`); escrever em outro repo.

---

## 1. Princípio fundamental

```
   interface ─┐                     ← controllers, presenters, event subscribers
              ├──►  application  ──►  domain          ← regra da dependência:
   infrastructure ─┘  (use cases)      (entities,         SEMPRE de fora para dentro
   (banco, fila, APIs)                   gateways)
```

- `domain` (Entities): regra de negócio da empresa, **não conhece ninguém**; define também as **interfaces (gateways)** que exige do mundo.
- `application` (Use Cases): regra de aplicação; orquestra entities via gateways; conhece só o `domain`.
- `interface` (Interface Adapters): traduz entrada/saída (controller, presenter, DTO HTTP, subscriber de evento); conhece só a `application`.
- `infrastructure` (Frameworks & Drivers): implementa os gateways com tecnologia real (banco, fila, APIs); conhece só o `domain`.
- `interface` e `infrastructure` **não se enxergam**.
- **Entre módulos:** só o `api/` do vizinho.

O fluxo de controle vai para fora; a **dependência de código aponta para dentro**. Verificado por `npm run arch`.

---

## 2. Quando usar e quando não usar

**Use:** domínio rico, regras que mudam, vários times, crescimento previsto, possível extração futura.
**Não use:** CRUD sem regra, MVP descartável. Aí [[mvc]] ou [[rest-api]] simples bastam.
**Clean ou Hexagonal?** Mesma proteção. Escolha **Hexagonal** quando o sistema tem muitas integrações e a simetria "entra por uma porta, sai por outra" ajuda; **Clean** quando o time já pensa em Use Cases/Entities e quer o domínio com seus gateways juntos. A escolha vira ADR `001-arquitetura.md`.

---

## 3. Parâmetros

Idênticos aos de [[hexagonal]] §3 (`serviceName`, `modules[]`, `topology`, `httpFramework`, `testRunner`, `dbAccess`, `logger`, `iac`). Faltou e é "perguntar": pergunte antes de gerar. Nomes de módulo em `kebab-case`, inglês.

---

## 4. Estrutura de pastas obrigatória

```
{{service-name}}/
├── src/
│   ├── shared-kernel/                     ← igual ao de [[hexagonal]] §4
│   ├── modules/
│   │   └── {{module}}/
│   │       ├── api/                       ← CONTRATO PÚBLICO (único ponto de saída)
│   │       │   ├── index.ts · {{module}}.api.ts · events.ts
│   │       ├── domain/                    ← Entities (Enterprise Business Rules)
│   │       │   ├── entities/              ← aggregate roots e entidades
│   │       │   ├── value-objects/
│   │       │   ├── services/              ← domain services
│   │       │   ├── events/                ← domain events
│   │       │   ├── gateways/              ← INTERFACES que o domínio exige (repositórios, serviços externos)
│   │       │   └── errors/
│   │       ├── application/               ← Use Cases (Application Business Rules)
│   │       │   ├── use-cases/
│   │       │   │   └── create-order/
│   │       │   │       ├── create-order.interactor.ts
│   │       │   │       ├── create-order.input.ts
│   │       │   │       └── create-order.output.ts
│   │       │   └── facade/                ← implementa a interface de api/
│   │       ├── interface/                 ← Interface Adapters
│   │       │   ├── http/                  ← controllers, request/response DTOs, presenters, error-mapper
│   │       │   └── events/                ← subscribers de eventos de OUTROS módulos
│   │       ├── infrastructure/            ← Frameworks & Drivers
│   │       │   ├── persistence/           ← repositórios (impl de gateways), mappers, migrations
│   │       │   ├── {{other-module}}/      ← ACL para outro módulo (usa só o api/ dele)
│   │       │   └── messaging/             ← publicação no EventBus
│   │       └── {{module}}.module.ts       ← composition root do módulo
│   └── bootstrap/                         ← igual ao de [[hexagonal]] §4 (só compõe)
├── tests/{integration,e2e}/
├── docs/adr/001-arquitetura.md
├── .dependency-cruiser.cjs · eslint.config.js · tsconfig*.json · vitest.config.ts
├── package.json · .env.example · .gitignore · README.md · CHANGELOG.md
```

Testes unitários ao lado do código. Em `single-service`, um único módulo.

---

## 5. Responsabilidades e onde colocar cada código

| Pasta | Responsabilidade | Pode importar | Não pode importar |
|---|---|---|---|
| `shared-kernel` | tipos base e contratos técnicos | nada | módulos, bootstrap, npm |
| `{{m}}/api` | contrato público | `shared-kernel` | domain, application, interface, infrastructure, npm |
| `{{m}}/domain` | entities, VOs, gateways, regra de negócio | `shared-kernel`, o próprio `domain` | application, interface, infrastructure, outros módulos, npm |
| `{{m}}/application` | use cases (interactors), input/output | o próprio `domain`, `api` de outros, `shared-kernel` | interface, infrastructure, npm |
| `{{m}}/interface` | controllers, presenters, DTOs HTTP, subscribers | `application` (use cases, input/output), libs de HTTP | `infrastructure`, `domain` direto |
| `{{m}}/infrastructure` | implementa gateways com tecnologia | `domain` (gateways, entities), `api` de outros, libs | `interface`, `application` |
| `{{m}}.module.ts` | composition root | todas as camadas do módulo, `api` de outros | — |
| `bootstrap` | liga módulos, config, `main` | `*.module.ts`, `shared-kernel` | camadas internas |

| Tipo de código | Local |
|---|---|
| Validação de **formato** | `interface/http` |
| Validação/cálculo de **negócio** | `domain/entities` ou `domain/services` |
| Orquestração, transação, autorização | `application/use-cases/<x>/*.interactor.ts` |
| JSON ↔ Input/Output | `interface/http` (controller e presenter) |
| Formatar o Output para a resposta HTTP | `interface/http/*.presenter.ts` |
| Banco, cache, API externa | `infrastructure/*` |
| Chamada a outro módulo | `infrastructure/<modulo>` com ACL |
| Evento de negócio / que cruza módulos | `domain/events` / `api/events.ts` |
| `process.env` | **somente** `bootstrap/config.ts` |

---

## 6. Especificação de código (templates)

> `shared-kernel` (AggregateRoot, DomainEvent, DomainError, Money, UnitOfWork, EventBus, Logger, SqlClient) e o aggregate `Order` são **idênticos** aos de [[hexagonal]] §6.1 e §6.2; muda só a pasta: `domain/entities/order.ts`. Código em **inglês** ([[quality]]).

### 6.1 domain: gateways (interfaces do domínio)

```ts
// src/modules/orders/domain/gateways/order.repository.ts
import type { Order } from '../entities/order';

export interface OrderRepository {
  save(order: Order): Promise<void>;
  findById(id: string): Promise<Order | undefined>;
}
```

```ts
// src/modules/orders/domain/gateways/catalog.gateway.ts — serviço de outro módulo, com tipos PRÓPRIOS de orders
export interface SellableProduct { readonly id: string; readonly priceCents: number; readonly currency: string; }
export interface CatalogGateway { findSellableProduct(productId: string): Promise<SellableProduct | undefined>; }
```

```ts
// src/modules/orders/domain/gateways/event-publisher.gateway.ts
import type { IntegrationEvent } from '../../../../shared-kernel/events/event-bus';
export interface EventPublisherGateway { publish(event: IntegrationEvent): Promise<void>; }
```

### 6.2 application: use case (interactor + input + output)

```ts
// src/modules/orders/application/use-cases/create-order/create-order.input.ts · create-order.output.ts
export interface CreateOrderInput {
  readonly customerId: string;
  readonly items: readonly { readonly productId: string; readonly quantity: number }[];
}
export interface CreateOrderOutput { readonly orderId: string; readonly totalCents: number; readonly currency: string; }
```

```ts
// src/modules/orders/application/use-cases/create-order/create-order.interactor.ts
// Orquestra; NÃO tem regra de negócio e NÃO conhece tecnologia. Depende só de gateways do domain.
import { Money } from '../../../../../shared-kernel/domain/money';
import type { UnitOfWork } from '../../../../../shared-kernel/application/unit-of-work';
import { Order } from '../../../domain/entities/order';
import { ProductNotFoundError } from '../../../domain/errors/product-not-found.error';
import type { OrderRepository } from '../../../domain/gateways/order.repository';
import type { CatalogGateway } from '../../../domain/gateways/catalog.gateway';
import type { EventPublisherGateway } from '../../../domain/gateways/event-publisher.gateway';
import type { CreateOrderInput } from './create-order.input';
import type { CreateOrderOutput } from './create-order.output';

export class CreateOrderInteractor {
  constructor(
    private readonly orders: OrderRepository,
    private readonly catalog: CatalogGateway,
    private readonly events: EventPublisherGateway,
    private readonly uow: UnitOfWork,
  ) {}

  async execute(input: CreateOrderInput): Promise<CreateOrderOutput> {
    const order = Order.create(input.customerId);
    for (const item of input.items) {
      const product = await this.catalog.findSellableProduct(item.productId);
      if (!product) throw new ProductNotFoundError(item.productId);
      order.addItem(product.id, item.quantity, Money.of(product.priceCents, product.currency)); // regra: entity
    }
    order.confirm();

    await this.uow.run(async () => { await this.orders.save(order); });

    for (const e of order.pullEvents()) {
      await this.events.publish({
        eventId: e.eventId, eventType: e.eventType, occurredAt: e.occurredAt, version: 1,
        payload: { orderId: order.id, items: order.snapshot().items.map(i => ({ productId: i.productId, quantity: i.quantity })) },
      });
    }
    const total = order.total('BRL');
    return { orderId: order.id, totalCents: total.cents, currency: 'BRL' };
  }
}
```

> **Teste sem framework:** `new CreateOrderInteractor(inMemoryRepo, fakeCatalog, fakeEvents, { run: w => w() })`.
> Se o interactor precisar ser chamado por mais de um adapter ou trocado em teste, extraia uma interface `CreateOrderUseCase` na `application`; o controller passa a depender dela (é o que o [[hexagonal]] faz como "porta de entrada").

### 6.3 interface: controller, presenter e erros

```ts
// src/modules/orders/interface/http/orders.controller.ts — fino: traduz HTTP ↔ use case
import type { CreateOrderInteractor } from '../../application/use-cases/create-order/create-order.interactor';
import { presentCreatedOrder } from './create-order.presenter';

export interface HttpRequest { body: unknown; requestId: string; }
export interface HttpResponse { status: number; body: unknown; }

export class OrdersController {
  constructor(private readonly createOrder: CreateOrderInteractor) {}

  async create(req: HttpRequest): Promise<HttpResponse> {
    const input = parseCreateOrderBody(req.body);          // validação de FORMATO (400)
    const output = await this.createOrder.execute(input);
    return presentCreatedOrder(output, req.requestId);
  }
}
```

```ts
// src/modules/orders/interface/http/create-order.presenter.ts — Output → resposta HTTP ([[rest-api]])
import type { CreateOrderOutput } from '../../application/use-cases/create-order/create-order.output';

export function presentCreatedOrder(output: CreateOrderOutput, requestId: string) {
  return {
    status: 201,
    body: { data: output, meta: { timestamp: new Date().toISOString(), requestId } },
  };
}
```

`error-mapper.ts`: igual ao de [[hexagonal]] §6.5 (`DomainError.kind` → status; erro inesperado → 500 genérico).

### 6.4 infrastructure: implementa os gateways

```ts
// src/modules/orders/infrastructure/persistence/order.repository.sql.ts — IMPLEMENTA OrderRepository
import type { SqlClient } from '../../../../shared-kernel/persistence/sql-client';
import type { OrderRepository } from '../../domain/gateways/order.repository';
import type { Order } from '../../domain/entities/order';
import { toDomain, type OrderItemRow, type OrderRow } from './order.mapper';
// mesma lógica de SQL/mapper de [[hexagonal]] §6.6; schema "orders" (módulo é dono dos seus dados)

export class SqlOrderRepository implements OrderRepository {
  constructor(private readonly sql: SqlClient) {}
  async save(order: Order): Promise<void> { /* INSERT/UPSERT em orders.orders e orders.order_items */ }
  async findById(id: string): Promise<Order | undefined> {
    const [row] = await this.sql.query<OrderRow>(`SELECT * FROM orders.orders WHERE id = $1`, [id]);
    if (!row) return undefined;
    const items = await this.sql.query<OrderItemRow>(`SELECT * FROM orders.order_items WHERE order_id = $1`, [id]);
    return toDomain(row, items);
  }
}
```

```ts
// src/modules/orders/infrastructure/catalog/catalog.acl.gateway.ts — ACL para outro módulo (só o api/ dele)
import type { CatalogApi } from '../../../catalog/api';
import type { CatalogGateway, SellableProduct } from '../../domain/gateways/catalog.gateway';

export class CatalogAclGateway implements CatalogGateway {
  constructor(private readonly catalog: CatalogApi) {}
  async findSellableProduct(productId: string): Promise<SellableProduct | undefined> {
    const p = await this.catalog.getProduct(productId);
    if (!p || !p.available) return undefined;
    return { id: p.id, priceCents: p.priceCents, currency: p.currency };   // traduz para o modelo de orders
  }
}
```

Publisher: `infrastructure/messaging/order-events.bus.publisher.ts` implementa `EventPublisherGateway` delegando ao `EventBus`. Subscriber de evento de outro módulo: `interface/events/<evento>.subscriber.ts`, chamando um interactor.

### 6.5 api e composition root

`api/` é **igual** ao de [[hexagonal]] §6.4 (interface `OrdersApi`, `events.ts`, `index.ts`), implementada em `application/facade/orders.facade.ts`.

```ts
// src/modules/orders/orders.module.ts — único lugar que liga as camadas do módulo
export function createOrdersModule(deps: OrdersModuleDeps): OrdersModule {
  const repository = new SqlOrderRepository(deps.sql);
  const createOrder = new CreateOrderInteractor(
    repository, new CatalogAclGateway(deps.catalogApi), new BusOrderEventsPublisher(deps.eventBus), deps.uow,
  );
  return { api: new OrdersFacade(repository), controller: new OrdersController(createOrder) };
}
```

`bootstrap/app.ts`: instancia na ordem das dependências (igual ao de [[hexagonal]] §6.7).

---

## 7. Comunicação entre módulos, banco e erros

Iguais aos de [[hexagonal]] (§7, §8, §9): `api/` + ACL para síncrono; `EventBus` para assíncrono (contrato `eventId/eventType/occurredAt/version/payload`); **schema por módulo** (ou prefixo), sem FK/JOIN entre módulos, migrations versionadas e nunca editadas; `DomainError` → envelope de erro; erro inesperado → 500 genérico.

---

## 8. Configuração de arquitetura

Configuração de projeto: [[typescript-baseline]]. O que é **específico** do Clean é o `.dependency-cruiser.cjs`:

```js
/** @type {import('dependency-cruiser').IConfiguration} */
const NPM = ['npm', 'npm-dev', 'npm-optional', 'npm-peer', 'npm-bundled', 'npm-no-pkg', 'npm-unknown'];

module.exports = {
  forbidden: [
    { name: 'no-circular', severity: 'error', from: {}, to: { circular: true } },

    // REGRA DA DEPENDÊNCIA — de fora para dentro
    { name: 'domain-depends-on-nothing', severity: 'error',
      from: { path: '^src/modules/([^/]+)/domain' },
      to: { path: '^src', pathNot: ['^src/modules/$1/domain', '^src/shared-kernel'] } },
    { name: 'domain-no-npm', severity: 'error',
      from: { path: '^src/modules/[^/]+/domain' }, to: { dependencyTypes: NPM } },
    { name: 'application-only-domain', severity: 'error',
      comment: 'use cases conhecem só o domain (e o api de outros módulos)',
      from: { path: '^src/modules/([^/]+)/application' },
      to: { path: '^src/modules/$1/(interface|infrastructure)' } },
    { name: 'application-no-npm', severity: 'error',
      from: { path: '^src/modules/[^/]+/application' }, to: { dependencyTypes: NPM } },
    { name: 'interface-not-infrastructure', severity: 'error',
      from: { path: '^src/modules/[^/]+/interface' }, to: { path: '^src/modules/[^/]+/infrastructure' } },
    { name: 'infrastructure-not-interface', severity: 'error',
      from: { path: '^src/modules/[^/]+/infrastructure' }, to: { path: '^src/modules/[^/]+/interface' } },
    { name: 'infrastructure-not-application', severity: 'error',
      comment: 'infra implementa gateways do domain; não chama use cases',
      from: { path: '^src/modules/[^/]+/infrastructure' }, to: { path: '^src/modules/[^/]+/application' } },
    { name: 'interface-not-domain', severity: 'error',
      comment: 'controllers falam com use cases, nunca com entities',
      from: { path: '^src/modules/[^/]+/interface' }, to: { path: '^src/modules/[^/]+/domain' } },

    // ENTRE MÓDULOS — só o api/
    { name: 'modules-only-through-api', severity: 'error',
      from: { path: '^src/modules/([^/]+)/' },
      to: { path: '^src/modules/[^/]+/', pathNot: ['^src/modules/$1/', '^src/modules/[^/]+/api/'] } },
    { name: 'api-is-contract-only', severity: 'error',
      from: { path: '^src/modules/[^/]+/api' },
      to: { path: '^src/modules/[^/]+/(domain|application|interface|infrastructure)' } },
    { name: 'api-no-npm', severity: 'error',
      from: { path: '^src/modules/[^/]+/api' }, to: { dependencyTypes: NPM } },

    // shared-kernel e bootstrap
    { name: 'shared-kernel-isolated', severity: 'error',
      from: { path: '^src/shared-kernel' }, to: { path: '^src/(modules|bootstrap)' } },
    { name: 'shared-kernel-no-npm', severity: 'error',
      from: { path: '^src/shared-kernel' }, to: { dependencyTypes: NPM } },
    { name: 'nobody-imports-bootstrap', severity: 'error',
      from: { path: '^src/(modules|shared-kernel)' }, to: { path: '^src/bootstrap' } },
    { name: 'bootstrap-only-composition-roots', severity: 'error',
      from: { path: '^src/bootstrap' },
      to: { path: '^src/modules/[^/]+/(domain|application|interface|infrastructure)' } },
  ],
  options: {
    doNotFollow: { path: 'node_modules' },
    exclude: { path: '\\.(test|spec)\\.ts$' },
    tsPreCompilationDeps: true,
    tsConfig: { fileName: 'tsconfig.json' },
    enhancedResolveOptions: { exportsFields: ['exports'], conditionNames: ['import', 'require', 'node', 'default'] },
  },
};
```

As regras são genéricas (regex) e valem para **módulo novo sem editar o arquivo**.

> **Falso-verde:** o `arch` só vale se o cruiser realmente lê o TypeScript. Use `typescript@~5.9` e o `scripts/arch-sanity.cjs` do [[typescript-baseline]]; sem eles, TS 7 resulta em "0 módulos analisados" e passa sem checar nada.

---

## 9. Testes por camada

| Camada | O que testar | Como |
|---|---|---|
| `domain` | invariantes e regras | puro, sem mock, ms |
| `application` | orquestração, ordem, erros | fakes dos gateways, sem framework |
| `interface` | formato, status HTTP, presenter | controller com o use case mockado |
| `infrastructure` | mapper, SQL, contrato do gateway | integração com banco real/container |
| arquitetura | regra da dependência | `npm run arch` + prova de proteção (§10 passo 11) |

Pirâmide e cobertura de [[testing]] (≥ 80%).

---

## 10. Modo SCAFFOLD

1. Criar a árvore da §4 (`.gitkeep` nas vazias).
2. Gerar os arquivos de [[typescript-baseline]] (package, tsconfig, ESLint, Vitest, `.env.example`, `.gitignore`, `config.ts`, `health.ts`, `in-memory-event-bus.ts`).
3. Gerar o `shared-kernel` (igual ao de [[hexagonal]]).
4. Gerar `.dependency-cruiser.cjs` (§8).
5. Por módulo, **uma fatia vertical completa**: entity + erro, gateways, interactor+input+output, controller+presenter+error-mapper, repositório+mapper, ACL (se houver), publisher, `api/`, `<m>.module.ts`, migration inicial, testes.
6. `bootstrap/app.ts` e `main.ts` (config → infra com as libs do plan → `buildApp` → HTTP com `GET /health`).
7. Instalar **só** as dependências declaradas.
8. Testes das camadas (§9).
9. README, CHANGELOG, `docs/adr/001-arquitetura.md`.
10. `npm run verify` até ficar verde.
11. **Prova de proteção:** importar temporariamente uma lib npm em `domain/`, depois um `../../other/domain/...` em outro módulo, e um `infrastructure` dentro de `application`; confirmar que `npm run arch` **falha** em cada um; remover. Registrar.
12. Relatar o que foi criado, o `verify` real e as pendências. **Não commitar.**

---

## 11. Outros modos

### 11.1 `ADD-MODULE`
1. Confirmar nome e responsabilidade em 1 frase (se precisa de "e", dividir).
2. Criar `src/modules/{{module}}/` conforme §4; começar pelo `api/`.
3. Domain → application → interface/infrastructure → `<m>.module.ts`.
4. Registrar em `bootstrap/app.ts` na ordem de dependência.
5. Schema/prefixo e migration próprios; **sem FK** para outro módulo.
6. Outro módulo necessário: gateway no `domain` + ACL em `infrastructure/<outro>`; reação a evento: `interface/events`.
7. Testes + `npm run verify`; README/ADR se a fronteira for decisão nova.

### 11.2 `ADD-USE-CASE`
1. Pasta `application/use-cases/<verb-noun>/` com `*.input.ts`, `*.output.ts`, `*.interactor.ts`.
2. Gateways novos no `domain/gateways`, só se necessário.
3. Regra de negócio na entity/domain service, **teste primeiro**.
4. Interactor orquestra; sem cálculo de negócio.
5. Controller + presenter (e rota) em `interface/http`; implementação do gateway novo em `infrastructure`.
6. Ligar em `<m>.module.ts`. `npm run verify`.

---

## 12. Modo AUDIT

O **processo** (diagnóstico, relatório, ajuste incremental com baseline de violações, nunca big-bang) é o de [[hexagonal]] §14.1 a §14.3, trocando a checklist H-xx pela C-xx abaixo e `adapters/ports` por `interface/infrastructure/gateways`. Regra: AUDIT é **somente leitura** até o humano aprovar o plano; ajuste por task de SDD.

Classificação de layout: **A** em camadas/MVC · **B** parcialmente Clean (há `domain`/`use-cases` mas com vazamento) · **C** conforme · **D** sem estrutura.

| ID | Verificação | Como checar | Sev |
|---|---|---|---|
| C-01 | `domain` sem npm/framework | `npm run arch` (`domain-no-npm`) | B |
| C-02 | `domain` não importa application/interface/infrastructure/outro módulo | `npm run arch` | B |
| C-03 | `application` só conhece `domain` | `npm run arch` | B |
| C-04 | `interface` ↔ `infrastructure` sem importação mútua | `npm run arch` | B |
| C-05 | `infrastructure` não chama use cases | `npm run arch` | B |
| C-06 | Módulo só importa o `api/` do outro | `npm run arch` | B |
| C-07 | Sem ciclos | `npm run arch` | B |
| C-08 | Gateways (interfaces) vivem no `domain/gateways`; implementação só em `infrastructure` | revisão | B |
| C-09 | Entity ≠ modelo de persistência (há mapper) | existência de `*.mapper.ts` | M |
| C-10 | Controller sem regra de negócio nem mutação de entity | revisão de `interface/http` | M |
| C-11 | Interactor sem cálculo de negócio | revisão de `application` | M |
| C-12 | Infra não decide fluxo (não dispara e-mail/evento por condição de negócio) | revisão de `infrastructure` | M |
| C-13 | Entities ricas, não anêmicas (getters/setters sem comportamento) | `grep -rnE "^\s*set [a-z]" src/modules/*/domain` + revisão | M |
| C-14 | Dinheiro não é `number` | revisão | M |
| C-15 | Schema/prefixo por módulo; sem FK/JOIN entre módulos | migrations | B |
| C-16 | `process.env` só em `bootstrap/config.ts`; `GET /health` ok; sem `console.*`/`any` | `npm run lint` + teste | M |
| C-17 | Cobertura ≥ 80%; `npm audit` sem alta/crítica | `npm run verify` | B |
| C-18 | ADR da arquitetura, README, CHANGELOG | existência | m |

Anti-padrões típicos: **over-engineering em CRUD** (use [[mvc]]); **entity anêmica** (mover regra do service para a entity); **vazamento de framework no domain**; **interactor "faz-tudo"**; **módulo acessando internals do vizinho** (use `api/` + ACL).

---

## 13. Definition of Done

- [ ] `npm run verify` verde, com o resultado real colado no relatório
- [ ] Prova de proteção feita (SCAFFOLD/ADD-MODULE)
- [ ] Nenhuma lib fora do `plan.md`; nenhum segredo
- [ ] ADR/README/CHANGELOG atualizados
- [ ] Dúvidas de negócio como `[NEEDS CLARIFICATION]`
- [ ] Nada commitado sem pedido

---

## 14. Evolução para microserviço

Extrair `catalog`: o `CatalogAclGateway` passa a chamar HTTP; o subscriber troca o `InMemoryEventBus` pela fila; o schema vira banco próprio. **Não mudam** `domain` nem `application`. O novo serviço segue [[microservice]] e mantém a mesma estrutura.
