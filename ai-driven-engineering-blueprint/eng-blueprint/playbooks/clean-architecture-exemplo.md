---
name: clean-architecture-exemplo
description: Exemplo explicativo da Clean Architecture com Java e Spring, usando 3 casos de uso (criar, buscar e listar cliente). Mostra onde cada classe fica, quem conhece quem, quem cria os interactors (o Spring, pelo @Service), como a application chega ao repositório e onde fica cada mapper. Documento de leitura, não é um projeto.
status: proposto
---

# Exemplo: Clean Architecture com Java e Spring

> Este documento é **só para ler**. Ele mostra a estrutura de [[clean-architecture]] aplicada em Java e Spring Boot, com **3 casos de uso**: criar cliente, buscar cliente e listar clientes. Os trechos de código são esboços para explicar a ideia, não um projeto para rodar.

---

## 1. Os 4 anéis, e quem conhece quem

```
   webapi  ──►  infrastructure  ──►  application  ──►  domain
 (anel 4)         (anel 3)           (anel 2)          (anel 1)
```

A seta significa "conhece" (faz `import`). O anel de dentro **nunca** conhece o de fora.

| Anel | Pasta | O que tem | Importa Spring/JPA? |
|---|---|---|---|
| 1 | `domain` | entidade `Client`, contrato `ClientRepository`, erro `ClientNotFoundException` | **não** |
| 2 | `application` | os 3 casos de uso (interface + input + output + interactor) | só a anotação `@Service` (marcador de DI) |
| 3 | `infrastructure` | modelo do banco, Spring Data, mapper, `ClientRepositoryImpl` | sim (JPA) |
| 4 | `webapi` | controller, DTOs, tratamento de erros | sim (Web) |

---

## 2. Estrutura de pastas

```
com.example.clientes/
│
├── domain/                                  ← ANEL 1
│   ├── entities/Client
│   ├── gateways/ClientRepository            ← contrato: o que o negócio exige do mundo
│   └── errors/ClientNotFoundException
│
├── application/usecases/                    ← ANEL 2
│   ├── createclient/
│   │   ├── CreateClientUseCase              ← interface (contrato de entrada)
│   │   ├── CreateClientInput
│   │   ├── CreateClientOutput
│   │   └── CreateClientInteractor           ← implementa a interface
│   ├── getclient/
│   │   └── GetClientUseCase · Input · Output · Interactor
│   └── listclients/
│       └── ListClientsUseCase · Input · Output · Interactor
│
├── infrastructure/persistence/              ← ANEL 3
│   ├── ClientModel                          ← @Entity do JPA (modelo do banco)
│   ├── ClientJpaRepository                  ← Spring Data
│   ├── ClientMapper                         ← Client ↔ ClientModel
│   └── ClientRepositoryImpl                 ← implementa ClientRepository
│
└── webapi/                                  ← ANEL 4
    ├── controllers/ClientController
    ├── dtos/ CreateClientRequest · ClientResponse
    └── handlers/ApiExceptionHandler
```

---

## 3. Anel 1: domain

Nada de Spring, nada de JPA. É Java puro.

```java
// domain/entities/Client.java
public class Client {
    private final Long id;
    private final String name;
    private final String email;

    private Client(Long id, String name, String email) {
        if (name == null || name.isBlank()) throw new IllegalArgumentException("Nome é obrigatório");
        if (email == null || !email.contains("@")) throw new IllegalArgumentException("E-mail inválido");
        this.id = id; this.name = name; this.email = email;
    }
    public static Client create(String name, String email) { return new Client(null, name, email); }
    public static Client restore(Long id, String name, String email) { return new Client(id, name, email); }
    public Long id() { return id; }
    public String name() { return name; }
    public String email() { return email; }
}
```

A regra "e-mail precisa ter @" mora **na entidade**, não no controller nem no caso de uso.

