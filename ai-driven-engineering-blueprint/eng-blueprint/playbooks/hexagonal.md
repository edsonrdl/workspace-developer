---
name: hexagonal
description: Cria, estende ou audita um repo TypeScript/Node em Arquitetura Hexagonal (Ports & Adapters), como monolito modular (vários bounded contexts) ou serviço único. Gera estrutura, código base, configuração e verificação automática de arquitetura.
status: proposto
modes: [SCAFFOLD, ADD-MODULE, ADD-USE-CASE, AUDIT]
reads_first: [constitution, typescript-baseline]
---

# Pattern: Hexagonal (Ports & Adapters)

> Playbook executável. Foi escrito para que **qualquer agente** (Claude Code, Codex, Cursor, Copilot, Gemini…) leia este arquivo e consiga **criar, estender ou auditar** um repo sem adivinhar. Quem escreve o código segue as seções na ordem; quem revisa usa o Checklist H-xx da seção 13.
> Base conceitual (o *porquê*) está na base de conhecimento do Obsidian, nota `Template Monolítico Modular (Multi-Module Hexagonal Architecture)`. Este playbook é a versão **operacional**, adaptada à stack aprovada (TypeScript).

---

## Referências

- [[constitution]] manda: em conflito, ela vence este arquivo
- [[typescript-baseline]]: scripts, tsconfig, ESLint, Vitest, env, health, logger, CI. **Leia antes** deste
- [[modular-monolith]]: este playbook é a forma hexagonal do monolito modular (a regra de `index.ts` público vira a pasta `api/`)
- [[rest-api]]: contratos HTTP dos adapters de entrada
- [[microservice]]: caminho de extração de um módulo para serviço
- [[testing]], [[quality]], [[security]], [[observability]]

---

## 0. Como o agente usa este arquivo

**Ordem de leitura:** `constitution` (só as seções citadas) → [[typescript-baseline]] → este arquivo → `sdd/plan.md` do projeto.
**Precedência:** constitution > typescript-baseline > este playbook > `sdd/plan.md`. O `plan.md` só declara o que é **único** do projeto (nomes dos módulos, libs escolhidas, decisões).

**Escolha o modo pelo pedido:**

| Pedido do usuário | Modo | Vá para |
|---|---|---|
| "crie o projeto/serviço em hexagonal" | `SCAFFOLD` | §11 |
| "crie o módulo/contexto X" | `ADD-MODULE` | §12 |
| "crie o caso de uso Y no módulo X" | `ADD-USE-CASE` | §12.2 |
| "confira/ajuste este repo", "está de acordo com a arquitetura?" | `AUDIT` | §14 |

**Antes de escrever qualquer arquivo:** preencha os **Parâmetros** (§3). O que faltar e for "pergunte", pergunte (uma pergunta curta por vez, no máximo as de bloqueio).
**Depois de qualquer modo:** rode `npm run verify` e relate o resultado real.
**Proibido:** commitar, criar branch ou fazer push sem pedido explícito; instalar lib não declarada; escrever em outro repo; inventar regra de negócio (lacuna vira `[NEEDS CLARIFICATION: …]`).

---

## 1. Princípio fundamental

O negócio fica no centro e **não conhece tecnologia**. Tudo que fala com o mundo (HTTP, banco, fila, outro módulo) entra e sai por **portas** (interfaces) com **adapters** (implementações) nas bordas.

```
        adapters/in  ───►  application  ───►  domain
        (HTTP, eventos)    (casos de uso,      (regras de negócio,
                            portas in/out)      sem dependência)
                                 ▲
        adapters/out ────────────┘  implementam as portas de saída
        (banco, APIs, bus, outros módulos)
```

**Duas regras inegociáveis (verificadas por `npm run arch`):**

1. **Dentro de um módulo:** `domain` não conhece ninguém; `application` conhece só `domain`; `adapters` conhecem `application` (e podem conhecer a tecnologia). `adapters/in` e `adapters/out` **não se enxergam**.
2. **Entre módulos:** um módulo só importa o `api/` de outro. Nunca `domain`, `application` ou `adapters` do vizinho.

Quem garante: `dependency-cruiser` (§10.1) + ESLint + tipos. Sem `arch` verde, não há merge.

---

## 2. Quando usar e quando não usar

**Use:** domínio com regra de negócio relevante; várias integrações voláteis (pagamento, ERP, fila); várias pessoas/times no mesmo código; possível extração futura de módulos.
**Não use:** CRUD sem regra, protótipo descartável, script/job trivial. Aí use uma [[rest-api]] simples em camadas. Se o repo mistura, aplique Hexagonal **só nos módulos com regra rica**.

---

## 3. Parâmetros (o agente preenche antes de gerar)

| Parâmetro | Exemplo | Origem | Se faltar |
|---|---|---|---|
| `serviceName` | `shop` | `plan.md` | perguntar |
| `modules[]` | `catalog`, `orders` | `plan.md` / refinamento | perguntar quais bounded contexts |
| `topology` | `modular-monolith` \| `single-service` | `plan.md` | perguntar (padrão: `modular-monolith`) |
| `httpFramework` | Fastify, Express | `plan.md` | perguntar |
| `testRunner` | Vitest | `plan.md`/repo | perguntar |
| `dbAccess` | driver/ORM | `plan.md`/repo | perguntar |
| `logger` | Pino | `plan.md` | perguntar |
| `iac` | Terraform/CDK | `plan.md` | perguntar (só se o SDD pedir infra) |

Nomes de módulo: `kebab-case` em inglês, substantivo do negócio (`orders`, `payments`). Em `single-service`, use **um** módulo.

---

## 4. Estrutura de pastas obrigatória

