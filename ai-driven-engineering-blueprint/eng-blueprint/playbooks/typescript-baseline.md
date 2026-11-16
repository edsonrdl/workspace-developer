---
name: typescript-baseline
description: Configuração base e comum a todo projeto TypeScript/Node desta empresa (package.json, tsconfig, ESLint, testes, validação de env, health, logger, CI). Lido junto com um playbook de arquitetura (hexagonal, clean-architecture).
status: proposto
applies_to: [hexagonal, clean-architecture]
---

# Pattern: TypeScript Baseline (configuração base de projeto)


> Este arquivo existe para que os playbooks de arquitetura **não repitam** a configuração de projeto. Os playbooks [[hexagonal]] e [[clean-architecture]] dizem *onde o código mora*. Este diz *como o projeto é configurado*. Um agente que for criar ou ajustar um repo lê **os dois**.

---

## Referências

- [[constitution]] tem prioridade sobre este arquivo
- [[stack]] (TypeScript strict, Node LTS, AWS), [[quality]] (lint, 80% de cobertura), [[testing]], [[security]], [[observability]]

---

## 1. O que este arquivo decide e o que ele deixa para o `sdd/plan.md`

A constituição aprova a linguagem, o runtime e a cloud, mas **não** escolhe bibliotecas. Biblioteca nova de infraestrutura exige decisão registrada no `plan.md`. Por isso o agente **nunca escolhe sozinho** os itens abaixo: lê no `sdd/plan.md` (ou no `package.json` do repo existente) e, se faltar, **pergunta** antes de instalar.

| Decisão aberta | Onde fica declarada | Sugestão (só se o humano aceitar) |
|---|---|---|
| Framework HTTP | `sdd/plan.md` | Fastify ou Express |
| Test runner | `sdd/plan.md` | Vitest (Jest se o repo já usa) |
| Acesso a banco | `sdd/plan.md` | driver do banco ou ORM já usado no repo |
| Logger | `sdd/plan.md` ([[observability]]) | Pino |
| Tracing | `sdd/plan.md` | OpenTelemetry |
| Event bus entre módulos | `sdd/plan.md` | o `InMemoryEventBus` deste playbook (sem lib) |
| IaC | `sdd/plan.md` ([[stack]]) | Terraform ou CDK |
| Verificador de arquitetura | `sdd/plan.md` | dependency-cruiser |

**Já decidido por este baseline (não perguntar):** npm como gerenciador (a [[quality]] usa `npm run lint`), TypeScript strict, ESLint, cobertura 80%, `npm audit`, validação de variáveis de ambiente no boot, `GET /health`, nomes de código em inglês.

---

## 2. Scripts obrigatórios (`package.json`)

```json
{
  "name": "{{service-name}}",
  "version": "0.1.0",
  "private": true,
  "engines": { "node": ">=22" },
  "scripts": {
    "build": "tsc -p tsconfig.build.json",
    "typecheck": "tsc --noEmit",
    "lint": "eslint .",
    "test": "vitest run",
    "test:cov": "vitest run --coverage",
    "arch": "depcruise src --config .dependency-cruiser.cjs && node scripts/arch-sanity.cjs",
    "audit": "npm audit --audit-level=high",
    "verify": "npm run lint && npm run typecheck && npm run arch && npm run test:cov && npm run audit"
  }
}
```

- **`typescript` fica em `~5.9`** (menor que 7). Testado: com TypeScript 7 o `dependency-cruiser` ainda não consegue ler os fontes e **passa em silêncio sem analisar nada**. O script `scripts/arch-sanity.cjs` (abaixo) existe para transformar esse falso-verde em erro. Quando o cruiser suportar TS 7, o limite pode subir via ADR.
- `"types": ["node"]` no tsconfig é obrigatório: em TypeScript recente os `@types/*` deixaram de ser carregados automaticamente.
- `engines.node` deve ser o **LTS par vigente** (ver [[stack]]); ajuste o número ao LTS do momento.
- **`npm run verify` é o portão único**: se passa, o repo está de acordo com a [[constitution]] e com o playbook de arquitetura. Todo pipeline de CI roda `verify`. Nenhuma task é "concluída" sem ele verde.
- Se o `sdd/plan.md` declarar outro runner ou verificador, troque só o comando, mantendo o **nome** do script.


**devDependencies de tooling** (versões testadas; o `plan.md` pode trocar o runner/verificador): `typescript@~5.9`, `@types/node` (do LTS), `eslint`, `typescript-eslint`, `vitest`, `@vitest/coverage-v8`, `dependency-cruiser@^18`.

```js
// scripts/arch-sanity.cjs — falha se o verificador de arquitetura não analisou nada
const { execSync } = require('node:child_process');
const out = execSync('npx depcruise src --config .dependency-cruiser.cjs --output-type json', {
  encoding: 'utf8', maxBuffer: 1 << 26,
});
const { summary } = JSON.parse(out);
if (summary.totalCruised < 1) {
  console.error('arch-sanity: 0 módulos analisados. Verifique a versão do TypeScript (<7) e o tsconfig.');
  process.exit(1);
}
console.log(`arch-sanity: ${summary.totalCruised} módulos analisados, ${summary.error} erros.`);
```