```java
// domain/gateways/ClientRepository.java
// CONTRATO de saída: o domínio diz O QUE precisa, sem saber COMO.
public interface ClientRepository {
    Client save(Client client);
    Optional<Client> findById(Long id);
    List<Client> findAll(int page, int size);
    long countAll();
}
```

Repare que o contrato fala em `Client` (do domínio), **nunca** em `ClientModel` (do banco).

```java
// domain/errors/ClientNotFoundException.java
public class ClientNotFoundException extends RuntimeException {
    public ClientNotFoundException(Long id) { super("Cliente " + id + " não encontrado"); }
}
```

---

## 4. Anel 2: application (os 3 casos de uso)

Cada caso de uso tem 4 peças: a **interface**, o **input**, o **output** e o **interactor** que implementa a interface.

### 4.1 Criar cliente

```java
public interface CreateClientUseCase {                       // contrato de ENTRADA
    CreateClientOutput execute(CreateClientInput input);
}
public record CreateClientInput(String name, String email) {}
public record CreateClientOutput(Long id, String name, String email) {}

@Service
public class CreateClientInteractor implements CreateClientUseCase {
    private final ClientRepository repository;               // contrato do domain
    public CreateClientInteractor(ClientRepository repository) { this.repository = repository; }

    @Override
    public CreateClientOutput execute(CreateClientInput in) {
        Client saved = repository.save(Client.create(in.name(), in.email()));  // a regra valida no domain
        return new CreateClientOutput(saved.id(), saved.name(), saved.email());
    }
}
```

### 4.2 Buscar cliente

```java
public interface GetClientUseCase { GetClientOutput execute(GetClientInput input); }
public record GetClientInput(Long id) {}
public record GetClientOutput(Long id, String name, String email) {}

@Service
public class GetClientInteractor implements GetClientUseCase {
    private final ClientRepository repository;
    public GetClientInteractor(ClientRepository repository) { this.repository = repository; }

    @Override
    public GetClientOutput execute(GetClientInput in) {
        Client c = repository.findById(in.id())
                .orElseThrow(() -> new ClientNotFoundException(in.id()));   // erro de domínio
        return new GetClientOutput(c.id(), c.name(), c.email());
    }
}
```

### 4.3 Listar clientes

```java
public interface ListClientsUseCase { ListClientsOutput execute(ListClientsInput input); }
public record ListClientsInput(int page, int size) {}
public record ListClientsOutput(List<Item> clients, long total) {
    public record Item(Long id, String name, String email) {}
}

@Service
public class ListClientsInteractor implements ListClientsUseCase {
    private final ClientRepository repository;
    public ListClientsInteractor(ClientRepository repository) { this.repository = repository; }

    @Override
    public ListClientsOutput execute(ListClientsInput in) {
        var items = repository.findAll(in.page(), in.size()).stream()
                .map(c -> new ListClientsOutput.Item(c.id(), c.name(), c.email()))
                .toList();
        return new ListClientsOutput(items, repository.countAll());
    }
}
```

### O que os interactors têm em comum
- **Só o marcador `@Service`** do Spring (ver seção 6.3). Sem `@Cacheable` nem outro comportamento de framework.
- Dependem **só** do contrato `ClientRepository`, que é do domínio.
- **Só orquestram:** chamam o domínio e o contrato, e devolvem um output.
- Devolvem `Output` (dados simples), **nunca** `ClientModel`.

---

## 5. Anel 3: infrastructure

É aqui que a tecnologia aparece. O banco e o JPA ficam **confinados** nesta pasta.