```
{{service-name}}/
├── src/
│   ├── shared-kernel/                     ← mínimo, estável, sem framework
│   │   ├── domain/
│   │   │   ├── aggregate-root.ts
│   │   │   ├── domain-event.ts
│   │   │   ├── domain-error.ts
│   │   │   └── money.ts
│   │   ├── application/unit-of-work.ts
│   │   ├── events/event-bus.ts
│   │   ├── observability/logger.ts
│   │   └── persistence/sql-client.ts
│   │
│   ├── modules/
│   │   └── {{module}}/                    ← UM bounded context
│   │       ├── api/                       ← CONTRATO PÚBLICO (único ponto de saída do módulo)
│   │       │   ├── index.ts               ← reexporta o que é público
│   │       │   ├── {{module}}.api.ts      ← interface (facade) para OUTROS módulos
│   │       │   └── events.ts              ← integration events publicados
│   │       ├── domain/                    ← núcleo: regra de negócio pura
│   │       │   ├── model/                 ← aggregates, entities, value objects
│   │       │   ├── services/              ← domain services
│   │       │   ├── specifications/
│   │       │   ├── events/                ← domain events
│   │       │   └── errors/
│   │       ├── application/
│   │       │   ├── ports/
│   │       │   │   ├── in/                ← PORTAS DE ENTRADA: um use case por intenção
│   │       │   │   └── out/               ← PORTAS DE SAÍDA: o que a aplicação exige do mundo
│   │       │   ├── services/              ← implementam as portas de entrada
│   │       │   ├── commands/              ← DTOs de entrada dos use cases
│   │       │   ├── results/               ← DTOs de saída
│   │       │   └── facade/                ← implementa a interface de api/
│   │       ├── adapters/
│   │       │   ├── in/
│   │       │   │   ├── http/              ← controllers, request/response DTOs, rotas
│   │       │   │   └── events/            ← assinantes de eventos de OUTROS módulos
│   │       │   └── out/
│   │       │       ├── persistence/       ← repositórios + mappers + migrations
│   │       │       ├── {{other-module}}/  ← ACL para outro módulo (usa só o api/ dele)
│   │       │       └── events/            ← publicação no EventBus
│   │       └── {{module}}.module.ts       ← composition root do módulo (monta use cases e adapters)
│   │
│   └── bootstrap/                         ← só compõe: não tem regra de negócio
│       ├── main.ts                        ← inicia a aplicação
│       ├── config.ts                      ← único leitor de process.env
│       ├── health.ts
│       ├── in-memory-event-bus.ts
│       └── app.ts                         ← instancia os módulos na ordem certa
│
├── tests/
│   ├── integration/
│   └── e2e/
├── sdd/                                   ← quando existir
├── .dependency-cruiser.cjs
├── eslint.config.js · tsconfig.json · tsconfig.build.json · vitest.config.ts
├── package.json · .env.example · .gitignore
└── README.md · CHANGELOG.md
```

**Em `single-service`:** a mesma árvore, com um único módulo em `src/modules/`.
**Testes unitários** ficam ao lado do código (`order.test.ts` ao lado de `order.ts`).

---

## 5. Responsabilidades e onde colocar cada código

| Pasta | Responsabilidade | Pode importar | Não pode importar |
|---|---|---|---|
| `shared-kernel` | tipos base e contratos técnicos mínimos | nada (só TS) | módulos, bootstrap, libs npm |
| `{{m}}/api` | contrato público (interfaces, DTOs simples, eventos) | `shared-kernel` | domain, application, adapters, npm |
| `{{m}}/domain` | regra de negócio | `shared-kernel`, o próprio `domain` | application, adapters, outros módulos, npm |
| `{{m}}/application` | orquestração, portas in/out | o próprio `domain`, `api` do próprio módulo, `api` de outros, `shared-kernel` | adapters, npm |
| `{{m}}/adapters/in` | traduz entrada (HTTP/evento) em command e chama porta de entrada | `application/ports/in`, commands/results, libs de tecnologia | `adapters/out`, `domain` direto |
| `{{m}}/adapters/out` | implementa porta de saída com tecnologia real | `application/ports/out`, `domain`, `api` de outros módulos, libs | `adapters/in` |
| `{{m}}.module.ts` | composition root do módulo | todas as camadas do próprio módulo, `api` de outros | — |
| `bootstrap` | liga módulos, config, `main` | `*.module.ts`, `shared-kernel` | camadas internas dos módulos |

**Onde colocar cada tipo de código** (alinha com a base de conhecimento, "Onde Colocar Cada Tipo de Código"):

| Tipo de código | Local |
|---|---|
| Validação de **formato** (e-mail, tamanho, obrigatório) | `adapters/in/http` (schema/validator) |
| Validação e cálculo de **negócio** | `domain` (método do aggregate, domain service ou specification) |
| Orquestração de um caso de uso | `application/services` |
| Transação | `application/services` via `UnitOfWork` |
| Autorização (pode/ não pode) | `application/services` |
| Autenticação (JWT) | `adapters/in/http` (middleware) |
| JSON ↔ Command/Result | `adapters/in/http` |
| Banco, cache, API externa | `adapters/out/*` |
| Chamada a outro módulo | `adapters/out/<modulo>` com ACL |
| Evento de negócio (ocorrido) | `domain/events` |
| Evento que cruza módulos | `api/events.ts` |
| Montagem de dependências | `{{m}}.module.ts` e `bootstrap` |
| `process.env` | **somente** `bootstrap/config.ts` |

**Regra de triagem:** a decisão depende de conhecimento de negócio ou só de execução técnica? Negócio → `domain`; técnica → adapter. Regra de uma entidade só → método da entidade; combina duas entidades/aggregates → domain service; reutilizável e combinável → specification. `application` apenas **chama** a decisão tomada pelo domínio.

---

## 6. Especificação de código (templates)

> Nomes de código em **inglês** ([[quality]]). Exemplo: contextos `orders` e `catalog`. Funções com mais de 20 linhas levam comentário de propósito.

### 6.1 shared-kernel (domínio)

```ts
// src/shared-kernel/domain/domain-event.ts
export interface DomainEvent {
  readonly eventId: string;
  readonly occurredAt: string; // ISO8601
  readonly eventType: string;  // SNAKE_CASE
}
```

```ts
// src/shared-kernel/domain/aggregate-root.ts
import type { DomainEvent } from './domain-event';

export abstract class AggregateRoot<TId> {
  private events: DomainEvent[] = [];
  protected constructor(public readonly id: TId) {}

  protected record(event: DomainEvent): void { this.events.push(event); }

  // Entrega e limpa os eventos pendentes (quem persiste decide quando publicar).
  pullEvents(): DomainEvent[] {
    const pending = this.events;
    this.events = [];
    return pending;
  }
}
```

