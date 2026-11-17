# Engineering Playbooks

> **Estes não são design patterns genéricos.**
> São as decisões arquiteturais padronizadas desta empresa — o "como nós construímos software aqui".
> Cada arquivo define como construímos um tipo específico de sistema, com as escolhas já tomadas,
> os trade-offs já avaliados e as regras que todo agente e todo dev devem seguir.

---

## O que é um playbook

Um playbook responde: *"quando precisar construir X nesta empresa, como fazemos?"*

Ele não descreve todas as formas possíveis de fazer algo — descreve **a forma que adotamos aqui**, com o rationale. Isso elimina decisões repetidas a cada projeto e dá ao agente de IA contexto suficiente para implementar sem adivinhar.

---

## Relação com a constitution e com o sdd

```
constitution/          → o que é lei universal — nunca violável
    ↓ estendido por
playbooks/            → como implementar essa lei em cada arquitetura
    ↓ referenciado por
sdd/ do projeto        → o que é específico deste projeto
```

Os playbooks **não repetem** o que está na `constitution/` — apenas referenciam e adicionam o que é específico de cada arquitetura.

Os `sdd/plan.md` dos projetos **não repetem** o que está nos playbooks — apenas referenciam e declaram as decisões únicas do projeto.

---

## Playbooks disponíveis

| Arquivo | Quando usar |
|---|---|
| [[microservice]] | Construindo um serviço independente com deploy próprio |
| [[rest-api]] | Expondo endpoints HTTP — contratos, envelope, autenticação |
| [[modular-monolith]] | Aplicação única com módulos bem delimitados |
| [[hexagonal]] | Template descritivo de Ports & Adapters: estrutura de pastas, responsabilidade de cada camada e onde fica cada código |
| [[clean-architecture]] | Template descritivo de Entities / Use Cases / Interface Adapters / Frameworks, com a mesma estrutura de leitura |

> `hexagonal` e `clean-architecture` são **alternativas independentes**: escolha uma por projeto e registre a escolha em Decisões no `plan.md`. Ambas descrevem a arquitetura sem código e sem linguagem específica; as bibliotecas e ferramentas vêm do `plan.md`.

---

## Como adicionar um novo playbook

Quando uma decisão técnica se repete em dois ou mais SDDs (`plan.md` → Decisões), promova-a: crie o `.md` aqui e passe os `plan.md` a referenciá-lo. Decisões experimentais ficam no `plan.md` até se repetirem.
