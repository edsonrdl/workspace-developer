---
name: hexagonal
description: Template descritivo da Arquitetura Hexagonal (Ports & Adapters) para monolito modular ou serviço único. Define a estrutura de pastas, a responsabilidade de cada camada, onde fica cada tipo de código e as regras de dependência. Sem código e sem linguagem específica.
status: proposto
---

# Template: Arquitetura Hexagonal (Ports & Adapters)

> Este arquivo descreve **onde cada coisa fica e por quê**. Não traz código nem depende de linguagem ou biblioteca: as escolhas técnicas do projeto (framework HTTP, banco, logger, testes) vêm do `plan.md` do SDD. Serve para montar a arquitetura base de um repo novo, para estender um repo existente e para revisar se um repo está aderente.

---

## Referências

- [[constitution]] manda: em conflito, ela vence este arquivo
- [[rest-api]]: contrato HTTP dos adapters de entrada
- [[testing]], [[quality]], [[security]], [[observability]]

---

## 1. Ideia central

O **negócio fica no centro e não conhece tecnologia**. Tudo que fala com o mundo (HTTP, banco, fila, outro módulo, serviço externo) entra e sai por **portas** (contratos) e é implementado por **adapters** nas bordas.

```
   adapters de entrada ───►  application  ───►  domain
   (HTTP, eventos)           (casos de uso,     (regras de negócio,
                              portas in/out)     sem dependências)
                                   ▲
   adapters de saída ──────────────┘   implementam as portas de saída
   (banco, APIs, fila, outros módulos)
```

- **Porta de entrada:** o que a aplicação oferece ("criar pedido"). Quem usa é um adapter de entrada.
- **Porta de saída:** o que a aplicação exige do mundo ("salvar pedido", "consultar preço"). Quem implementa é um adapter de saída.
- **Adapter:** a peça que traduz entre o mundo (HTTP, SQL, mensagem) e as portas. É a única parte que conhece tecnologia.

### Duas regras inegociáveis

1. **Dentro de um módulo:** o `domain` não conhece ninguém; a `application` conhece só o `domain`; os adapters conhecem a `application` e podem conhecer tecnologia. Adapter de entrada e adapter de saída **não se enxergam**.
2. **Entre módulos:** um módulo só usa a pasta `api/` de outro. Nunca o `domain`, a `application` ou os adapters do vizinho.

Estas regras devem ser verificadas por uma **ferramenta automática de arquitetura** da stack (regra de dependências no pipeline). Sem essa verificação verde, não há merge.

---

## 2. Quando usar e quando não usar

**Use** quando há: regra de negócio relevante; várias integrações voláteis (pagamento, ERP, fila); várias pessoas ou times no mesmo código; possibilidade de extrair módulos no futuro.

**Não use** para: CRUD sem regra, protótipo descartável, script ou job trivial. Nesses casos use uma [[rest-api]] simples em camadas. Se o repo mistura os dois, aplique Hexagonal **só nos módulos com regra rica**.

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

