---
name: clean-architecture
description: Template descritivo da Clean Architecture (Entities, Use Cases, Interface Adapters, Frameworks & Drivers) para monolito modular ou serviço único. Define a estrutura de pastas, a responsabilidade de cada camada, onde fica cada tipo de código e a regra da dependência. Sem código e sem linguagem específica.
status: proposto
---

# Template: Clean Architecture

> Este arquivo descreve **onde cada coisa fica e por quê**. Não traz código nem depende de linguagem ou biblioteca: as escolhas técnicas do projeto (framework HTTP, banco, logger, testes) vêm do `plan.md` do SDD. Serve para montar a arquitetura base de um repo novo, estender um repo existente e revisar se um repo está aderente.

---

## Referências

- [[constitution]] manda: em conflito, ela vence este arquivo
- [[rest-api]]: contrato HTTP da camada de interface
- [[testing]], [[quality]], [[security]], [[observability]]

---

## 1. Ideia central

A regra é uma só: **a dependência de código sempre aponta para dentro**. O fluxo de execução vai para fora (a requisição entra, o banco é consultado), mas quem **conhece** quem é decidido de fora para dentro.

```
   interface ──────┐                    ← controllers, presenters, assinantes de evento
                   ├──►  application ──►  domain
   infrastructure ─┘     (use cases)      (entities, gateways)
   (banco, fila, APIs)
```

| Camada | Papel | Conhece |
|---|---|---|
| `domain` (Entities) | regra de negócio da empresa; define também as **interfaces (gateways)** que exige do mundo | ninguém |
| `application` (Use Cases) | regra de aplicação; orquestra as entities por meio dos gateways | só o `domain` |
| `interface` (Interface Adapters) | traduz entrada e saída: controller, presenter, formato HTTP, assinante de evento | só a `application` |
| `infrastructure` (Frameworks & Drivers) | implementa os gateways com tecnologia real: banco, fila, APIs | só o `domain` |

- `interface` e `infrastructure` **não se enxergam**.
- **Entre módulos:** um módulo só usa a pasta `api/` do outro.

Estas regras devem ser verificadas por uma **ferramenta automática de arquitetura** da stack (regra de dependências no pipeline). Sem essa verificação verde, não há merge.

---

## 2. Quando usar e quando não usar

**Use** quando há: domínio rico, regras que mudam, vários times, crescimento previsto, possível extração futura de módulos.

**Não use** para: CRUD sem regra, MVP descartável. Nesses casos uma [[rest-api]] simples em camadas basta.

Prefira esta arquitetura quando o time já pensa em Use Cases e Entities e quer o domínio com seus gateways juntos. A escolha da arquitetura fica registrada em Decisões no `plan.md` do SDD.

---

## 3. O que definir antes de montar (vem do `plan.md`)

| Item | O que é | Exemplo |
|---|---|---|
| Nome do serviço | identifica o repo e os logs | `shop` |
| Módulos | um por contexto de negócio (bounded context) | `catalog`, `orders` |
| Topologia | `monolito modular` (vários módulos) ou `serviço único` (um módulo) | monolito modular |
| Framework HTTP | quem recebe as requisições | definido no plan |
| Acesso a dados | driver ou ORM | definido no plan |
| Logger e testes | ferramentas padrão do projeto | definido no plan |
| Infraestrutura como código | só se o SDD pedir infra | definido no plan |

Faltou algum item? Pergunte antes de decidir; não escolha biblioteca por conta própria. Nomes de módulo: minúsculas, em inglês, substantivo do negócio. Em serviço único, existe **um** módulo.

---

## 4. Estrutura de pastas

