# Pattern: Modular Monolith

> Políticas específicas para arquitetura de monolito modular. Em um SDD completo seria dividido em: `modules.md`, `boundaries.md`, `shared-kernel.md`, `events.md`, `deployment.md` Consolidado aqui por ser ambiente de teste.

---

## Referências

<!-- LINK AQUI: a constituição define as regras universais que este pattern estende. Tudo que está na constituição se aplica aqui — este arquivo só adiciona o que é específico da arquitetura de monolito modular. -->

- [[constitution]]

---

## Princípio fundamental

Um monolito modular é deployado como uma unidade, mas organizado internamente como se fossem serviços independentes. Módulos não se chamam diretamente — se comunicam via interfaces públicas ou eventos internos.

A fronteira do módulo é tão importante quanto em microserviços. A diferença é que o isolamento é por código, não por rede.

---

## Estrutura de pastas obrigatória

```
app-name/
├── src/
│   ├── modules/
│   │   ├── payments/
│   │   │   ├── application/     ← casos de uso do módulo
│   │   │   ├── domain/          ← entidades e regras internas
│   │   │   ├── infrastructure/  ← banco, serviços externos
│   │   │   ├── interface/       ← controllers e event handlers
│   │   │   └── index.ts         ← API pública do módulo (único ponto de saída)
│   │   ├── users/
│   │   │   └── index.ts
│   │   └── notifications/
│   │       └── index.ts
│   ├── shared/
│   │   ├── kernel/              ← tipos e utilitários usados por todos os módulos
│   │   └── events/              ← contratos de eventos internos
│   └── main.ts                  ← bootstrap da aplicação
├── tests/
│   ├── unit/
│   └── integration/
├── docs/
│   └── adr/
└── README.md
```

---

## Fronteiras de módulo — regra crítica

Cada módulo expõe apenas o que está no seu `index.ts`. Importar de dentro do módulo diretamente é proibido.

```typescript
// ✅ Correto — usa a API pública do módulo
import { PaymentService } from '@modules/payments'

// ❌ Errado — viola a fronteira do módulo
import { PaymentRepository } from '@modules/payments/infrastructure/PaymentRepository'
```

---

## Comunicação entre módulos

**Via interface pública (`index.ts`):** para queries síncronas

**Via eventos internos:** para comandos e reações

```typescript
// Evento interno
interface InternalEvent {
  type: string        // PAYMENT_COMPLETED
  payload: object
  occurredAt: Date
}

// Módulo publica, outro módulo escuta
eventBus.publish({ type: 'PAYMENT_COMPLETED', payload: { orderId } })
eventBus.subscribe('PAYMENT_COMPLETED', NotificationHandler)
```

Módulos nunca acessam o banco um do outro — mesmo sendo um único banco físico, cada módulo usa apenas suas próprias tabelas.

---

## Shared Kernel

Contém apenas o que é verdadeiramente compartilhado:

- Tipos base: `Id`, `Timestamp`, `Money`
- Erros base: `AppError`, `NotFoundError`
- Utilitários sem estado: formatters, validators genéricos

Não adicionar lógica de negócio no shared kernel. Se um tipo parece necessário em dois módulos, é sinal de que pode ser um módulo próprio.

---

## Banco de dados

- Tabelas de módulos diferentes com prefixo do módulo: `payments_transactions`, `users_accounts`
- Nenhuma foreign key entre tabelas de módulos diferentes
- Consistência entre módulos via eventos, não via joins
- Um schema por módulo se o banco suportar

---

## Deploy

- Deployado como uma única unidade
- Pipeline único com testes de todos os módulos
- Feature flags para habilitar/desabilitar módulos em runtime
- Quando um módulo crescer o suficiente: extrair para microserviço sem reescrever — a fronteira já existe