Faltou algum item? Pergunte antes de decidir; não escolha biblioteca por conta própria. Nomes de módulo: minúsculas, em inglês, substantivo do negócio (`orders`, `payments`). Em serviço único, existe **um** módulo.

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
│   │       ├── domain/                 ← regra de negócio pura
│   │       │   ├── model/              ← agregados, entidades, objetos de valor
│   │       │   ├── services/           ← regras que envolvem mais de um agregado
│   │       │   ├── specifications/     ← regras reutilizáveis e combináveis
│   │       │   ├── events/             ← eventos de domínio (algo que aconteceu)
│   │       │   └── errors/             ← erros de regra de negócio
│   │       ├── application/
│   │       │   ├── ports/in/           ← portas de entrada: um caso de uso por intenção
│   │       │   ├── ports/out/          ← portas de saída: o que se exige do mundo
│   │       │   ├── services/           ← implementam as portas de entrada (orquestram)
│   │       │   ├── commands/           ← dados de entrada dos casos de uso
│   │       │   ├── results/            ← dados de saída dos casos de uso
│   │       │   └── facade/             ← implementa a interface pública de api/
│   │       ├── adapters/
│   │       │   ├── in/http/            ← controllers, formato de request/response, rotas
│   │       │   ├── in/events/          ← assinantes de eventos de OUTROS módulos
│   │       │   ├── out/persistence/    ← repositórios, mapeadores, migrations
│   │       │   ├── out/<outro-modulo>/ ← anticorruption layer para outro módulo (usa só o api/ dele)
│   │       │   └── out/events/         ← publicação no barramento de eventos
│   │       └── composição do módulo    ← único lugar que liga as camadas do módulo
│   │
│   └── bootstrap/                      ← só compõe: nenhuma regra de negócio
│       ├── ponto de entrada            ← inicia a aplicação
│       ├── configuração                ← único lugar que lê variáveis de ambiente
│       ├── health check                ← endpoint de saúde
│       ├── barramento de eventos       ← implementação em memória (ou fila, em microserviço)
│       └── montagem da aplicação       ← instancia os módulos na ordem das dependências
│
├── tests/
│   ├── integration/                    ← adapters com banco/serviço real ou container
│   └── e2e/                            ← fluxos completos pela borda HTTP
├── sdd/                                ← quando existir
├── configuração da ferramenta de arquitetura (regras de dependência)
├── configuração de lint, build e testes do projeto
└── README, .env.example, .gitignore
```

- **Serviço único:** a mesma árvore, com um único módulo em `modules/`.
- **Testes unitários** ficam ao lado do código que testam.

---

## 5. Responsabilidade de cada pasta

| Pasta | Responsabilidade | Pode depender de | Não pode depender de |
|---|---|---|---|
| `shared-kernel` | tipos base e contratos técnicos mínimos | nada | módulos, bootstrap, bibliotecas externas |
| `<m>/api` | contrato público do módulo (interfaces, dados simples, eventos) | `shared-kernel` | domain, application, adapters, bibliotecas externas |
| `<m>/domain` | regra de negócio | `shared-kernel` e o próprio domain | application, adapters, outros módulos, bibliotecas externas |
| `<m>/application` | orquestra casos de uso; declara portas in/out | o próprio domain, `api` de outros módulos, `shared-kernel` | adapters, bibliotecas externas |
| `<m>/adapters/in` | traduz a entrada (HTTP/evento) em comando e chama a porta de entrada | portas de entrada, commands/results, bibliotecas de tecnologia | adapters de saída, domain direto |
| `<m>/adapters/out` | implementa porta de saída com tecnologia real | portas de saída, domain, `api` de outros módulos, bibliotecas | adapters de entrada |
| composição do módulo | liga use cases e adapters do módulo | todas as camadas do próprio módulo, `api` de outros | — |
| `bootstrap` | liga módulos, configuração e inicialização | composição dos módulos, `shared-kernel` | camadas internas dos módulos |

### Onde colocar cada tipo de código

| O que é | Onde fica |
|---|---|
| Validação de **formato** (obrigatório, tamanho, e-mail) | adapter de entrada HTTP |
| Validação e cálculo de **negócio** | `domain` (método do agregado, domain service ou specification) |
| Orquestração de um caso de uso | `application/services` |
| Transação | `application/services`, via contrato de unit of work |
| Autorização (pode ou não pode) | `application/services` |
| Autenticação (token, sessão) | adapter de entrada HTTP (middleware) |
| JSON ↔ comando/resultado | adapter de entrada HTTP |
| Banco, cache, API externa | `adapters/out` |
| Chamada a outro módulo | `adapters/out/<modulo>` com anticorruption layer |
| Evento de negócio (algo ocorreu) | `domain/events` |
| Evento que cruza módulos | eventos em `api/` |
| Montagem de dependências | composição do módulo e `bootstrap` |
| Variáveis de ambiente | **somente** a configuração do `bootstrap` |

**Triagem rápida:** a decisão depende de conhecimento de negócio ou é só execução técnica? Negócio vai para o `domain`; técnica vai para um adapter. Regra de uma entidade só vira método da entidade; regra que combina agregados vira domain service; regra reutilizável e combinável vira specification. A `application` apenas **chama** a decisão que o domínio tomou.

---

## 6. Papel de cada peça

### 6.1 shared-kernel
Só o que todos os módulos realmente compartilham e que quase nunca muda: raiz de agregado (guarda os eventos pendentes), evento de domínio, erro de domínio (com código e tipo: não encontrado, conflito, inválido, proibido), dinheiro (sempre em valor inteiro da menor unidade, nunca decimal flutuante) e os contratos técnicos mínimos (transação, barramento de eventos, logger, acesso ao banco). Se um item é usado por um módulo só, ele não é do kernel.

### 6.2 domain
- O **agregado** é a raiz de consistência: guarda as invariantes ("pedido vazio não confirma") e muda de estado **só por métodos de negócio**, nunca por setters públicos.
- **Objetos de valor** são imutáveis e comparados pelo valor (dinheiro, endereço).
- **Domain services** ficam com regras que envolvem mais de um agregado.
- **Eventos de domínio** registram o que aconteceu; o agregado os acumula e quem persiste decide quando publicá-los.
- **Sem I/O, sem biblioteca externa e sem relógio solto:** se a hora importa para a regra, ela entra como dependência fornecida pela `application`.

### 6.3 application
- **Porta de entrada:** um contrato por intenção do usuário. Uma porta com dezenas de operações é anti-padrão.
- **Porta de saída:** descreve o que a aplicação precisa do mundo, em **tipos próprios do módulo** (nunca reaproveita o modelo de outro contexto).
- **Serviço de aplicação:** implementa a porta de entrada. Carrega o necessário, chama o domínio, abre a transação, persiste e publica eventos. **Não decide regra de negócio e não conhece tecnologia.**
- **Comandos e resultados:** dados simples de entrada e saída; nunca a entidade de domínio.
- **Facade:** implementa a interface pública de `api/` para os outros módulos, devolvendo dados simples.

### 6.4 api (contrato público)
Só interfaces, dados simples e constantes de eventos. **Nunca** expõe entidade de domínio. Mudar algo aqui é mudar contrato: afeta todos os módulos consumidores, então muda com cuidado e com versão de evento.

### 6.5 adapters de entrada
Finos: validam o formato, montam o comando, chamam a porta de entrada e traduzem o resultado. Dependem da **porta**, nunca do serviço concreto. Um mapeador de erros converte erro de domínio em resposta HTTP (envelope de [[rest-api]]); erro inesperado vira 500 genérico, sem vazar detalhe interno. Assinantes de evento seguem o mesmo princípio: recebem o evento de outro módulo (usando só o `api/` dele) e chamam uma porta de entrada.

### 6.6 adapters de saída
- **Repositório:** implementa a porta de persistência e converte entre domínio e modelo do banco por um **mapeador** (o domínio nunca é o modelo de persistência).
- **Anticorruption layer:** implementa a porta que fala com outro módulo, usando só o `api/` dele, e traduz o modelo alheio para o modelo próprio.
- **Publicador de eventos:** entrega o evento ao barramento.
- Adapter de saída **não decide fluxo de negócio**: só executa o que a aplicação mandou.

### 6.7 composição do módulo e bootstrap
A composição do módulo é o **único lugar que instancia e liga** adapters, serviços e facade de um módulo. O `bootstrap` instancia os módulos **na ordem das dependências** (o módulo consultado antes do consumidor). Adicionar um módulo é criar a sua composição e registrar uma linha no bootstrap; remover é apagar essa linha.

---

## 7. Comunicação entre módulos

| Situação | Mecanismo |
|---|---|
| Preciso do dado agora (preço, estoque) | `api/` do outro módulo, consumido por adapter de saída com anticorruption layer |
| Aviso de que algo aconteceu | evento de integração no barramento (contrato em `api/`) |
| Efeito que **não pode ser perdido** | outbox: grava o evento na mesma transação e publica depois |
| Preciso de consistência forte entre dois contextos | reavalie: provavelmente são o mesmo contexto |

**Proibido:** importar domain, application ou adapters de outro módulo; JOIN ou chave estrangeira entre dados de módulos; ler a tabela do vizinho; entidade de domínio dentro de evento ou `api`; dois módulos compartilhando o mesmo modelo de persistência.

---

## 8. Banco de dados

- Cada módulo só toca nos **seus** dados.
- Com banco que suporta schema: **um schema por módulo**. Sem suporte: prefixo no nome da tabela.
- Referência a outro módulo é só o **identificador**, sem chave estrangeira.
- Migrations versionadas, automatizadas no pipeline e **nunca editadas** depois de aplicadas em produção. Ficam dentro do módulo, na persistência, com nome que inclui data e hora (evita colisão entre módulos).
- Em serviço único, o serviço é dono do seu banco.

---

## 9. Tratamento de erros

- Regra de negócio violada → erro de domínio (com código e tipo) → mapeador do adapter de entrada → envelope de erro padrão.
- Erro de formato → 400 com detalhe por campo, no adapter de entrada.
- Erro inesperado → 500 genérico; log com a causa técnica e **sem dados do payload** ([[observability]]).
- Nível de erro no log apenas para falha que exige atenção humana; erro de negócio esperado não é erro de log.

---

## 10. Verificação automática da arquitetura

A ferramenta de arquitetura da stack deve impor, de forma genérica (valendo para qualquer módulo novo sem editar a configuração):

- sem **ciclos** de dependência;
- `domain` depende só dele mesmo e do `shared-kernel`, e **nenhuma biblioteca externa**;
- `application` não depende de adapters nem de bibliotecas externas;
- adapter de entrada e adapter de saída não se importam, e o de entrada não importa o `domain` direto;
- módulo só importa o `api/` de outro; `api/` só depende do `shared-kernel`;
- `shared-kernel` não depende de módulos nem do bootstrap; ninguém importa o bootstrap; o bootstrap só importa a composição dos módulos.

**Prova de proteção:** uma regra só vale se a violação realmente falha. Ao criar o projeto, introduza temporariamente uma violação conhecida (biblioteca no domínio; import entre módulos fora do `api/`), confirme que a verificação **falha**, e remova. Registre o resultado.

---

## 11. Como montar e estender

### 11.1 Criar o projeto
1. Confirmar os itens da §3 com o `plan.md`.
2. Criar a árvore da §4, com um módulo por contexto.
3. Criar o `shared-kernel` (§6.1) e o `bootstrap` (configuração, saúde, barramento, montagem).
4. Configurar a verificação de arquitetura (§10).
5. Para cada módulo, entregar **uma fatia vertical completa** de um caso de uso: domínio, portas, serviço, adapters de entrada e saída, `api/`, composição, migration inicial e testes.
6. Escrever README e `.env.example`; rodar a verificação completa (lint, tipos, arquitetura, testes, auditoria de dependências) e relatar o resultado real.
7. Fazer a prova de proteção (§10).

### 11.2 Novo módulo (contexto)
1. Confirmar nome e responsabilidade em uma frase; se precisa de "e" para descrever, dividir.
2. Criar as pastas do módulo, começando pelo `api/` (o contrato).
3. Depois `domain`, `application`, `adapters` e a composição do módulo.
4. Registrar no `bootstrap` respeitando a ordem de dependências.
5. Criar o schema ou prefixo e a migration. **Nenhuma chave estrangeira** para outro módulo.
6. Se precisa de outro módulo: porta de saída + anticorruption layer usando só o `api/` dele. Se precisa reagir a evento: adapter de entrada de eventos.
7. Testes das três camadas; atualizar o README; decisão nova de fronteira vai em Decisões no `plan.md`.

### 11.3 Novo caso de uso
1. Comando e resultado.
2. Porta de entrada (uma por intenção).
3. Portas de saída novas, **só se** o caso de uso exige algo ainda não coberto.
4. Regra de negócio no `domain`, **com teste primeiro**.
5. Serviço de aplicação que orquestra.
6. Adapter de entrada (rota) e, se houver porta nova, o adapter de saída.
7. Ligar na composição do módulo e rodar a verificação completa.

### 11.4 Nova integração (API externa, mensageria ou outro módulo)
A aplicação **nunca** chama a tecnologia: ela chama uma porta de saída, e um adapter de saída a implementa.
1. **Nomear a porta pelo negócio**, não pela tecnologia nem pelo provedor: `buscar pagamento`, e não `chamar API do provedor X`.
2. **Declarar a porta em `application/ports/out`**, só com as operações que o caso de uso realmente usa, recebendo e devolvendo **tipos do próprio módulo** (nunca a resposta crua da API).
3. **Chamar a porta no serviço de aplicação**, sem saber o que existe por trás.
4. **Implementar em `adapters/out/<integração>/`** (um adapter por serviço): a chamada HTTP ou o cliente, a tradução do formato externo para o modelo próprio, o tratamento de timeout, erro e nova tentativa. Sem regra de negócio.
5. **Mensageria de saída:** a porta de publicação fica em `application/ports/out`; o publicador fica em `adapters/out/events`. **Mensageria de entrada:** o assinante em `adapters/in/events` recebe o evento e chama uma porta de entrada; se o evento cruza módulos, o contrato dele fica em `api/`.
6. **Outro módulo:** porta de saída + anticorruption layer em `adapters/out/<outro-modulo>`, usando só o `api/` do vizinho.
7. **Ligar** a porta à implementação na composição do módulo. Endereço, credenciais e chaves vêm da configuração do `bootstrap`; biblioteca nova entra no `plan.md`.
8. **Testar:** o serviço de aplicação com uma porta falsa (sem rede); o adapter com serviço simulado ou container.

Trocar de provedor é escrever outro adapter e mudar só a ligação na composição. `domain` e `application` não mudam.

---

## 12. Checklist de conformidade (H-xx)

Para revisão de PR e auditoria. Severidade: **B** bloqueante · **M** maior · **m** menor.

| ID | Verificação | Sev |
|---|---|---|
| H-01 | `domain` sem biblioteca externa ou framework | B |
| H-02 | `domain` não importa application, adapters nem outro módulo | B |
| H-03 | `application` sem adapters nem biblioteca externa | B |
| H-04 | Adapter de entrada não importa adapter de saída (e vice-versa) | B |
| H-05 | Módulo só importa o `api/` de outro | B |
| H-06 | Sem ciclos de dependência | B |
| H-07 | Toda saída (banco, HTTP, fila, outro módulo) passa por porta de saída | B |
| H-08 | Controllers sem regra de negócio nem mutação direta de agregado | M |
| H-09 | Application sem cálculo de negócio (percentuais, faixas, fórmulas) | M |
| H-10 | Adapter de saída não decide fluxo de negócio | M |
| H-11 | Agregado sem setters públicos; muda estado por método de negócio | M |
| H-12 | Domínio é diferente do modelo de persistência (existe mapeador) | M |
| H-13 | Dinheiro não é decimal flutuante | M |
| H-14 | Cada porta de entrada = uma intenção; sem serviço gigante | m |
| H-15 | Schema ou prefixo por módulo; sem chave estrangeira ou JOIN entre módulos | B |
| H-16 | Variáveis de ambiente só na configuração do `bootstrap` | M |
| H-17 | Health check no formato da [[observability]] | M |
| H-18 | Sem log solto (use o logger) e sem tipo "qualquer" sem justificativa | M |
| H-19 | Cobertura mínima de [[quality]] atingida | M |
| H-20 | Auditoria de dependências sem alta ou crítica | B |
| H-21 | README e `.env.example` presentes | m |
| H-22 | Composição só na composição do módulo; `bootstrap` não importa camadas internas | M |

---

## 13. Auditar um repo existente

Auditar é **somente leitura** até o humano aprovar o plano; o ajuste vem por task de SDD.

1. **Classificar o layout:**

| Layout | Sinais | Caminho |
|---|---|---|
| A. Em camadas / MVC | controllers, services, models | migrar por caso de uso |
| B. Parcialmente hexagonal | já há domain e portas, com vazamentos | corrigir violações |
| C. Hexagonal conforme | estrutura da §4 | fechar lacunas de configuração |
| D. Sem estrutura | tudo misturado | tratar como A, começando pelo contexto mais rico |

2. **Rodar a verificação de arquitetura em modo aviso** (sem alterar código) e anotar as violações por regra.
3. **Preencher o checklist H-xx** com evidência (arquivo e linha, ou saída do comando). O que não puder ser verificado vai em "não verificado"; nunca marcar conforme por suposição.
4. **Relatório:** layout detectado, aderência (n de 22), bloqueantes abertos, tabela de resultado por item, violações por regra e plano de ajuste ordenado (uma task por PR).

### Ajuste incremental (depois da aprovação)
1. Ferramentas primeiro, sem mudar comportamento (lint, tipos, testes e verificação de arquitetura).
2. **Congelar a dívida:** registrar as violações atuais como conhecidas e impedir que cresçam; daí em diante, violação nova falha.
3. Criar a estrutura do módulo sem mover nada ainda.
4. Migrar **por caso de uso**, do mais rico em regra para o mais simples: teste de caracterização do comportamento atual → extrair a regra para o domínio → criar portas e serviço → mover banco/API para adapters de saída com mapeador → o controller antigo passa a chamar a porta → remover a violação da lista conhecida.
5. Fechar as fronteiras entre módulos (`api/` + anticorruption layer; separar dados).
6. Quando a lista de violações conhecidas esvaziar, apagá-la.

**Nunca:** reescrever o repo de uma vez; mudar regra de negócio ao mover código (mover e mudar comportamento são PRs separados); mudar contrato HTTP público sem task explícita.

### Anti-padrões e correção

| Anti-padrão | Correção |
|---|---|
| Entidade de domínio acoplada ao ORM | classe de domínio pura + mapeador + modelo de persistência no adapter |
| Domain service chamando API externa | porta de saída + adapter |
| Controller com regra de negócio | mover para o agregado; o controller só chama a porta |
| Serviço de aplicação com cálculo de negócio | mover para agregado ou domain service |
| Adapter decidindo fluxo (repositório dispara e-mail) | decisão sobe para a `application`; o adapter só persiste |
| Módulo usando internals do vizinho | `api/` + anticorruption layer |
| Serviço com dezenas de operações | dividir em portas coesas, uma por intenção |
| Modelo do vizinho vazando para o domínio | anticorruption layer traduz para tipos próprios |

---

## 14. Definition of Done

- [ ] Verificação completa verde (lint, tipos, arquitetura, testes com a cobertura de [[quality]], auditoria de dependências) e resultado real no relatório
- [ ] Prova de proteção feita (projeto novo ou módulo novo)
- [ ] Nenhuma biblioteca fora do `plan.md`; nenhum segredo; `.env` não versionado
- [ ] README atualizado
- [ ] Dúvidas de negócio registradas como `[NEEDS CLARIFICATION]`, não inventadas
- [ ] Nada commitado sem pedido

---

## 15. Evolução para microserviço

Para extrair um módulo (por exemplo `catalog`): o anticorruption layer do consumidor passa a chamar HTTP em vez do `api/` em memória; o assinante de evento troca o barramento em memória pela fila; o schema vira banco próprio. **Não mudam** `domain` nem `application` de nenhum dos dois lados. O novo serviço mantém a mesma estrutura.