```
<nome-do-servico>/
├── src/
│   ├── shared-kernel/                  ← mínimo e estável; sem framework
│   │   ├── domain/                     ← tipos base: raiz de agregado, evento de domínio,
│   │   │                                 erro de domínio, dinheiro
│   │   ├── application/                ← contrato de transação (unit of work)
│   │   ├── events/                     ← contrato do barramento de eventos
│   │   ├── observability/              ← contrato do logger
│   │   └── persistence/                ← contrato mínimo de acesso ao banco
│   │
│   ├── modules/
│   │   └── <modulo>/                   ← UM contexto de negócio
│   │       ├── api/                    ← CONTRATO PÚBLICO: única porta de saída do módulo
│   │       │   ├── interface pública   ← o que outros módulos podem chamar
│   │       │   └── eventos             ← eventos de integração publicados
│   │       ├── domain/                 ← Entities (regras de negócio da empresa)
│   │       │   ├── entities/           ← agregados e entidades
│   │       │   ├── value-objects/      ← objetos de valor
│   │       │   ├── services/           ← regras que envolvem mais de um agregado
│   │       │   ├── events/             ← eventos de domínio
│   │       │   ├── gateways/           ← INTERFACES que o domínio exige do mundo
│   │       │   └── errors/             ← erros de regra de negócio
│   │       ├── application/            ← Use Cases (regras de aplicação)
│   │       │   ├── use-cases/<caso>/   ← por caso de uso: interactor + input + output
│   │       │   └── facade/             ← implementa a interface pública de api/
│   │       ├── interface/              ← Interface Adapters
│   │       │   ├── http/               ← controllers, presenters, formato request/response, mapeador de erros
│   │       │   └── events/             ← assinantes de eventos de OUTROS módulos
│   │       ├── infrastructure/         ← Frameworks & Drivers
│   │       │   ├── persistence/        ← repositórios (implementam gateways), mapeadores, migrations
│   │       │   ├── <outro-modulo>/     ← anticorruption layer para outro módulo (usa só o api/ dele)
│   │       │   └── messaging/          ← publicação no barramento de eventos
│   │       └── composição do módulo    ← único lugar que liga as camadas do módulo
│   │
│   └── bootstrap/                      ← só compõe: nenhuma regra de negócio
│       ├── ponto de entrada · configuração (único leitor de variáveis de ambiente)
│       ├── health check · barramento de eventos
│       └── montagem da aplicação       ← instancia os módulos na ordem das dependências
│
├── tests/
│   ├── integration/                    ← infraestrutura com banco/serviço real ou container
│   └── e2e/                            ← fluxos completos pela borda HTTP
├── sdd/                                ← quando existir
├── configuração da ferramenta de arquitetura (regras de dependência)
├── configuração de lint, build e testes do projeto
└── README, .env.example, .gitignore
```

- **Serviço único:** a mesma árvore, com um único módulo.
- **Testes unitários** ficam ao lado do código que testam.

---

## 5. Responsabilidade de cada pasta

| Pasta | Responsabilidade | Pode depender de | Não pode depender de |
|---|---|---|---|
| `shared-kernel` | tipos base e contratos técnicos mínimos | nada | módulos, bootstrap, bibliotecas externas |
| `<m>/api` | contrato público do módulo | `shared-kernel` | domain, application, interface, infrastructure, bibliotecas externas |
| `<m>/domain` | entities, objetos de valor, gateways e regra de negócio | `shared-kernel` e o próprio domain | application, interface, infrastructure, outros módulos, bibliotecas externas |
| `<m>/application` | use cases (interactors), input e output | o próprio domain, `api` de outros módulos, `shared-kernel` | interface, infrastructure, bibliotecas externas |
| `<m>/interface` | controllers, presenters, formato HTTP, assinantes de evento | `application` (use cases, input/output), bibliotecas de HTTP | infrastructure, domain direto |
| `<m>/infrastructure` | implementa gateways com tecnologia | domain (gateways, entities), `api` de outros módulos, bibliotecas | interface, application |
| composição do módulo | liga as camadas do módulo | todas as camadas do próprio módulo, `api` de outros | — |
| `bootstrap` | liga módulos, configuração e inicialização | composição dos módulos, `shared-kernel` | camadas internas dos módulos |

### Onde colocar cada tipo de código

| O que é | Onde fica |
|---|---|
| Validação de **formato** (obrigatório, tamanho, e-mail) | `interface/http` |
| Validação e cálculo de **negócio** | `domain` (entity ou domain service) |
| Orquestração, transação, autorização | interactor em `application/use-cases` |
| JSON ↔ input/output | `interface/http` (controller) |
| Formatar o output como resposta HTTP | presenter em `interface/http` |
| Autenticação (token, sessão) | `interface/http` (middleware) |
| Banco, cache, API externa | `infrastructure` |
| Chamada a outro módulo | `infrastructure/<modulo>` com anticorruption layer |
| Evento de negócio (algo ocorreu) | `domain/events` |
| Evento que cruza módulos | eventos em `api/` |
| Montagem de dependências | composição do módulo e `bootstrap` |
| Variáveis de ambiente | **somente** a configuração do `bootstrap` |

**Triagem rápida:** a decisão depende de conhecimento de negócio ou é só execução técnica? Negócio vai para o `domain`; técnica vai para `interface` ou `infrastructure`. O use case apenas **chama** a decisão que a entity tomou.

---

## 6. Papel de cada peça

