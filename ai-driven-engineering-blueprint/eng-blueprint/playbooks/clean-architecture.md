---
name: clean-architecture
description: Template descritivo da Clean Architecture em anéis concêntricos (domain, application, infrastructure, webapi) para monolito modular ou serviço único. Define a estrutura de pastas, a responsabilidade de cada anel, onde fica cada tipo de código e a regra da dependência. Sem código e sem linguagem específica.
status: proposto
---

# Template: Clean Architecture

> Este arquivo descreve **onde cada coisa fica e por quê**. Não traz código nem depende de linguagem ou biblioteca: as escolhas técnicas do projeto (framework HTTP, banco, logger, testes) vêm do `plan.md` do SDD. Serve para montar a arquitetura base de um repo novo, estender um repo existente e revisar se um repo está aderente.

---

## Referências

- [[constitution]] manda: em conflito, ela vence este arquivo
- [[rest-api]]: contrato HTTP exposto pelo `webapi`
- [[testing]], [[quality]], [[security]], [[observability]]

---

## 1. Ideia central: anéis concêntricos

A arquitetura é uma **cadeia de anéis**. Cada anel só conhece o anel de dentro dele. O anel mais interno não conhece ninguém.

```
   webapi  ──►  infrastructure  ──►  application  ──►  domain
 (anel 4)         (anel 3)           (anel 2)          (anel 1)
 entrada e        tecnologia         casos de uso      regras de negócio
 montagem         e adapters                           e contratos (gateways)
```

A seta significa "conhece". **A dependência de código sempre aponta para dentro.** O fluxo de execução faz o caminho contrário (a requisição entra pelo `webapi`, chega ao caso de uso, o caso de uso pede dados por um contrato do `domain`, e a `infrastructure` o atende), e é a inversão de dependência que reconcilia os dois.

| Anel | Pasta | Papel | Conhece |
|---|---|---|---|
| 1 | `domain` | regras de negócio da empresa e os **gateways** (contratos) que o negócio exige do mundo | ninguém |
| 2 | `application` | casos de uso: orquestram o domínio por meio dos gateways | só o `domain` |
| 3 | `infrastructure` | implementa os gateways com tecnologia real (banco, fila, APIs, outros módulos) e reage a eventos chamando casos de uso | `application` e `domain` |
| 4 | `webapi` | ponto de entrada: controllers, DTOs de request e response, tratamento de erros, configuração e montagem | `infrastructure`, `application` e `domain` |

**Relação com os círculos de Robert C. Martin:** Entities = `domain`; Use Cases = `application`; Interface Adapters e Frameworks & Drivers = `infrastructure` e `webapi`. Na prática de mercado (soluções .NET como Core, Infrastructure e Presentation; projetos Java multi-módulo com um módulo `webapi`), o círculo externo é separado em dois anéis como este, e o `webapi` é a camada de apresentação.

**Regra de ouro de cada anel:**
- `webapi` **só traduz**: converte HTTP em chamada de caso de uso e a resposta de volta em HTTP. Não contém regra de negócio.
- `infrastructure` **só implementa**: executa o que o contrato pede, com a tecnologia escolhida. Não decide fluxo de negócio.
- `application` **só orquestra**: chama o domínio na ordem certa. Não calcula regra de negócio.
- `domain` **decide**: toda regra de negócio mora aqui.

Estas regras devem ser verificadas por uma **ferramenta automática de arquitetura** da stack (regra de dependências no pipeline). Sem essa verificação verde, não há merge.

- **Entre módulos:** um módulo só usa a pasta `api/` do outro.
- **Dados que cruzam fronteiras** são sempre dados simples e isolados (input, output, request, response). Nunca uma entity nem uma linha de banco.

---

## 2. Quando usar e quando não usar

**Use** quando há: domínio rico, regras que mudam, vários times, crescimento previsto, possível extração futura de módulos.

**Não use** para: CRUD sem regra, MVP descartável. Nesses casos uma [[rest-api]] simples em camadas basta.