```ts
// src/shared-kernel/domain/domain-error.ts
// Erro de regra de negócio. `code` em SNAKE_CASE vira o código do envelope HTTP ([[rest-api]]).
export abstract class DomainError extends Error {
  abstract readonly code: string;
  abstract readonly kind: 'not_found' | 'conflict' | 'invalid' | 'forbidden';
}
```

```ts
// src/shared-kernel/domain/money.ts — nunca number para dinheiro: centavos inteiros
export class Money {
  private constructor(public readonly cents: number, public readonly currency: string) {}

  static of(cents: number, currency: string): Money {
    if (!Number.isInteger(cents)) throw new RangeError('Money exige centavos inteiros');
    return new Money(cents, currency);
  }
  static zero(currency: string): Money { return new Money(0, currency); }

  add(other: Money): Money {
    if (other.currency !== this.currency) throw new RangeError('Moedas diferentes');
    return new Money(this.cents + other.cents, this.currency);
  }
  times(quantity: number): Money { return new Money(this.cents * quantity, this.currency); }
}
```

### 6.2 domain (módulo `orders`)

```ts
// src/modules/orders/domain/errors/empty-order.error.ts
import { DomainError } from '../../../../shared-kernel/domain/domain-error';

export class EmptyOrderError extends DomainError {
  readonly code = 'EMPTY_ORDER';
  readonly kind = 'invalid' as const;
  constructor(orderId: string) { super(`Pedido ${orderId} não tem itens`); }
}
```

```ts
// src/modules/orders/domain/model/order.ts — aggregate root: invariantes vivem aqui
import { randomUUID } from 'node:crypto';
import { AggregateRoot } from '../../../../shared-kernel/domain/aggregate-root';
import { Money } from '../../../../shared-kernel/domain/money';
import { EmptyOrderError } from '../errors/empty-order.error';
import { OrderAlreadyConfirmedError } from '../errors/order-already-confirmed.error';

export type OrderStatus = 'DRAFT' | 'CONFIRMED' | 'CANCELLED';
export interface OrderItem { readonly productId: string; readonly quantity: number; readonly unitPrice: Money; }

export class Order extends AggregateRoot<string> {
  private readonly items: OrderItem[] = [];
  private status: OrderStatus = 'DRAFT';

  private constructor(id: string, public readonly customerId: string) { super(id); }

  static create(customerId: string): Order {
    const order = new Order(randomUUID(), customerId);
    order.record({ eventId: randomUUID(), occurredAt: new Date().toISOString(), eventType: 'ORDER_CREATED' });
    return order;
  }

  // Reconstrução a partir da persistência (não gera evento)
  static restore(id: string, customerId: string, items: OrderItem[], status: OrderStatus): Order {
    const order = new Order(id, customerId);
    order.items.push(...items);
    order.status = status;
    return order;
  }

  addItem(productId: string, quantity: number, unitPrice: Money): void {
    this.ensureDraft();
    if (!Number.isInteger(quantity) || quantity <= 0) throw new RangeError('Quantidade deve ser inteira e positiva');
    this.items.push({ productId, quantity, unitPrice });
  }

  confirm(): void {                       // a regra "pedido vazio não confirma" mora AQUI
    this.ensureDraft();
    if (this.items.length === 0) throw new EmptyOrderError(this.id);
    this.status = 'CONFIRMED';
    this.record({ eventId: randomUUID(), occurredAt: new Date().toISOString(), eventType: 'ORDER_CONFIRMED' });
  }

  total(currency: string): Money {
    return this.items.reduce((sum, i) => sum.add(i.unitPrice.times(i.quantity)), Money.zero(currency));
  }

  snapshot(): { items: readonly OrderItem[]; status: OrderStatus } {
    return { items: [...this.items], status: this.status };
  }

  private ensureDraft(): void {
    if (this.status !== 'DRAFT') throw new OrderAlreadyConfirmedError(this.id);
  }
}
```

Regras do domínio: sem setters públicos; mudança de estado só por método de negócio; **sem** `import` de lib npm (só `node:crypto` e o `shared-kernel`); sem I/O; sem `Date.now()` espalhado se o relógio importar para a regra (injete um `Clock` pela aplicação).

### 6.3 application: portas e casos de uso

```ts
// src/modules/orders/application/ports/in/create-order.use-case.ts — PORTA DE ENTRADA
import type { CreateOrderCommand } from '../../commands/create-order.command';
import type { CreateOrderResult } from '../../results/create-order.result';

export interface CreateOrderUseCase {
  execute(command: CreateOrderCommand): Promise<CreateOrderResult>;
}
```

```ts
// src/modules/orders/application/ports/out/order.repository.ts — PORTA DE SAÍDA
import type { Order } from '../../../domain/model/order';

export interface OrderRepository {
  save(order: Order): Promise<void>;
  findById(id: string): Promise<Order | undefined>;
}
```

```ts
// src/modules/orders/application/ports/out/catalog.port.ts — PORTA DE SAÍDA para outro módulo.
// Tipos PRÓPRIOS do contexto orders (não reaproveita o modelo do catalog).
export interface SellableProduct { readonly id: string; readonly priceCents: number; readonly currency: string; }

export interface CatalogPort {
  findSellableProduct(productId: string): Promise<SellableProduct | undefined>;
}
```

```ts
// src/modules/orders/application/ports/out/order-events.publisher.ts
import type { IntegrationEvent } from '../../../../../shared-kernel/events/event-bus';
export interface OrderEventsPublisher { publish(event: IntegrationEvent): Promise<void>; }
```

```ts
// src/modules/orders/application/commands/create-order.command.ts · results/create-order.result.ts
export interface CreateOrderCommand {
  readonly customerId: string;
  readonly items: readonly { readonly productId: string; readonly quantity: number }[];
}
export interface CreateOrderResult { readonly orderId: string; readonly totalCents: number; readonly currency: string; }
```