### 6.1 shared-kernel
Só o que todos os módulos realmente compartilham e quase nunca muda: raiz de agregado (guarda os eventos pendentes), evento de domínio, erro de domínio (com código e tipo: não encontrado, conflito, inválido, proibido), dinheiro (sempre em valor inteiro da menor unidade, nunca decimal flutuante) e os contratos técnicos mínimos (transação, barramento de eventos, logger, acesso ao banco). Se um item é usado por um módulo só, ele não é do kernel.

### 6.2 domain (Entities)
- A **entity** (agregado) é a raiz de consistência: guarda as invariantes e muda de estado **só por métodos de negócio**. Entity rica tem comportamento; entity que só tem getters e setters é anêmica e é um defeito.
- **Objetos de valor** são imutáveis e comparados pelo valor.
- **Domain services** ficam com regras que envolvem mais de um agregado.
- **Eventos de domínio** registram o que aconteceu; a entity os acumula e quem persiste decide quando publicá-los.
- **Gateways:** interfaces que o domínio exige do mundo (repositório, consulta a outro módulo, publicação de evento). Ficam **no domínio**, expressas em **tipos próprios do módulo**; a implementação mora na `infrastructure`.
- **Sem I/O, sem biblioteca externa e sem relógio solto:** se a hora importa para a regra, ela entra como dependência fornecida pela `application`.

### 6.3 application (Use Cases)
- **Interactor:** uma pasta por caso de uso, com o interactor, o **input** e o **output**. Carrega o necessário pelos gateways, chama a entity, abre a transação, persiste e publica eventos. **Não decide regra de negócio e não conhece tecnologia.**
- **Input e output:** dados simples; nunca a entity.
- Se um use case precisa ser chamado por mais de um adapter ou trocado em teste, extrai-se uma interface do use case na `application` e o controller passa a depender dela.
- **Facade:** implementa a interface pública de `api/` para os outros módulos, devolvendo dados simples.

### 6.4 api (contrato público)
Só interfaces, dados simples e constantes de eventos. **Nunca** expõe entity. Mudar algo aqui é mudar contrato: afeta todos os módulos consumidores, então muda com cuidado e com versão de evento.

### 6.5 interface (Interface Adapters)
- **Controller:** fino. Valida o formato, monta o input, chama o use case e entrega o output ao presenter.
- **Presenter:** transforma o output na resposta HTTP padrão de [[rest-api]].
- **Mapeador de erros:** converte erro de domínio em resposta HTTP; erro inesperado vira 500 genérico, sem vazar detalhe interno.
- **Assinantes de evento:** recebem o evento de outro módulo (usando só o `api/` dele) e chamam um use case.

### 6.6 infrastructure (Frameworks & Drivers)
- **Repositório:** implementa o gateway de persistência e converte entre entity e modelo do banco por um **mapeador** (a entity nunca é o modelo de persistência).
- **Anticorruption layer:** implementa o gateway que fala com outro módulo, usando só o `api/` dele, e traduz o modelo alheio para o modelo próprio.
- **Publicador de eventos:** entrega o evento ao barramento.
- A infraestrutura **não decide fluxo de negócio** e **não chama use cases**: só executa o que o gateway pede.

### 6.7 composição do módulo e bootstrap
A composição do módulo é o **único lugar que instancia e liga** gateways, use cases, controllers e facade de um módulo. O `bootstrap` instancia os módulos **na ordem das dependências**. Adicionar um módulo é criar a sua composição e registrar uma linha no bootstrap; remover é apagar essa linha.

---

## 7. Comunicação entre módulos

| Situação | Mecanismo |
|---|---|
| Preciso do dado agora (preço, estoque) | `api/` do outro módulo, consumido por gateway com anticorruption layer |
| Aviso de que algo aconteceu | evento de integração no barramento (contrato em `api/`) |
| Efeito que **não pode ser perdido** | outbox: grava o evento na mesma transação e publica depois |
| Preciso de consistência forte entre dois contextos | reavalie: provavelmente são o mesmo contexto |

**Proibido:** importar camadas internas de outro módulo; JOIN ou chave estrangeira entre dados de módulos; ler a tabela do vizinho; entity dentro de evento ou `api`; dois módulos compartilhando o mesmo modelo de persistência.

---

## 8. Banco de dados

- Cada módulo só toca nos **seus** dados.
- Com banco que suporta schema: **um schema por módulo**. Sem suporte: prefixo no nome da tabela.
- Referência a outro módulo é só o **identificador**, sem chave estrangeira.
- Migrations versionadas, automatizadas no pipeline e **nunca editadas** depois de aplicadas em produção. Ficam dentro do módulo, na persistência, com nome que inclui data e hora.
- Em serviço único, o serviço é dono do seu banco.