```java
// infrastructure/persistence/ClientModel.java  ← modelo do BANCO, diferente do Client do domínio
@Entity @Table(name = "clients")
public class ClientModel {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private String name;
    private String email;
    // getters e setters
}

// ClientJpaRepository.java  ← Spring Data
public interface ClientJpaRepository extends JpaRepository<ClientModel, Long> {}

// ClientMapper.java  ← converte entre domínio e banco
@Component
public class ClientMapper {
    public ClientModel toModel(Client c) { /* copia id, name, email */ }
    public Client toDomain(ClientModel m) { return Client.restore(m.getId(), m.getName(), m.getEmail()); }
}

// ClientRepositoryImpl.java  ← IMPLEMENTA o contrato do domínio
@Repository
public class ClientRepositoryImpl implements ClientRepository {
    private final ClientJpaRepository jpa;
    private final ClientMapper mapper;
    // construtor...

    @Override public Client save(Client c) { return mapper.toDomain(jpa.save(mapper.toModel(c))); }
    @Override public Optional<Client> findById(Long id) { return jpa.findById(id).map(mapper::toDomain); }
    @Override public List<Client> findAll(int page, int size) {
        return jpa.findAll(PageRequest.of(page, size)).stream().map(mapper::toDomain).toList();
    }
    @Override public long countAll() { return jpa.count(); }
}
```

Se um dia você trocar de banco, **só esta pasta muda**. O domínio e os casos de uso não mudam.

> Cache (`@Cacheable`) também é tecnologia: ele iria aqui, por exemplo em uma classe que envolve o `ClientRepositoryImpl`, e não na `application`.

---

## 6. Anel 4: webapi

### 6.1 Controller

O controller é **fino**: só traduz HTTP em chamada de caso de uso. Ele depende das **interfaces** dos casos de uso.

```java
@RestController @RequestMapping("/clients")
public class ClientController {
    private final CreateClientUseCase createClient;    // interface, não o interactor
    private final GetClientUseCase getClient;
    private final ListClientsUseCase listClients;
    // construtor...

    @PostMapping
    public ResponseEntity<ClientResponse> create(@Valid @RequestBody CreateClientRequest r) {
        var out = createClient.execute(new CreateClientInput(r.name(), r.email()));
        return ResponseEntity.status(201).body(new ClientResponse(out.id(), out.name(), out.email()));
    }

    @GetMapping("/{id}")
    public ClientResponse get(@PathVariable Long id) {
        var out = getClient.execute(new GetClientInput(id));
        return new ClientResponse(out.id(), out.name(), out.email());
    }

    @GetMapping
    public ListClientsOutput list(@RequestParam int page, @RequestParam int size) {
        return listClients.execute(new ListClientsInput(page, size));
    }
}
```

### 6.2 Tratamento de erros

```java
@RestControllerAdvice
public class ApiExceptionHandler {
    @ExceptionHandler(ClientNotFoundException.class)           // erro de domínio → HTTP 404
    public ResponseEntity<Map<String, String>> notFound(ClientNotFoundException e) {
        return ResponseEntity.status(404).body(Map.of("error", e.getMessage()));
    }
}
```

### 6.3 Quem cria os interactors: o próprio Spring, pelo `@Service`

Os interactors levam `@Service`. O Spring acha as classes sozinho, cria os objetos e injeta o `ClientRepository` pelo construtor. **Não é preciso nenhuma classe de configuração** (nenhum `@Configuration` nem `@Bean`): o `ClientConfig` seria redundante aqui.

```java
@Service
public class GetClientInteractor implements GetClientUseCase { ... }
```

**Qual é a dependência real do `@Service`?** O interactor passa a importar `org.springframework.stereotype.Service`. Vale avaliar o tamanho disso:

| Pergunta                                                 | Resposta                                                                                                |
| -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Traz comportamento do Spring para dentro do caso de uso? | **Não.** É só um marcador. A lógica do interactor não muda                                              |
| O caso de uso deixa de funcionar sem o Spring?           | **Não.** Continua sendo uma classe comum: `new GetClientInteractor(repositorioFalso)` funciona no teste |
| É caro de remover?                                       | **Não.** Basta apagar a anotação e registrar o objeto de outra forma                                    |
| Cria dependência para os anéis de fora?                  | **Não**                                                                                                 |

Por isso o template aceita essa anotação como **exceção** na `application` (ver [[clean-architecture]] §6.3).

