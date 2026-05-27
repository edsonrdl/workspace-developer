# Pattern: MVC

> Políticas específicas para arquitetura Model-View-Controller. Em um SDD completo seria dividido em: `models.md`, `controllers.md`, `views.md`, `middleware.md`, `routing.md` Consolidado aqui por ser ambiente de teste.
> 
> Estende: [[constitution]]

---

## Princípio fundamental

Cada camada tem responsabilidade exclusiva. O Controller não contém regra de negócio. O Model não conhece o Controller. A View não acessa o banco diretamente.

---

## Estrutura de pastas obrigatória

```
app-name/
├── src/
│   ├── controllers/       ← recebe request, chama service, retorna response
│   ├── services/          ← regras de negócio e orquestração
│   ├── models/            ← entidades e acesso a dados (ORM)
│   ├── middlewares/       ← auth, validação, logging, error handling
│   ├── routes/            ← definição de rotas agrupadas por recurso
│   ├── validators/        ← schemas de validação de entrada
│   └── utils/             ← funções utilitárias sem estado
├── tests/
│   ├── unit/
│   └── integration/
├── docs/
│   └── adr/
└── README.md
```

---

## Controller

- Recebe o request, delega pro Service, retorna o response
- Sem lógica de negócio — apenas orquestração de entrada e saída
- Máximo 20 linhas por método de controller
- Um arquivo de controller por recurso: `UserController`, `PaymentController`

```typescript
// Padrão de controller
async create(req: Request, res: Response): Promise<void> {
  const validated = await this.validator.validate(req.body)
  const result = await this.service.create(validated)
  res.status(201).json(result)
}
```

---

## Service

- Contém toda a regra de negócio
- Não conhece `Request` ou `Response` — trabalha com objetos de domínio
- Testável de forma isolada sem HTTP
- Um service por recurso ou caso de uso: `UserService`, `PaymentService`

---

## Model

- Representa a entidade e o acesso ao banco
- Sem lógica de negócio — apenas estrutura e queries
- Migrations versionadas e nunca editadas após executadas em produção
- Relacionamentos declarados explicitamente no model

---

## Middleware

Ordem obrigatória no pipeline de request:

1. Logger de request
2. Autenticação
3. Autorização
4. Validação de schema
5. Handler da rota
6. Error handler global

---

## Rotas

- Agrupadas por recurso em arquivos separados
- Prefixo de versão aplicado na raiz do router
- Middlewares de auth e validação declarados na definição da rota

```typescript
// Padrão de rota
router.post(
  '/users',
  authenticate,
  validate(CreateUserSchema),
  UserController.create
)
```

---

## Error handling

- Um único middleware de erro global no final da cadeia
- Nunca lançar erro diretamente pro cliente sem passar pelo middleware
- Erros de negócio com classe própria: `BusinessError`, `NotFoundError`, `ValidationError`