Prefira esta arquitetura quando o time já pensa em anéis, Use Cases e Entities, e quer o domínio com seus gateways juntos. A escolha da arquitetura fica registrada em Decisões no `plan.md` do SDD.

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
│   │       │
│   │       ├── domain/                 ← ANEL 1: regras de negócio
│   │       │   ├── entities/           ← agregados e entidades
│   │       │   ├── value-objects/      ← objetos de valor
│   │       │   ├── services/           ← regras que envolvem mais de um agregado
│   │       │   ├── events/             ← eventos de domínio
│   │       │   ├── gateways/           ← CONTRATOS que o domínio exige do mundo
│   │       │   └── errors/             ← erros de regra de negócio
│   │       │
│   │       ├── application/            ← ANEL 2: casos de uso
│   │       │   ├── use-cases/<caso>/   ← por caso de uso: interactor + input + output
│   │       │   └── facade/             ← implementa a interface pública de api/
│   │       │
│   │       ├── infrastructure/         ← ANEL 3: tecnologia e adapters
│   │       │   ├── persistence/        ← repositórios (implementam gateways), mapeadores, migrations
│   │       │   ├── messaging/          ← publicação no barramento de eventos e listeners
│   │       │   │                         (listeners recebem evento e chamam um caso de uso)
│   │       │   ├── <outro-modulo>/     ← anticorruption layer para outro módulo (usa só o api/ dele)
│   │       │   └── <integração>/       ← pagamento, e-mail, cache, estoque… um adapter por serviço
│   │       │
│   │       └── webapi/                 ← ANEL 4: ponto de entrada e montagem
│   │           ├── controllers/        ← traduzem HTTP em chamada de caso de uso
│   │           ├── dtos/               ← request e response HTTP (com validação de formato)
│   │           ├── handlers/           ← tradução de erros de domínio em resposta HTTP
│   │           └── entrypoint/         ← ponto de partida do módulo: inicialização e composição (liga casos de uso e adapters)
│   │
│   └── bootstrap/                      ← só compõe os módulos: nenhuma regra de negócio
│       ├── ponto de entrada            ← inicia a aplicação
│       ├── configuração               ← único leitor de variáveis de ambiente
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
| `<m>/api` | contrato público do módulo | `shared-kernel` | domain, application, infrastructure, webapi, bibliotecas externas |
| `<m>/domain` | entities, objetos de valor, gateways e regra de negócio | `shared-kernel` e o próprio domain | application, infrastructure, webapi, outros módulos, bibliotecas externas |
| `<m>/application` | use cases (interactors), input e output | o próprio domain, `api` de outros módulos, `shared-kernel` | infrastructure, webapi, bibliotecas externas |
| `<m>/infrastructure` | implementa gateways; listeners de evento; integrações | `application`, `domain`, `api` de outros módulos, bibliotecas de tecnologia | webapi |
| `<m>/webapi/controllers`, `dtos`, `handlers` | entrada HTTP: traduz request em input e output em response | `application` (use cases, input, output), bibliotecas de HTTP | infrastructure, domain direto |
| `<m>/webapi/entrypoint` | composição do módulo | todas as camadas do próprio módulo, `api` de outros | — |
| `bootstrap` | liga módulos, configuração e inicialização | `webapi/entrypoint` dos módulos, `shared-kernel` | camadas internas dos módulos |

### Onde colocar cada tipo de código

| O que é | Onde fica |
|---|---|
| Validação de **formato** (obrigatório, tamanho, e-mail) | `webapi/dtos` |
| Validação e cálculo de **negócio** | `domain` (entity ou domain service) |
| Orquestração, transação, autorização | interactor em `application/use-cases` |
| JSON ↔ input/output | `webapi/controllers` e `webapi/dtos` |
| Erro de domínio → resposta HTTP | `webapi/handlers` |
| Autenticação (token, sessão) | `webapi` (middleware) |
| Banco, cache, API externa | `infrastructure` |
| Chamada a outro módulo | `infrastructure/<modulo>` com anticorruption layer |
| Receber evento de outro módulo | listener em `infrastructure/messaging`, que chama um caso de uso |
| Evento de negócio (algo ocorreu) | `domain/events` |
| Evento que cruza módulos | eventos em `api/` |
| Montagem de dependências do módulo | `webapi/entrypoint` |
| Variáveis de ambiente | **somente** a configuração do `bootstrap` |

**Triagem rápida:** a decisão depende de conhecimento de negócio ou é só execução técnica? Negócio vai para o `domain`; técnica vai para `infrastructure` (saída) ou `webapi` (entrada). O use case apenas **chama** a decisão que a entity tomou.

---

## 6. Papel de cada peça

### 6.1 shared-kernel
Só o que todos os módulos realmente compartilham e quase nunca muda: raiz de agregado (guarda os eventos pendentes), evento de domínio, erro de domínio (com código e tipo: não encontrado, conflito, inválido, proibido), dinheiro (sempre em valor inteiro da menor unidade, nunca decimal flutuante) e os contratos técnicos mínimos (transação, barramento de eventos, logger, acesso ao banco). Se um item é usado por um módulo só, ele não é do kernel.