**O que quebra a regra de verdade** não é o `@Service`, e sim:
- o interactor **importar a `infrastructure`** (o `IClientDAO`, o `ClientModel` ou o mapper de lá);
- o interactor ter **comportamento** de framework, como o `@Cacheable`.

> **Variante mais pura (opcional):** um time que queira a `application` sem nenhum import do Spring pode tirar o `@Service` e registrar cada interactor com um `@Bean` em uma classe `@Configuration` na camada `webapi`. É mais código para o mesmo resultado, então este exemplo não faz isso.

#### O caminho de uma requisição

```
GET /clients/5
   │
   ▼
ClientController                       (webapi)
   │  chama a interface GetClientUseCase
   ▼
GetClientInteractor                    (application)   ← criado pelo Spring (@Service)
   │  chama a interface ClientRepository
   ▼
ClientRepositoryImpl                   (infrastructure) ← criado pelo Spring (@Repository)
   │  usa o JPA e o mapper
   ▼
Banco de dados
```

---

## 7. Como a `application` chega ao repositório

Uma dúvida comum: se o interactor não pode conhecer a `infrastructure`, **quem ele chama** para salvar no banco? Ele chama a **interface** `ClientRepository` (do `domain`). Em tempo de execução, quem responde é o `ClientRepositoryImpl`, e quem faz essa troca é o Spring, pela injeção de dependência.

### No interactor

```java
@Service
public class CreateClientInteractor implements CreateClientUseCase {

    private final ClientRepository repository;      // tipo = a INTERFACE do domain

    public CreateClientInteractor(ClientRepository repository) {   // o Spring entrega aqui
        this.repository = repository;
    }

    @Override
    public CreateClientOutput execute(CreateClientInput in) {
        Client saved = repository.save(Client.create(in.name(), in.email()));  // chama a interface
        return new CreateClientOutput(saved.id(), saved.name(), saved.email());
    }
}
```

O interactor **só escreve o nome da interface**. Ele nunca escreve `ClientRepositoryImpl` e nunca faz `new` dela.

### Na implementação

```java
@Repository                                                         // "esta classe existe"
public class ClientRepositoryImpl implements ClientRepository { }   // "e ela É um ClientRepository"
```

### O que o Spring faz ao subir a aplicação

```
1. Acha o @Repository  →  ClientRepositoryImpl          (que implementa ClientRepository)
2. Acha o @Service     →  CreateClientInteractor         (que pede um ClientRepository no construtor)
3. Raciocina: "o interactor pediu um ClientRepository;
               eu tenho um ClientRepositoryImpl, que é um ClientRepository"
4. Cria o ClientRepositoryImpl e o entrega no construtor do interactor
```

### Por que a `application` não depende da `infrastructure`

```
CÓDIGO (quem importa quem):

  CreateClientInteractor ──importa──► ClientRepository (interface)  ◄──importa── ClientRepositoryImpl
        (application)                      (domain)                              (infrastructure)

EXECUÇÃO (quem é chamado):

  CreateClientInteractor ──chama──► ClientRepositoryImpl
```

No **código**, os dois só importam a interface, que está no meio. Na **execução**, a chamada chega na implementação, porque o Spring a ligou. Esse é o ponto da inversão de dependência: o `import` aponta para dentro, mas a chamada vai para fora.

### Casos especiais

- **Duas implementações da mesma interface** (por exemplo, o repositório normal e um com cache): o Spring não sabe qual escolher. Marque uma com `@Primary` ou indique o nome com `@Qualifier`.
- **Sem Spring (nos testes):** faça a ligação à mão, passando uma implementação falsa: `new CreateClientInteractor(new InMemoryClientRepository())`.
- **Montagem manual:** uma classe `@Configuration` faz esse mesmo `new` com `@Bean`, em vez de o Spring descobrir pelas anotações (a variante descrita no fim da seção 6.3).

---

## 8. Mappers: onde cada um fica

**Regra que resume:** cada mapper fica na camada que conhece o formato "de fora". O modelo do banco e o JSON externo são tecnologia, então vão para a `infrastructure`. O request e o response HTTP são do `webapi`. O mapper da `application` só conhece tipos da própria `application` e do `domain`.