---

## 3. `tsconfig.json` (strict obrigatório)

```jsonc
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "Node16",
    "moduleResolution": "Node16",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitOverride": true,
    "noFallthroughCasesInSwitch": true,
    "forceConsistentCasingInFileNames": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "outDir": "dist",
    "rootDir": "src",
    "sourceMap": true,
    "types": ["node"]
  },
  "include": ["src"]
}
```

```jsonc
// tsconfig.build.json — não compila testes
{
  "extends": "./tsconfig.json",
  "exclude": ["src/**/*.test.ts", "src/**/*.spec.ts", "tests"]
}
```

**Convenção de imports:** caminhos **relativos**. Imports entre módulos de negócio vão **sempre** para o `api` do outro módulo (`../../catalog/api`). Alias (`paths`) só se o `plan.md` declarar um bundler ou o runner que o resolva; alias sem resolução em runtime quebra o build.

---

## 4. ESLint (`eslint.config.js`, flat config)

```js
// eslint.config.js — regras da constitution ([[quality]]) + defesa extra de arquitetura
const tseslint = require('typescript-eslint');

module.exports = tseslint.config(
  // arquivos de configuração e scripts não fazem parte do tsconfig: ficam fora do lint tipado
  { ignores: ['dist', 'coverage', 'node_modules', '*.config.*', '.dependency-cruiser.cjs', 'scripts'] },
  ...tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: { parserOptions: { projectService: true } },
    rules: {
      'no-console': 'error',                              // quality: sem console.log; usar logger
      '@typescript-eslint/no-explicit-any': 'error',      // any só com justificativa no próprio eslint-disable
      '@typescript-eslint/consistent-type-imports': 'error',
      '@typescript-eslint/no-floating-promises': 'error',
      'no-restricted-syntax': ['error',
        { selector: "MemberExpression[object.name='process'][property.name='env']",
          message: 'process.env só em src/bootstrap/config.ts (validação no boot).' }],
    },
  },
  {
    // process.env permitido apenas na configuração do bootstrap
    files: ['src/bootstrap/config.ts'],
    rules: { 'no-restricted-syntax': 'off' },
  },
  {
    // testes podem usar console e any controlado
    files: ['**/*.test.ts', 'tests/**'],
    rules: { 'no-console': 'off' },
  },
);
```

> A regra de justificativa do `any` é textual: `// eslint-disable-next-line @typescript-eslint/no-explicit-any -- <motivo>`. Sem motivo, o review rejeita.

---

## 5. Testes e cobertura (`vitest.config.ts`)

```ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    include: ['src/**/*.test.ts', 'tests/**/*.test.ts'],
    coverage: {
      provider: 'v8',
      include: ['src/**/*.ts'],
      exclude: ['src/**/*.test.ts', 'src/bootstrap/main.ts', 'src/**/index.ts'],
      thresholds: { branches: 80, functions: 80, lines: 80, statements: 80 }, // [[quality]]
    },
  },
});
```

- Um projeto pode **elevar** os thresholds no `sdd/requirements.md`, nunca abaixar.
- Testes unitários ficam ao lado do código (`*.test.ts`); integração e e2e em `tests/integration` e `tests/e2e` (ver [[testing]]).

---

## 6. Variáveis de ambiente: validação no boot

Falha explícita se faltar variável ([[security]]). Só este arquivo lê `process.env`.

```ts
// src/bootstrap/config.ts
export interface AppConfig {
  readonly serviceName: string;
  readonly port: number;
  readonly databaseUrl: string;
  readonly logLevel: 'debug' | 'info' | 'warn' | 'error';
}

function required(env: NodeJS.ProcessEnv, name: string): string {
  const value = env[name];
  if (value === undefined || value.trim() === '') {
    throw new Error(`Variável de ambiente obrigatória ausente: ${name}`);
  }
  return value;
}

// Propósito: converte process.env em configuração tipada; falha no boot se algo faltar.
export function loadConfig(env: NodeJS.ProcessEnv): AppConfig {
  const port = Number(env['PORT'] ?? '3000');
  if (!Number.isInteger(port) || port <= 0) throw new Error('PORT inválida');
  const level = (env['LOG_LEVEL'] ?? 'info') as AppConfig['logLevel'];
  return {
    serviceName: required(env, 'SERVICE_NAME'),
    port,
    databaseUrl: required(env, 'DATABASE_URL'),
    logLevel: level,
  };
}
```

`.env.example` (só nomes e descrição, **sem valores reais**; `.env` no `.gitignore`):

```dotenv
# Nome do serviço; aparece em todo log
SERVICE_NAME=
# Porta HTTP (padrão 3000)
PORT=
# Conexão do banco; vem do Parameter Store/Secrets Manager em produção
DATABASE_URL=
# debug | info | warn | error (padrão info)
LOG_LEVEL=
```

---

## 6.1 Portas técnicas mínimas do `shared-kernel`