### 6.2 domain (anel 1)
- A **entity** (agregado) é a raiz de consistência: guarda as invariantes e muda de estado **só por métodos de negócio**. Entity rica tem comportamento; entity que só tem getters e setters é anêmica e é um defeito.
- **Objetos de valor** são imutáveis e comparados pelo valor.
- **Domain services** ficam com regras que envolvem mais de um agregado.
- **Eventos de domínio** registram o que aconteceu; a entity os acumula e quem persiste decide quando publicá-los.
- **Gateways:** contratos que o domínio exige do mundo (repositório, consulta a outro módulo, publicação de evento). Ficam **no domínio**, expressos em **tipos próprios do módulo**; a implementação mora na `infrastructure`.
- **Sem I/O, sem biblioteca externa e sem relógio solto:** se a hora importa para a regra, ela entra como dependência fornecida pela `application`.

### 6.3 application (anel 2)
- **Interactor:** uma pasta por caso de uso, com o interactor, o **input** e o **output**. Carrega o necessário pelos gateways, chama a entity, abre a transação, persiste e publica eventos. **Não decide regra de negócio e não conhece tecnologia.**
- **Input e output:** dados simples; nunca a entity.
- Se um use case precisa ser chamado por mais de um adapter ou trocado em teste, extrai-se um contrato do use case na `application` e o controller passa a depender dele.
- **Facade:** implementa a interface pública de `api/` para os outros módulos, devolvendo dados simples.

### 6.4 api (contrato público)
Só contratos, dados simples e constantes de eventos. **Nunca** expõe entity. Mudar algo aqui é mudar contrato: afeta todos os módulos consumidores, então muda com cuidado e com versão de evento.

### 6.5 infrastructure (anel 3)
Tudo que o sistema **usa** do mundo: o use case pede por um gateway, e a infraestrutura o implementa com a tecnologia real. Todo o SQL e o código do driver ficam confinados aqui.
- **Repositório:** implementa o gateway de persistência e converte entre entity e modelo do banco por um **mapeador**. A entity **nunca é** o modelo de persistência: são duas representações, e o mapeador converte uma na outra.
- **Anticorruption layer:** implementa o gateway que fala com outro módulo, usando só o `api/` dele, e traduz o modelo alheio para o modelo próprio.
- **Integrações externas:** um adapter por serviço (pagamento, e-mail, cache, estoque), cada um implementando um gateway.
- **Publicador de eventos:** entrega o evento ao barramento.
- **Listeners:** recebem o evento de outro módulo (usando só o `api/` dele) e chamam um caso de uso. É o único caso em que a infraestrutura chama a `application`.
- A infraestrutura **não decide fluxo de negócio**: só executa o que o gateway pede.

### 6.6 webapi (anel 4)
O ponto de entrada. Recebe o mundo e o entrega ao caso de uso.
- **Controller:** fino. Recebe a requisição, converte o request em input, chama o caso de uso, converte o output em response. Depende só da `application`.
- **DTOs:** o formato HTTP de entrada e de saída, com a validação de **formato** (não de negócio). Seguem o contrato de [[rest-api]].
- **Handlers de erro:** convertem erro de domínio em resposta HTTP; erro inesperado vira 500 genérico, sem vazar detalhe interno.
- **Entrypoint:** o ponto de partida do módulo: a inicialização e a composição. É o **único lugar do módulo que conhece todos os anéis** ao mesmo tempo: instancia as implementações da infraestrutura e as entrega aos casos de uso (injeção de dependência). É aqui, e só aqui, que as camadas se encontram.

### 6.7 bootstrap
Liga os módulos entre si. Lê a configuração de ambiente (único leitor), cria o barramento de eventos e o health check, e instancia os módulos **na ordem das dependências** (o módulo consultado antes do consumidor). Adicionar um módulo é registrar uma linha aqui; remover é apagá-la.

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

- Regra de negócio violada → erro de domínio (com código e tipo) → handler do `webapi` → envelope de erro padrão.
- Erro de formato → 400 com detalhe por campo, no `webapi`.
- Erro inesperado → 500 genérico; log com a causa técnica e **sem dados do payload** ([[observability]]).
- Nível de erro no log apenas para falha que exige atenção humana; erro de negócio esperado não é erro de log.

---

## 10. Testes por anel

| Anel | O que testar | Como |
|---|---|---|
| `domain` | invariantes e regras | puro, sem mock |
| `application` | orquestração, ordem, erros | gateways falsos, sem framework |
| `infrastructure` | mapeador, consultas, contrato do gateway, listeners | integração com banco real ou container |
| `webapi` | formato, status HTTP, tradução de erros | controller com o use case simulado |
| arquitetura | regra da dependência | verificação automática + prova de proteção (§11) |

Pirâmide e cobertura mínima conforme [[testing]] e [[quality]].

---

## 11. Verificação automática da arquitetura

A ferramenta de arquitetura da stack deve impor, de forma genérica (valendo para qualquer módulo novo sem editar a configuração):