| # | Mapper | Converte | Onde fica |
|---|---|---|---|
| 1 | Entity ↔ modelo do banco | `Client` ↔ `ClientModel` | `infrastructure/persistence` |
| 2 | Resposta de API externa → modelo do módulo | JSON do provedor → `Client` | `infrastructure/<integração>` (dentro do adapter) |
| 3 | Entity → output do caso de uso | `Client` → `CreateClientOutput` | `application`, dentro do interactor |
| 4 | Request HTTP → input, e output → response | `CreateClientRequest` → `CreateClientInput` | `webapi` (controller ou DTO) |

### O caminho dos dados

```
CreateClientRequest   (webapi)
      ↓  mapper 4
CreateClientInput     (application)
      ↓  o interactor cria a entity
Client                (domain)
      ↓  mapper 1, dentro do repositório
ClientModel           (infrastructure) → banco
      ↑  mapper 1 (volta)
Client                (domain)
      ↑  mapper 3, no interactor
CreateClientOutput    (application)
      ↑  mapper 4
ClientResponse        (webapi)
```

Cada tipo só existe na sua camada: `ClientModel` na `infrastructure`, `Client` no `domain`, `Input` e `Output` na `application`, e `Request` e `Response` no `webapi`. Cada mapper fica na fronteira entre dois tipos.

### Mapper 1: entity ↔ modelo do banco (o mais importante)

O **contrato** do domínio não faz mapeamento nenhum: ele só diz "recebo uma entity e devolvo uma entity". Quem converte nos dois sentidos é a **implementação** do contrato.

```java
// domain/gateways/ClientRepository.java   (contrato: só entity)
public interface ClientRepository {
    Client save(Client client);
    Optional<Client> findById(Long id);
}

// infrastructure/persistence/ClientMapper.java   (conhece os dois lados)
@Component
public class ClientMapper {
    public ClientModel toModel(Client client) { /* entity → model */ }
    public Client toDomain(ClientModel model) { return Client.restore(model.getId(), model.getName(), model.getEmail()); }
}

// infrastructure/persistence/ClientRepositoryImpl.java   (usa o mapper POR DENTRO)
@Repository
public class ClientRepositoryImpl implements ClientRepository {
    private final ClientJpaRepository jpa;
    private final ClientMapper mapper;
    // construtor...

    @Override
    public Client save(Client client) {
        ClientModel saved = jpa.save(mapper.toModel(client));   // entity → model (para gravar)
        return mapper.toDomain(saved);                          // model → entity (para devolver)
    }

    @Override
    public Optional<Client> findById(Long id) {
        return jpa.findById(id).map(mapper::toDomain);          // model → entity (para devolver)
    }
}
```

A `application` só vê `repository.save(entity)`. Ela não chama o mapper, não vê o `ClientModel` e não sabe se por baixo é JPA ou outra coisa.

> **Não ponha o mapper no contrato.** Um contrato com `toModel` e `toDomain` obrigaria o `domain` a conhecer o `ClientModel`, que é do banco. Isso é mais grave do que pôr o mapper na `application`. A saída é a de cima: o contrato fala só em entity, e a conversão é um detalhe da implementação.

### Mapper 2: resposta de API externa (dentro do adapter)

```java
// infrastructure/crm/CrmClientGateway.java   (implementa um gateway do domínio)
@Component
public class CrmClientGateway implements ExternalClientGateway {
    @Override
    public Client findByDocument(String document) {
        CrmResponse response = http.get(".../customers?doc=" + document);        // formato do provedor
        return Client.restore(null, response.fullName(), response.mailAddress()); // modelo seu
    }
}
```

O domínio nunca vê `CrmResponse` nem os nomes `fullName` e `mailAddress`.

### Mappers 3 e 4

Já aparecem nas seções 4 e 6: o interactor monta o `Output` a partir da entity (conversão simples, sem tecnologia), e o controller converte request em input e output em response.