Contratos sem biblioteca. As implementações ficam nos adapters/bootstrap.

```ts
// src/shared-kernel/observability/logger.ts — port; o adapter usa a lib declarada no plan.md
export interface Logger {
  info(message: string, fields?: Record<string, unknown>): void;
  warn(message: string, fields?: Record<string, unknown>): void;
  error(message: string, fields?: Record<string, unknown>): void;
}
// Todo log carrega timestamp, level, requestId, service e message ([[observability]]).
// Nunca passar payload de request nem dado sensível ([[security]]).
```

```ts
// src/shared-kernel/application/unit-of-work.ts — fronteira transacional
export interface UnitOfWork {
  run<T>(work: () => Promise<T>): Promise<T>;
}
```

```ts
// src/shared-kernel/events/event-bus.ts — contrato de evento entre módulos
// Mesmo formato do playbook [[microservice]]: troca o bus in-process por fila sem mudar o contrato.
export interface IntegrationEvent<T = unknown> {
  readonly eventId: string;       // uuid
  readonly eventType: string;     // SNAKE_CASE: ORDER_CONFIRMED
  readonly occurredAt: string;    // ISO8601
  readonly version: number;       // versão do schema do payload
  readonly payload: T;
}
export type EventHandler = (event: IntegrationEvent) => Promise<void>;

export interface EventBus {
  publish(event: IntegrationEvent): Promise<void>;
  subscribe(eventType: string, handler: EventHandler): void;
}
```

```ts
// src/shared-kernel/persistence/sql-client.ts — contrato mínimo; a lib de banco fica no adapter
export interface SqlClient {
  query<R = Record<string, unknown>>(sql: string, params?: readonly unknown[]): Promise<R[]>;
}
```

```ts
// src/bootstrap/in-memory-event-bus.ts — implementação padrão, sem lib
import type { EventBus, EventHandler, IntegrationEvent } from '../shared-kernel/events/event-bus';
import type { Logger } from '../shared-kernel/observability/logger';

export class InMemoryEventBus implements EventBus {
  private readonly handlers = new Map<string, EventHandler[]>();
  constructor(private readonly logger: Logger) {}

  subscribe(eventType: string, handler: EventHandler): void {
    this.handlers.set(eventType, [...(this.handlers.get(eventType) ?? []), handler]);
  }

  async publish(event: IntegrationEvent): Promise<void> {
    for (const handler of this.handlers.get(event.eventType) ?? []) {
      try {
        await handler(event);
      } catch (err) {
        // erro de um assinante não pode derrubar quem publicou; stack sim, payload nunca ([[observability]])
        this.logger.error('Falha ao tratar evento', {
          eventType: event.eventType, eventId: event.eventId,
          stack: err instanceof Error ? err.stack : undefined,
        });
      }
    }
  }
}
```

---

## 7. Health check (`GET /health`)

Formato fixo da [[observability]]. O bootstrap agrega as verificações de dependência registradas pelos módulos.

```ts
// src/bootstrap/health.ts
export type DependencyStatus = 'healthy' | 'unhealthy';
export interface HealthCheck { readonly name: string; check(): Promise<DependencyStatus>; }

export interface HealthReport {
  status: 'healthy' | 'degraded' | 'unhealthy';
  dependencies: Record<string, DependencyStatus>;
}

// Propósito: roda todas as verificações e deriva o status geral.
// "critical" = dependência sem a qual o serviço não processa requisições.
export async function buildHealthReport(
  checks: readonly (HealthCheck & { readonly critical: boolean })[],
): Promise<HealthReport> {
  const dependencies: Record<string, DependencyStatus> = {};
  let status: HealthReport['status'] = 'healthy';
  for (const c of checks) {
    const result = await c.check().catch((): DependencyStatus => 'unhealthy');
    dependencies[c.name] = result;
    if (result === 'unhealthy') status = c.critical ? 'unhealthy' : (status === 'unhealthy' ? status : 'degraded');
  }
  return { status, dependencies };
}
```

---

## 8. Documentação mínima do repo

- `README.md`: o que é, como rodar, variáveis de ambiente, como testar, como fazer deploy
- `.env.example`

A escolha da arquitetura e as demais decisões ficam em Decisões no `plan.md` do SDD, não em ADR.

---

## 9. CI mínimo

```yaml
# exemplo genérico; adapte ao pipeline da empresa (AWS)
steps:
  - run: npm ci
  - run: npm run verify
```

`verify` quebra o build se: lint falhar, tipos falharem, a arquitetura for violada, a cobertura cair abaixo de 80% ou houver vulnerabilidade alta/crítica.

---

## 10. Regras para o agente

1. Não instalar biblioteca que não esteja declarada no `sdd/plan.md` ou já no `package.json`. Faltou: perguntar.
2. Não editar `package.json`/configs de um repo existente sem que a task do SDD peça.
3. Não commitar nem fazer push sem pedido explícito.
4. Nunca escrever segredo, `.env` real ou credencial.
5. Ao terminar qualquer task, rodar `npm run verify` e relatar o resultado real (se não rodou, dizer que não rodou).