---

## 9. Tratamento de erros

- Regra de negócio violada → erro de domínio (com código e tipo) → mapeador da `interface` → envelope de erro padrão.
- Erro de formato → 400 com detalhe por campo, na `interface`.
- Erro inesperado → 500 genérico; log com a causa técnica e **sem dados do payload** ([[observability]]).
- Nível de erro no log apenas para falha que exige atenção humana; erro de negócio esperado não é erro de log.

---

## 10. Testes por camada

| Camada | O que testar | Como |
|---|---|---|
| `domain` | invariantes e regras | puro, sem mock |
| `application` | orquestração, ordem, erros | gateways falsos, sem framework |
| `interface` | formato, status HTTP, presenter | controller com o use case simulado |
| `infrastructure` | mapeador, consultas, contrato do gateway | integração com banco real ou container |
| arquitetura | regra da dependência | verificação automática + prova de proteção (§11) |

Pirâmide e cobertura mínima conforme [[testing]] e [[quality]].

---

## 11. Verificação automática da arquitetura

A ferramenta de arquitetura da stack deve impor, de forma genérica (valendo para qualquer módulo novo sem editar a configuração):

- sem **ciclos** de dependência;
- `domain` depende só dele mesmo e do `shared-kernel`, e **nenhuma biblioteca externa**;
- `application` não depende de `interface` nem de `infrastructure`, nem de bibliotecas externas;
- `interface` e `infrastructure` não se importam; `interface` não importa o `domain` direto; `infrastructure` não chama a `application`;
- módulo só importa o `api/` de outro; `api/` só depende do `shared-kernel`;
- `shared-kernel` não depende de módulos nem do bootstrap; ninguém importa o bootstrap; o bootstrap só importa a composição dos módulos.

**Prova de proteção:** uma regra só vale se a violação realmente falha. Ao criar o projeto, introduza temporariamente uma violação conhecida (biblioteca no domínio; import entre módulos fora do `api/`; `infrastructure` dentro de `application`), confirme que a verificação **falha**, e remova. Registre o resultado.

---

## 12. Como montar e estender

### 12.1 Criar o projeto
1. Confirmar os itens da §3 com o `plan.md`.
2. Criar a árvore da §4, com um módulo por contexto.
3. Criar o `shared-kernel` (§6.1) e o `bootstrap` (configuração, saúde, barramento, montagem).
4. Configurar a verificação de arquitetura (§11).
5. Para cada módulo, entregar **uma fatia vertical completa** de um caso de uso: entity e erro, gateways, interactor com input e output, controller com presenter e mapeador de erros, repositório com mapeador, anticorruption layer (se houver), publicador, `api/`, composição, migration inicial e testes.
6. Escrever README e `.env.example`; rodar a verificação completa (lint, tipos, arquitetura, testes, auditoria de dependências) e relatar o resultado real.
7. Fazer a prova de proteção (§11).

### 12.2 Novo módulo (contexto)
1. Confirmar nome e responsabilidade em uma frase; se precisa de "e" para descrever, dividir.
2. Criar as pastas do módulo, começando pelo `api/`.
3. Depois `domain`, `application`, `interface`, `infrastructure` e a composição.
4. Registrar no `bootstrap` respeitando a ordem de dependências.
5. Criar o schema ou prefixo e a migration. **Nenhuma chave estrangeira** para outro módulo.
6. Se precisa de outro módulo: gateway no `domain` + anticorruption layer em `infrastructure/<outro>`. Se precisa reagir a evento: assinante em `interface/events`.
7. Testes das camadas; atualizar o README; decisão nova de fronteira vai em Decisões no `plan.md`.

### 12.3 Novo caso de uso
1. Pasta do caso de uso em `application/use-cases` com input, output e interactor.
2. Gateways novos no `domain/gateways`, **só se** necessário.
3. Regra de negócio na entity ou domain service, **com teste primeiro**.
4. Interactor orquestra, sem cálculo de negócio.
5. Controller e presenter (e rota) em `interface/http`; implementação do gateway novo em `infrastructure`.
6. Ligar na composição do módulo e rodar a verificação completa.

---

## 13. Checklist de conformidade (C-xx)

Para revisão de PR e auditoria. Severidade: **B** bloqueante · **M** maior · **m** menor.