```ts
// src/modules/orders/application/services/create-order.service.ts
// Orquestra; NÃO decide regra de negócio, NÃO conhece tecnologia.
import { Money } from '../../../../shared-kernel/domain/money';
import type { UnitOfWork } from '../../../../shared-kernel/application/unit-of-work';
import { Order } from '../../domain/model/order';
import { ProductNotFoundError } from '../../domain/errors/product-not-found.error';
import type { CreateOrderUseCase } from '../ports/in/create-order.use-case';
import type { CreateOrderCommand } from '../commands/create-order.command';
import type { CreateOrderResult } from '../results/create-order.result';
import type { OrderRepository } from '../ports/out/order.repository';
import type { CatalogPort } from '../ports/out/catalog.port';
import type { OrderEventsPublisher } from '../ports/out/order-events.publisher';

export class CreateOrderService implements CreateOrderUseCase {
  constructor(
    private readonly orders: OrderRepository,
    private readonly catalog: CatalogPort,
    private readonly events: OrderEventsPublisher,
    private readonly uow: UnitOfWork,
  ) {}

  async execute(command: CreateOrderCommand): Promise<CreateOrderResult> {
    const currency = 'BRL';
    const order = Order.create(command.customerId);

    for (const item of command.items) {
      const product = await this.catalog.findSellableProduct(item.productId);
      if (!product) throw new ProductNotFoundError(item.productId);
      order.addItem(product.id, item.quantity, Money.of(product.priceCents, product.currency)); // regra: domínio
    }
    order.confirm();

    await this.uow.run(async () => { await this.orders.save(order); });

    for (const e of order.pullEvents()) {
      await this.events.publish({
        eventId: e.eventId, eventType: e.eventType, occurredAt: e.occurredAt, version: 1,
        payload: { orderId: order.id, items: order.snapshot().items.map(i => ({ productId: i.productId, quantity: i.quantity })) },
      });
    }
    const total = order.total(currency);
    return { orderId: order.id, totalCents: total.cents, currency };
  }
}
```

```ts
// src/modules/orders/application/facade/orders.facade.ts — implementa o contrato público (api/)
import type { OrdersApi, OrderSummary } from '../../api';
import type { OrderRepository } from '../ports/out/order.repository';

export class OrdersFacade implements OrdersApi {
  constructor(private readonly orders: OrderRepository) {}

  async getSummary(orderId: string): Promise<OrderSummary | undefined> {
    const order = await this.orders.findById(orderId);
    if (!order) return undefined;
    const { status } = order.snapshot();
    return { id: order.id, status, totalCents: order.total('BRL').cents };   // DTO simples, nunca a entidade
  }
}
```

> **Teste unitário sem framework:** `new CreateOrderService(new InMemoryOrderRepository(), fakeCatalog, fakeEvents, { run: (w) => w() })`. Os fakes implementam as portas de saída.

### 6.4 api (contrato público)

```ts
// src/modules/orders/api/orders.api.ts — o que OUTROS módulos podem chamar
export interface OrderSummary { readonly id: string; readonly status: string; readonly totalCents: number; }
export interface OrdersApi { getSummary(orderId: string): Promise<OrderSummary | undefined>; }
```

```ts
// src/modules/orders/api/events.ts — eventos publicados (contrato; versionar com cuidado)
export const ORDER_CONFIRMED = 'ORDER_CONFIRMED';
export interface OrderConfirmedPayload {
  readonly orderId: string;
  readonly items: readonly { readonly productId: string; readonly quantity: number }[];
}
```

```ts
// src/modules/orders/api/index.ts — único ponto de entrada para outros módulos
export type { OrdersApi, OrderSummary } from './orders.api';
export { ORDER_CONFIRMED } from './events';
export type { OrderConfirmedPayload } from './events';
```

**Regras do `api/`:** só interfaces, tipos e constantes; **nunca** entidade de domínio; mudar algo aqui é mudar contrato.

### 6.5 adapters de entrada (HTTP)

```ts
// src/modules/orders/adapters/in/http/orders.controller.ts
// Fino: valida formato, monta o Command, chama a PORTA e traduz o Result. Sem regra de negócio.
import type { CreateOrderUseCase } from '../../../application/ports/in/create-order.use-case';

export interface HttpRequest { body: unknown; requestId: string; }
export interface HttpResponse { status: number; body: unknown; }

export class OrdersController {
  constructor(private readonly createOrder: CreateOrderUseCase) {}   // depende da PORTA, não do Service

  async create(req: HttpRequest): Promise<HttpResponse> {
    const input = parseCreateOrderBody(req.body);                     // validação de FORMATO (400)
    const result = await this.createOrder.execute(input);
    return {
      status: 201,
      body: { data: result, meta: { timestamp: new Date().toISOString(), requestId: req.requestId } },
    };
  }
}
// parseCreateOrderBody: valida com a lib declarada no plan.md (ou manualmente) e lança ValidationError (400).
```

```ts
// src/modules/orders/adapters/in/http/error-mapper.ts — DomainError → envelope de erro ([[rest-api]])
import { DomainError } from '../../../../../shared-kernel/domain/domain-error';

const STATUS: Record<DomainError['kind'], number> = { invalid: 400, forbidden: 403, not_found: 404, conflict: 409 };

export function toErrorResponse(err: unknown, requestId: string): { status: number; body: unknown } {
  const meta = { timestamp: new Date().toISOString(), requestId };
  if (err instanceof DomainError) {
    return { status: STATUS[err.kind], body: { error: { code: err.code, message: err.message }, meta } };
  }
  // erro inesperado: nunca vaza detalhe interno
  return { status: 500, body: { error: { code: 'INTERNAL_ERROR', message: 'Erro interno' }, meta } };
}
```

A ligação com `httpFramework` (Fastify/Express) é **uma linha por rota** no `orders.module.ts`: o framework chama `controller.create(...)` e escreve o `HttpResponse`. O controller não importa o framework.

### 6.6 adapters de saída

```ts
// src/modules/orders/adapters/out/persistence/order.mapper.ts — domínio ↔ linha do banco
import { Order } from '../../../domain/model/order';
import { Money } from '../../../../../shared-kernel/domain/money';
import type { OrderItem, OrderStatus } from '../../../domain/model/order';

export interface OrderRow { id: string; customer_id: string; status: OrderStatus; currency: string; }
export interface OrderItemRow { order_id: string; product_id: string; quantity: number; unit_price_cents: number; }

export function toDomain(row: OrderRow, items: OrderItemRow[]): Order {
  const mapped: OrderItem[] = items.map(i => ({
    productId: i.product_id, quantity: i.quantity, unitPrice: Money.of(i.unit_price_cents, row.currency),
  }));
  return Order.restore(row.id, row.customer_id, mapped, row.status);
}
```