- sem **ciclos** de dependência;
- `domain` depende só dele mesmo e do `shared-kernel`, e **nenhuma biblioteca externa**;
- `application` depende só do `domain` e do `api/` de outros módulos, e **nenhuma biblioteca externa**;
- `infrastructure` não depende de `webapi`;
- controllers, DTOs e handlers do `webapi` dependem só da `application` (nunca da `infrastructure` nem do `domain` direto); só `webapi/entrypoint` pode conhecer todos os anéis;
- módulo só importa o `api/` de outro; `api/` só depende do `shared-kernel`;
- `shared-kernel` não depende de módulos nem do bootstrap; ninguém importa o bootstrap; o bootstrap só importa o `webapi/entrypoint` dos módulos.

**Prova de proteção:** uma regra só vale se a violação realmente falha. Ao criar o projeto, introduza temporariamente uma violação conhecida (biblioteca no domínio; `infrastructure` dentro de `application`; controller importando a `infrastructure`; import entre módulos fora do `api/`), confirme que a verificação **falha**, e remova. Registre o resultado.

---

## 12. Como montar e estender

### 12.1 Criar o projeto
1. Confirmar os itens da §3 com o `plan.md`.
2. Criar a árvore da §4, com um módulo por contexto.
3. Criar o `shared-kernel` (§6.1) e o `bootstrap` (configuração, saúde, barramento, montagem).
4. Configurar a verificação de arquitetura (§11).
5. Para cada módulo, entregar **uma fatia vertical completa** de um caso de uso, de dentro para fora: entity e erro, gateways, interactor com input e output, repositório com mapeador, anticorruption layer (se houver), publicador, controller com DTOs e handler de erros, `api/`, `webapi/entrypoint`, migration inicial e testes.
6. Escrever README e `.env.example`; rodar a verificação completa (lint, tipos, arquitetura, testes, auditoria de dependências) e relatar o resultado real.
7. Fazer a prova de proteção (§11).

### 12.2 Novo módulo (contexto)
1. Confirmar nome e responsabilidade em uma frase; se precisa de "e" para descrever, dividir.
2. Criar as pastas do módulo, começando pelo `api/`.
3. Depois, de dentro para fora: `domain`, `application`, `infrastructure`, `webapi`.
4. Registrar no `bootstrap` respeitando a ordem de dependências.
5. Criar o schema ou prefixo e a migration. **Nenhuma chave estrangeira** para outro módulo.
6. Se precisa de outro módulo: gateway no `domain` + anticorruption layer em `infrastructure/<outro>`. Se precisa reagir a evento: listener em `infrastructure/messaging`.
7. Testes de cada anel; atualizar o README; decisão nova de fronteira vai em Decisões no `plan.md`.

### 12.3 Novo caso de uso
1. Pasta do caso de uso em `application/use-cases` com input, output e interactor.
2. Gateways novos no `domain/gateways`, **só se** necessário.
3. Regra de negócio na entity ou domain service, **com teste primeiro**.
4. Interactor orquestra, sem cálculo de negócio.
5. Implementação do gateway novo em `infrastructure`.
6. Controller, DTOs de request e response e rota em `webapi`.
7. Ligar em `webapi/entrypoint` e rodar a verificação completa.

---

## 13. Checklist de conformidade (C-xx)

Para revisão de PR e auditoria. Severidade: **B** bloqueante · **M** maior · **m** menor.

| ID | Verificação | Sev |
|---|---|---|
| C-01 | `domain` sem biblioteca externa ou framework | B |
| C-02 | `domain` não importa application, infrastructure, webapi nem outro módulo | B |
| C-03 | `application` só conhece o `domain` | B |
| C-04 | Nenhum anel interno importa um anel externo (domain e application nunca importam infrastructure ou webapi) | B |
| C-05 | Controllers, DTOs e handlers só dependem da `application`; só `webapi/entrypoint` conhece todos os anéis | B |
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
| Controller com regra de negócio | mover para a entity; o controller só traduz e chama o use case |
| Interactor "faz-tudo" | dividir em use cases coesos, um por intenção |
| Módulo usando internals do vizinho | `api/` + anticorruption layer |
| Infraestrutura decidindo fluxo | a decisão sobe para o use case; a infraestrutura só executa |
| Controller instanciando adapter da infraestrutura | a montagem fica só em `webapi/entrypoint` |

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

Para extrair um módulo (por exemplo `catalog`): o gateway do consumidor passa a chamar HTTP em vez do `api/` em memória; o listener troca o barramento em memória pela fila; o schema vira banco próprio. **Não mudam** `domain` nem `application`. O novo serviço mantém a mesma estrutura.