| ID | Verificação | Sev |
|---|---|---|
| C-01 | `domain` sem biblioteca externa ou framework | B |
| C-02 | `domain` não importa application, interface, infrastructure nem outro módulo | B |
| C-03 | `application` só conhece o `domain` | B |
| C-04 | `interface` e `infrastructure` não se importam | B |
| C-05 | `infrastructure` não chama use cases | B |
| C-06 | Módulo só importa o `api/` de outro | B |
| C-07 | Sem ciclos de dependência | B |
| C-08 | Gateways vivem em `domain/gateways`; a implementação só em `infrastructure` | B |
| C-09 | Entity é diferente do modelo de persistência (existe mapeador) | M |
| C-10 | Controller sem regra de negócio nem mutação direta de entity | M |
| C-11 | Interactor sem cálculo de negócio | M |
| C-12 | Infraestrutura não decide fluxo (não dispara e-mail ou evento por condição de negócio) | M |
| C-13 | Entities ricas, não anêmicas | M |
| C-14 | Dinheiro não é decimal flutuante | M |
| C-15 | Schema ou prefixo por módulo; sem chave estrangeira ou JOIN entre módulos | B |
| C-16 | Variáveis de ambiente só na configuração do `bootstrap`; health check no formato da [[observability]]; sem log solto | M |
| C-17 | Cobertura mínima de [[quality]] atingida; auditoria de dependências sem alta ou crítica | B |
| C-18 | README e `.env.example` presentes | m |

---

## 14. Auditar um repo existente

Auditar é **somente leitura** até o humano aprovar o plano; o ajuste vem por task de SDD.

1. **Classificar o layout:** A em camadas/MVC · B parcialmente Clean (há `domain` e use cases, com vazamentos) · C conforme · D sem estrutura (tratar como A, começando pelo contexto mais rico).
2. **Rodar a verificação de arquitetura em modo aviso** (sem alterar código) e anotar as violações por regra.
3. **Preencher o checklist C-xx** com evidência (arquivo e linha, ou saída do comando). O que não puder ser verificado vai em "não verificado"; nunca marcar conforme por suposição.
4. **Relatório:** layout detectado, aderência (n de 18), bloqueantes abertos, resultado por item, violações por regra e plano de ajuste ordenado (uma task por PR).

### Ajuste incremental (depois da aprovação)
1. Ferramentas primeiro, sem mudar comportamento (lint, tipos, testes e verificação de arquitetura).
2. **Congelar a dívida:** registrar as violações atuais como conhecidas e impedir que cresçam; daí em diante, violação nova falha.
3. Criar a estrutura do módulo sem mover nada ainda.
4. Migrar **por caso de uso**, do mais rico em regra para o mais simples: teste de caracterização → extrair a regra para a entity → criar gateways e interactor → mover banco/API para `infrastructure` com mapeador → o controller antigo passa a chamar o use case → remover a violação da lista conhecida.
5. Fechar as fronteiras entre módulos (`api/` + anticorruption layer; separar dados).
6. Quando a lista de violações conhecidas esvaziar, apagá-la.

**Nunca:** reescrever o repo de uma vez; mudar regra de negócio ao mover código; mudar contrato HTTP público sem task explícita.

### Anti-padrões e correção

| Anti-padrão | Correção |
|---|---|
| Over-engineering em CRUD | usar camadas simples |
| Entity anêmica | mover a regra do service para a entity |
| Framework vazando para o domain | classe de domínio pura + mapeador na infraestrutura |
| Interactor "faz-tudo" | dividir em use cases coesos, um por intenção |
| Módulo usando internals do vizinho | `api/` + anticorruption layer |
| Infraestrutura decidindo fluxo | a decisão sobe para o use case; a infraestrutura só executa |

---

## 15. Definition of Done

- [ ] Verificação completa verde (lint, tipos, arquitetura, testes com a cobertura de [[quality]], auditoria de dependências) e resultado real no relatório
- [ ] Prova de proteção feita (projeto novo ou módulo novo)
- [ ] Nenhuma biblioteca fora do `plan.md`; nenhum segredo
- [ ] README atualizado
- [ ] Dúvidas de negócio registradas como `[NEEDS CLARIFICATION]`
- [ ] Nada commitado sem pedido

---

## 16. Evolução para microserviço

Para extrair um módulo (por exemplo `catalog`): o gateway do consumidor passa a chamar HTTP em vez do `api/` em memória; o assinante de evento troca o barramento em memória pela fila; o schema vira banco próprio. **Não mudam** `domain` nem `application`. O novo serviço mantém a mesma estrutura.