```ts
// src/modules/orders/adapters/out/persistence/order.repository.sql.ts — IMPLEMENTA a porta
import type { SqlClient } from '../../../../../shared-kernel/persistence/sql-client';
import type { OrderRepository } from '../../../application/ports/out/order.repository';
import type { Order } from '../../../domain/model/order';
import { toDomain, type OrderItemRow, type OrderRow } from './order.mapper';

export class SqlOrderRepository implements OrderRepository {
  constructor(private readonly sql: SqlClient) {}

  async save(order: Order): Promise<void> {
    const { items, status } = order.snapshot();
    await this.sql.query(
      `INSERT INTO orders.orders (id, customer_id, status, currency) VALUES ($1,$2,$3,$4)
       ON CONFLICT (id) DO UPDATE SET status = EXCLUDED.status`,
      [order.id, order.customerId, status, items[0]?.unitPrice.currency ?? 'BRL'],
    );
    for (const i of items) {
      await this.sql.query(
        `INSERT INTO orders.order_items (order_id, product_id, quantity, unit_price_cents)
         VALUES ($1,$2,$3,$4) ON CONFLICT (order_id, product_id) DO NOTHING`,
        [order.id, i.productId, i.quantity, i.unitPrice.cents],
      );
    }
  }

  async findById(id: string): Promise<Order | undefined> {
    const [row] = await this.sql.query<OrderRow>(`SELECT * FROM orders.orders WHERE id = $1`, [id]);
    if (!row) return undefined;
    const items = await this.sql.query<OrderItemRow>(`SELECT * FROM orders.order_items WHERE order_id = $1`, [id]);
    return toDomain(row, items);
  }
}
```

```ts
// src/modules/orders/adapters/out/catalog/catalog.acl.adapter.ts
// ACL: traduz o modelo do catalog para o modelo de orders. Usa SÓ o api/ do outro módulo.
import type { CatalogApi } from '../../../../catalog/api';
import type { CatalogPort, SellableProduct } from '../../../application/ports/out/catalog.port';

export class CatalogAclAdapter implements CatalogPort {
  constructor(private readonly catalog: CatalogApi) {}

  async findSellableProduct(productId: string): Promise<SellableProduct | undefined> {
    const p = await this.catalog.getProduct(productId);          // tipo do OUTRO contexto
    if (!p || !p.available) return undefined;
    return { id: p.id, priceCents: p.priceCents, currency: p.currency }; // modelo de orders
  }
}
```

```ts
// src/modules/orders/adapters/out/events/order-events.bus.publisher.ts
import type { EventBus, IntegrationEvent } from '../../../../../shared-kernel/events/event-bus';
import type { OrderEventsPublisher } from '../../../application/ports/out/order-events.publisher';

export class BusOrderEventsPublisher implements OrderEventsPublisher {
  constructor(private readonly bus: EventBus) {}
  publish(event: IntegrationEvent): Promise<void> { return this.bus.publish(event); }
}
```

**Adapter de entrada por evento** (em `catalog`, reagindo a `ORDER_CONFIRMED`):

```ts
// src/modules/catalog/adapters/in/events/order-confirmed.subscriber.ts
import { ORDER_CONFIRMED, type OrderConfirmedPayload } from '../../../../orders/api';   // só o api/
import type { EventBus } from '../../../../../shared-kernel/events/event-bus';
import type { ReduceStockUseCase } from '../../../application/ports/in/reduce-stock.use-case';

export function subscribeOrderConfirmed(bus: EventBus, reduceStock: ReduceStockUseCase): void {
  bus.subscribe(ORDER_CONFIRMED, async (event) => {
    const { items } = event.payload as OrderConfirmedPayload;
    for (const i of items) await reduceStock.execute({ productId: i.productId, quantity: i.quantity });
  });
}
```

### 6.7 composition root do módulo e bootstrap

```ts
// src/modules/orders/orders.module.ts — monta use cases e adapters; é o ÚNICO lugar que liga as camadas
import type { CatalogApi } from '../catalog/api';
import type { OrdersApi } from './api';
import type { EventBus } from '../../shared-kernel/events/event-bus';
import type { SqlClient } from '../../shared-kernel/persistence/sql-client';
import type { UnitOfWork } from '../../shared-kernel/application/unit-of-work';
import { CreateOrderService } from './application/services/create-order.service';
import { OrdersFacade } from './application/facade/orders.facade';
import { SqlOrderRepository } from './adapters/out/persistence/order.repository.sql';
import { CatalogAclAdapter } from './adapters/out/catalog/catalog.acl.adapter';
import { BusOrderEventsPublisher } from './adapters/out/events/order-events.bus.publisher';
import { OrdersController } from './adapters/in/http/orders.controller';

export interface OrdersModuleDeps {
  sql: SqlClient; uow: UnitOfWork; eventBus: EventBus; catalogApi: CatalogApi;
}
export interface OrdersModule { api: OrdersApi; controller: OrdersController; }

export function createOrdersModule(deps: OrdersModuleDeps): OrdersModule {
  const repository = new SqlOrderRepository(deps.sql);
  const createOrder = new CreateOrderService(
    repository, new CatalogAclAdapter(deps.catalogApi), new BusOrderEventsPublisher(deps.eventBus), deps.uow,
  );
  return { api: new OrdersFacade(repository), controller: new OrdersController(createOrder) };
}
```

```ts
// src/bootstrap/app.ts — instancia na ORDEM das dependências (catalog antes de orders)
export function buildApp(infra: Infra) {
  const catalog = createCatalogModule({ sql: infra.sql, uow: infra.uow, eventBus: infra.eventBus });
  const orders = createOrdersModule({ sql: infra.sql, uow: infra.uow, eventBus: infra.eventBus, catalogApi: catalog.api });
  return { catalog, orders };
}
```

> Adicionar um módulo = criar `<m>.module.ts` + uma linha em `buildApp`. Remover = apagar a linha.