---

## 9. Teste do caso de uso, sem Spring

Como o interactor é uma classe comum, o teste usa só `new` e um repositório falso:

```java
class InMemoryClientRepository implements ClientRepository {      // implementação FALSA do contrato
    private final List<Client> store = new ArrayList<>();
    private final AtomicLong seq = new AtomicLong(1);

    public Client save(Client c) {
        Client saved = Client.restore(seq.getAndIncrement(), c.name(), c.email());
        store.add(saved);
        return saved;
    }
    public Optional<Client> findById(Long id) { return store.stream().filter(c -> c.id().equals(id)).findFirst(); }
    public List<Client> findAll(int page, int size) { return store.stream().skip((long) page * size).limit(size).toList(); }
    public long countAll() { return store.size(); }
}

class ClientUseCasesTest {
    private final InMemoryClientRepository repository = new InMemoryClientRepository();
    private final CreateClientInteractor create = new CreateClientInteractor(repository);
    private final GetClientInteractor get = new GetClientInteractor(repository);

    @Test
    void createsAndGetsAClient() {
        var created = create.execute(new CreateClientInput("Ana", "ana@email.com"));
        var found = get.execute(new GetClientInput(created.id()));
        assertEquals("Ana", found.name());
    }

    @Test
    void failsWhenClientDoesNotExist() {
        assertThrows(ClientNotFoundException.class, () -> get.execute(new GetClientInput(99L)));
    }

    @Test
    void rejectsInvalidEmailByDomainRule() {
        assertThrows(IllegalArgumentException.class,
                () -> create.execute(new CreateClientInput("Ana", "sem-arroba")));
    }
}
```

Roda em milissegundos, sem banco e sem Spring.

---

## 10. Resumo: onde está cada coisa

| Eu quero... | Onde fica |
|---|---|
| Validar que o e-mail tem `@` | `domain/entities/Client` |
| Dizer "preciso salvar um cliente" | `domain/gateways/ClientRepository` (contrato) |
| Salvar de verdade no banco | `infrastructure/persistence/ClientRepositoryImpl` |
| Orquestrar "criar cliente" | `application/usecases/createclient/CreateClientInteractor` |
| Receber o HTTP e chamar o caso de uso | `webapi/controllers/ClientController` |
| Transformar erro de domínio em 404 | `webapi/handlers/ApiExceptionHandler` |
| Ligar o interactor ao repositório | o Spring injeta pelo construtor (`@Service` no interactor, `@Repository` na implementação), como na seção 7 |
| Converter entity ↔ modelo do banco | `infrastructure/persistence/ClientMapper`, usado só pelo repositório (seção 8) |
| Converter request/response HTTP | `webapi` (controller ou DTO) |
| Cache | `infrastructure` (nunca na `application`) |

---

## 11. Erros comuns (e como evitar)

| Erro | Correção |
|---|---|
| `application` importa algo de `infrastructure` | o contrato vai para `domain/gateways`; a implementação fica na `infrastructure` |
| Caso de uso devolve `ClientModel` | devolver um `Output`; o modelo do banco não sai da `infrastructure` |
| Mapper do banco chamado dentro do caso de uso | o mapper fica dentro do `ClientRepositoryImpl`; o contrato só fala em entity (seção 8) |
| Contrato do domínio com `toModel` e `toDomain` | o contrato fala só em entity; a conversão é detalhe da implementação |
| Interactor escreve `new ClientRepositoryImpl()` | o interactor só conhece a interface; o Spring injeta a implementação (seção 7) |
| Uma classe com todas as operações (criar, buscar, listar, atualizar, apagar) | um caso de uso por intenção |
| `RuntimeException("não encontrado")` genérica | erro de domínio, traduzido pelo handler |
| `Map<String, Object>` como retorno | um `Output` tipado |
| `@Cacheable` (ou outro comportamento de framework) na `application` | cache na `infrastructure`. O `@Service` em si é aceito |