---

## 7. Comunicação entre módulos

| Situação | Mecanismo |
|---|---|
| Preciso do dado agora (preço, estoque) | `api/` do outro módulo, consumido por **adapter de saída com ACL** |
| Aviso de que algo aconteceu | integration event no `EventBus` (contrato em `api/events.ts`) |
| Efeito que **não pode ser perdido** | Outbox: grava o evento na mesma transação e publica depois |
| Preciso de consistência forte entre dois contextos | reavalie: provavelmente são o mesmo contexto |

**Proibido:** importar `domain`/`application`/`adapters` de outro módulo; JOIN ou FK entre dados de módulos; ler a tabela do vizinho; entidade de domínio dentro de evento ou `api`; dois módulos compartilhando o mesmo modelo de persistência.

---

## 8. Banco de dados

Segue [[modular-monolith]]: cada módulo só toca nos **seus** dados; sem FK entre módulos.

- Com PostgreSQL: **um schema por módulo** (`orders.orders`, `catalog.products`). Sem suporte a schema: prefixo na tabela (`orders_orders`).
- Referência a outro módulo = só o **id** (`product_id`), sem FK.
- Migrations versionadas, automatizadas no pipeline, **nunca editadas** depois de aplicadas em produção. Ficam em `adapters/out/persistence/migrations/` do módulo, com nome `YYYYMMDDHHmm_descricao.sql` (o timestamp evita colisão entre módulos).
- Em `single-service`, o serviço é dono do seu banco (como em [[microservice]]).

---

## 9. Tratamento de erros

- Regra de negócio violada → `DomainError` (com `code` e `kind`) → `error-mapper` → envelope de erro ([[rest-api]]).
- Erro de formato → 400 com `details` por campo, no adapter de entrada.
- Erro inesperado → 500 genérico, log `error` com `stack` e **sem payload** ([[observability]]).
- `error` apenas para falha que exige atenção humana; erro de negócio esperado não é `error`.

---

## 10. Configuração de arquitetura

A configuração de projeto (package.json, tsconfig, ESLint, Vitest, env, health, CI) está em [[typescript-baseline]]. Aqui está o que é **específico** do hexagonal.

### 10.1 `.dependency-cruiser.cjs` (o guardião da arquitetura)

```js
/** @type {import('dependency-cruiser').IConfiguration} */
const NPM = ['npm', 'npm-dev', 'npm-optional', 'npm-peer', 'npm-bundled', 'npm-no-pkg', 'npm-unknown'];

module.exports = {
  forbidden: [
    { name: 'no-circular', severity: 'error', from: {}, to: { circular: true } },

    // REGRA 1 — dentro do módulo
    { name: 'domain-depends-on-nothing', severity: 'error',
      comment: 'domain só importa o próprio domain e o shared-kernel',
      from: { path: '^src/modules/([^/]+)/domain' },
      to: { path: '^src', pathNot: ['^src/modules/$1/domain', '^src/shared-kernel'] } },
    { name: 'domain-no-npm', severity: 'error',
      from: { path: '^src/modules/[^/]+/domain' }, to: { dependencyTypes: NPM } },
    { name: 'application-no-adapters', severity: 'error',
      from: { path: '^src/modules/([^/]+)/application' },
      to: { path: '^src/modules/$1/adapters' } },
    { name: 'application-no-npm', severity: 'error',
      from: { path: '^src/modules/[^/]+/application' }, to: { dependencyTypes: NPM } },
    { name: 'adapters-in-not-out', severity: 'error',
      from: { path: '^src/modules/[^/]+/adapters/in' }, to: { path: '^src/modules/[^/]+/adapters/out' } },
    { name: 'adapters-out-not-in', severity: 'error',
      from: { path: '^src/modules/[^/]+/adapters/out' }, to: { path: '^src/modules/[^/]+/adapters/in' } },
    { name: 'adapters-in-not-domain', severity: 'error',
      comment: 'entrada fala com a porta, nunca com o domínio direto',
      from: { path: '^src/modules/[^/]+/adapters/in' }, to: { path: '^src/modules/[^/]+/domain' } },

    // REGRA 2 — entre módulos: só o api/ do vizinho
    { name: 'modules-only-through-api', severity: 'error',
      from: { path: '^src/modules/([^/]+)/' },
      to: { path: '^src/modules/[^/]+/', pathNot: ['^src/modules/$1/', '^src/modules/[^/]+/api/'] } },
    { name: 'api-is-contract-only', severity: 'error',
      from: { path: '^src/modules/[^/]+/api' },
      to: { path: '^src/modules/[^/]+/(domain|application|adapters)' } },
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
      comment: 'bootstrap liga módulos pelo *.module.ts e pelo api/, não pelas camadas internas',
      from: { path: '^src/bootstrap' },
      to: { path: '^src/modules/[^/]+/(domain|application|adapters)' } },
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

> **`node:crypto` e outros módulos nativos** não contam como `npm` (tipo `core`), por isso o domínio pode usar `node:crypto`. Qualquer pacote de `node_modules` no domínio, na aplicação, no `api` ou no kernel **falha o build**.
> **Importante:** as regras são genéricas (por regex) e valem para **qualquer módulo novo sem editar o arquivo**.

> **Falso-verde:** o `arch` só vale se o cruiser realmente lê o TypeScript. Use `typescript@~5.9` e o `scripts/arch-sanity.cjs` do [[typescript-baseline]]; sem eles, TS 7 resulta em "0 módulos analisados" e passa sem checar nada.

### 10.2 Teste que prova que a regra funciona

Um repo só está "protegido" se a violação **realmente falha**. Crie `tests/architecture/arch-rules.test.ts` que roda o cruiser em uma fixture com violação conhecida (ou, mais simples no SCAFFOLD, faça a verificação manual da §11, passo 11, e registre o resultado).

---

## 11. Modo SCAFFOLD (criar o projeto)

Pré-condições: parâmetros da §3 preenchidos; pasta do repo vazia ou nova; `plan.md` com as libs.

1. Criar a árvore da §4 com `{{module}}` para cada módulo (pastas vazias recebem `.gitkeep`).
2. Gerar os arquivos de [[typescript-baseline]]: `package.json`, `tsconfig*.json`, `eslint.config.js`, `vitest.config.ts`, `.env.example`, `.gitignore` (inclui `.env`, `dist`, `coverage`, `node_modules`), `bootstrap/config.ts`, `bootstrap/health.ts`, `bootstrap/in-memory-event-bus.ts`.
3. Gerar o `shared-kernel` (§6.1 e portas técnicas do baseline §6.1).
4. Gerar `.dependency-cruiser.cjs` (§10.1).
5. Para cada módulo, gerar **um caso de uso completo ponta a ponta** (a "fatia vertical"): domain (aggregate + erro), application (porta in/out, command/result, service), adapters (controller + mapper de erro, repositório + mapper, publisher), `api/`, `<m>.module.ts`, migration inicial, testes.
6. Gerar `bootstrap/app.ts` e `main.ts` (carrega config, cria infra com as libs do `plan.md`, `buildApp`, sobe o HTTP com `GET /health`).
7. Instalar **somente** as dependências declaradas (`npm install` com as libs do plan + devDeps do baseline).
8. Escrever os testes: domínio puro, use case com fakes, adapter (integração com banco real ou container, conforme [[testing]]).
9. Escrever `README.md` e `.env.example`.
10. Rodar `npm run verify`. Corrigir até ficar verde.
11. **Prova de proteção:** adicionar temporariamente `import { Pool } from 'pg'` (ou qualquer lib) em um arquivo de `domain/`, rodar `npm run arch`, confirmar que **falha**, e remover. Repetir com um import de `../../other/domain/...` entre módulos. Registrar no relatório.
12. Relatar: o que foi criado, resultado do `verify`, o que ficou como `[NEEDS CLARIFICATION]`. **Não commitar.**

---

## 12. Outros modos

### 12.1 `ADD-MODULE` (novo bounded context)

1. Confirmar nome (`kebab-case`, inglês) e responsabilidade em 1 frase. Se o nome precisa de "e" para ser descrito, dividir.
2. Criar `src/modules/{{module}}/` com a árvore da §4 (as regras do cruiser já cobrem o módulo novo).
3. Criar `api/` primeiro (o contrato), depois `domain`, `application`, `adapters`, `{{module}}.module.ts`.
4. Registrar em `bootstrap/app.ts` respeitando a ordem das dependências.
5. Criar o schema/prefixo e a migration do módulo (§8). **Nenhuma FK** para outro módulo.
6. Se precisa de outro módulo: criar a **porta de saída** + `adapters/out/<outro>/` com ACL, usando só o `api/` dele. Se precisa reagir a evento: `adapters/in/events/`.
7. Testes das 3 camadas + `npm run verify`. Atualizar o README (lista de módulos); decisão nova de fronteira vai em Decisões no `plan.md` do SDD.

### 12.2 `ADD-USE-CASE`

1. Command e Result (`application/commands|results`).
2. **Porta de entrada** `ports/in/<verb-noun>.use-case.ts` (um por intenção; porta com dezenas de métodos é anti-padrão).
3. Portas de saída novas, **só se** o caso de uso exige algo ainda não coberto.
4. Regra de negócio no `domain` (método do aggregate, service ou specification), **com teste primeiro**.
5. `application/services/<verb-noun>.service.ts` que orquestra.
6. Adapter de entrada (rota/controller) e adapter de saída novo, se houver porta nova.
7. Ligar em `<m>.module.ts`. `npm run verify`.

---

## 13. Checklist de conformidade (códigos H-xx)

Usado no AUDIT e na revisão de PR. Severidade: **B** = bloqueante, **M** = maior, **m** = menor.

| ID | Verificação | Como checar | Sev |
|---|---|---|---|
| H-01 | `domain` sem import de npm/framework | `npm run arch` (regra `domain-no-npm`) | B |
| H-02 | `domain` não importa application/adapters/outro módulo | `npm run arch` | B |
| H-03 | `application` sem import de adapters nem npm | `npm run arch` | B |
| H-04 | `adapters/in` não importa `adapters/out` (e vice-versa) | `npm run arch` | B |
| H-05 | Módulo só importa o `api/` de outro | `npm run arch` (`modules-only-through-api`) | B |
| H-06 | Sem ciclos | `npm run arch` (`no-circular`) | B |
| H-07 | Toda saída (banco, HTTP, fila, outro módulo) passa por porta de saída | revisão: `grep -rnE "from '(pg|axios|node-fetch|ioredis)" src/modules/*/(domain\|application)` vazio | B |
| H-08 | Controllers sem `if` de regra de negócio e sem `setX`/mutação de aggregate | revisão de `adapters/in` | M |
| H-09 | Application sem cálculo de negócio (percentuais, faixas, fórmulas) | revisão de `application/services` | M |
| H-10 | Adapter de saída não decide fluxo (não chama outro serviço por condição de negócio) | revisão de `adapters/out` | M |
| H-11 | Aggregate sem setters públicos; muda estado por método de negócio | `grep -rnE "^\s*set [a-z]" src/modules/*/domain` | M |
| H-12 | Domínio ≠ modelo de persistência (existe mapper) | existência de `*.mapper.ts` por repositório | M |
| H-13 | Dinheiro não é `number`/`float` | `grep -rnE "(price|amount|total)\w*: number" src/modules/*/domain` revisado | M |
| H-14 | Cada porta de entrada = uma intenção; sem "SystemService" gigante | revisão | m |
| H-15 | Schema/prefixo por módulo; sem FK/JOIN entre módulos | revisão de migrations | B |
| H-16 | `process.env` só em `bootstrap/config.ts` | ESLint (`no-restricted-syntax`) | M |
| H-17 | `GET /health` no formato da [[observability]] | teste de integração | M |
| H-18 | Sem `console.*`, sem `any` sem justificativa | `npm run lint` | M |
| H-19 | Cobertura ≥ 80% | `npm run test:cov` | M |
| H-20 | `npm audit` sem alta/crítica | `npm run audit` | B |
| H-21 | README e `.env.example` | existência | m |
| H-22 | Composition root em `<m>.module.ts`; `bootstrap` não importa camadas internas | `npm run arch` | M |

---

## 14. Modo AUDIT (conferir e ajustar **qualquer** repo)

Objetivo: dizer, com evidência, **quão aderente** o repo está e levar a aderência a 100% **sem big-bang**.

**Regra:** AUDIT é **somente leitura** até o humano aprovar o plano. Ajuste é feito por task de SDD (fluxo do workspace: Gate 2 antes de implementar).

### 14.1 Passo 1: diagnóstico

1. Identificar o repo: `package.json` (scripts, deps), árvore de `src/`, `AGENTS.md`, `sdd/`.
2. Classificar o layout atual:

| Layout | Sinais | Caminho |
|---|---|---|
| **A. Em camadas/MVC** | `controllers/ services/ models/` | migrar por caso de uso (§14.3) |
| **B. Parcialmente hexagonal** | já há `domain/` e `ports`, mas com vazamentos | corrigir violações (§14.2) |
| **C. Hexagonal conforme** | estrutura da §4 | só fechar lacunas de configuração |
| **D. Sem estrutura** | tudo misturado | tratar como A, começando pelo contexto mais rico |

3. Instalar/rodar a verificação **sem alterar o código**: copiar `.dependency-cruiser.cjs` (§10.1) em modo `severity: 'warn'` e rodar `npx depcruise src --config .dependency-cruiser.cjs`. Anotar as violações por regra.
4. Rodar `npm run verify` (ou o que existir) e anotar o que não passa.
5. Executar as checagens H-xx da §13 e preencher a tabela.

### 14.2 Passo 2: relatório (formato obrigatório)

```markdown
# Auditoria Hexagonal — {{repo}} — {{data}}
Layout detectado: A | B | C | D
Aderência: {{n}}/22 verificações H-xx aprovadas  · bloqueantes abertos: {{n}}

| ID | Resultado | Evidência (arquivo:linha ou comando) | Severidade | Esforço |
|----|-----------|--------------------------------------|------------|---------|
| H-01 | ❌ | src/domain/user.ts:3 importa `typeorm` | B | S |
| ... |

## Violações por regra do cruiser
{{regra}} → {{n}} ocorrências (lista dos 5 piores arquivos)

## Plano de ajuste (ordenado, uma task por PR)
1. ...
## Não verificado / precisa de decisão humana
- ...
```

Regras do relatório: **cite evidência** (arquivo e linha ou saída do comando). O que não foi possível verificar vai em "Não verificado"; nunca marcar ✅ por suposição.

### 14.3 Passo 3: ajuste incremental (depois da aprovação)

Ordem fixa, cada item é uma task pequena e testável (INVEST):

1. **Ferramentas primeiro, sem mudar comportamento:** adicionar o baseline (scripts, ESLint, tsconfig strict por etapas se necessário, Vitest) e o cruiser.
2. **Congelar a dívida:** gerar o baseline de violações conhecidas e **impedir que cresçam**:
   ```bash
   npx depcruise src --config .dependency-cruiser.cjs --output-type baseline > .dependency-cruiser-known-violations.json
   ```
   Passar a rodar `arch` com `--ignore-known .dependency-cruiser-known-violations.json`. Daí em diante, **violação nova falha**; a antiga vai sendo paga.
3. **Criar a estrutura do módulo** (§4) sem mover nada ainda.
4. **Migrar por caso de uso** (strangler), do mais rico em regra para o mais simples:
   a. escrever teste de caracterização do comportamento atual;
   b. extrair a regra para o `domain` (aggregate/service);
   c. criar porta de entrada e de saída; `application/service` orquestra;
   d. mover acesso a banco/API para `adapters/out` com mapper;
   e. controller antigo passa a chamar a porta;
   f. remover do known-violations o que foi pago; `verify` verde.
5. **Fechar fronteiras entre módulos:** criar `api/` por módulo, trocar imports diretos por `api/` + ACL, separar dados (§8).
6. **Documentação:** README e `.env.example`.
7. Quando `known-violations` estiver vazio, apagar o arquivo e deixar `severity: 'error'` sem exceção.

**Nunca:** reescrever o repo inteiro de uma vez; mexer em regra de negócio ao mover código (mover e mudar comportamento são PRs separados); mudar contrato HTTP público sem task explícita.

### 14.4 Anti-padrões e como corrigir

| Anti-padrão | Detecção | Correção |
|---|---|---|
| Entidade de domínio com decorator/ORM (`@Entity`) | import de ORM em `domain` (H-01) | classe de domínio pura + `*.mapper.ts` + modelo de persistência no adapter |
| Domain service chamando API externa | `fetch/axios` em `domain` (H-01/H-07) | porta de saída + adapter |
| Controller com `if` de negócio ou mutação de estado | H-08 | mover para método do aggregate; controller só chama a porta |
| Application service com cálculo de negócio | H-09 | mover para aggregate/domain service |
| Adapter decidindo fluxo (ex.: repositório dispara e-mail) | H-10 | decisão sobe para `application`; adapter só persiste |
| Módulo importando internals do vizinho | H-05 | `api/` + ACL |
| "SystemService" com dezenas de métodos | H-14 | dividir em portas coesas, uma por intenção |
| Modelo do vizinho vazando para o seu domínio | tipos do `api/` alheio usados em `domain` | ACL traduz para tipos próprios |

---

## 15. Definition of Done (qualquer modo)

- [ ] `npm run verify` verde (lint, tipos, arch, testes 80%, audit) e **resultado colado no relatório**
- [ ] Prova de proteção feita (§11 passo 11) quando for SCAFFOLD/ADD-MODULE
- [ ] Nenhuma lib fora do `plan.md`; nenhum segredo; `.env` não versionado
- [ ] README atualizado
- [ ] Dúvidas de negócio ficaram como `[NEEDS CLARIFICATION]`, não inventadas
- [ ] Nada commitado sem pedido

---

## 16. Evolução para microserviço

Extrair o módulo `catalog`: o `CatalogAclAdapter` passa a chamar HTTP em vez do `api/` in-process; o assinante de evento troca o `InMemoryEventBus` pela fila; o schema vira banco próprio. **Não mudam** `domain` nem `application` de nenhum dos dois lados. O novo serviço segue [[microservice]] e mantém a mesma estrutura de hexágono.
