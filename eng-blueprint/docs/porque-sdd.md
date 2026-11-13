# Por que SDD e economia de tokens

> Material de contexto — leia sob demanda, não é carregado pelo agente.

## O problema que este projeto resolve

### Vibe Code — o risco invisível

Com a ascensão de agentes de IA gerando código, surgiu um padrão silencioso de trabalho chamado **Vibe Code**: desenvolvimento guiado pela *sensação* de que está funcionando. A IA gera, o desenvolvedor aceita. Rápido no início — caro na escala.

| Sintoma | Consequência |
|---|---|
| IA decide arquitetura sozinha | Sem trilha de decisão auditável |
| Requisitos desacoplados do código | Ninguém sabe qual versão está vigente |
| Sem critério de aceite formal | Outputs frágeis produzidos mais rápido |
| Débito técnico mascarado de agilidade | Auditoria regulatória inviável |

**O problema central não é a IA em si — é a ausência de um contrato entre o que foi decidido e o que foi construído.**

---

### A solução: Especificação como código, governança como infraestrutura

O `eng-blueprint` é um **vault de engenharia** que funciona como a camada de governança do desenvolvimento orientado a IA. Ele responde à pergunta:

> *"Como garantir que o que a IA constrói reflete o que foi decidido pela engenharia, documentado formalmente e aprovado por um humano?"*

A resposta: **as specs vivem no repositório junto com o código**. A IA lê a spec antes de agir. A spec é a lei.

---

## Economia de tokens — por que spec-driven custa menos

Este é um benefício técnico direto que raramente é discutido: **desenvolvimento spec-driven consome significativamente menos tokens do que Vibe Code**.

### O problema de tokens no Vibe Code

No Vibe Code sem estrutura, cada sessão com o agente começa do zero:

```
Desenvolvedor: "Cria um microserviço de pagamentos"
Agente: "Claro! Qual banco de dados? Qual framework? Como quer tratar erros?
         Precisa de autenticação? Que tipo de eventos? Tem retry?..."
Desenvolvedor: [explica tudo novamente]
Agente: [implementa algo, mas não é bem o que foi pedido]
Desenvolvedor: "Não, quero que seja assim..."
Agente: [reescreve metade do código]
```

Cada rodada de correção consome tokens. Cada pergunta de clarificação consome tokens. Cada sessão nova onde o agente "esqueceu" o contexto consome tokens para reexplicar.

### Como o eng-blueprint reduz tokens

**1. Contexto escrito uma vez, reutilizado para sempre**

A `constitution/` e os `playbooks/` são escritos uma vez e referenciados por todos os projetos. Em vez de explicar "use timeout de 5s, retry com backoff exponencial, health check em /health" em cada sessão, o agente lê `[[microservice]]` e encontra tudo. Uma linha no spec substitui um parágrafo de instrução.

**2. Sem rodadas de clarificação**

O agente não pergunta "qual banco?", "como fazer retry?", "qual formato de resposta?" — tudo está na spec. O `contracts.md` define o modelo de dados exato. O `plan.md` define o banco, o ORM, a fila. O `acceptance.md` define o critério de aceite. **Zero ambiguidade = zero rodadas de clarificação = zero tokens desperdiçados.**

**3. `tasks.md` elimina retrabalho entre sessões**

Sem estado, uma sessão interrompida obriga o agente a "reconhecer" o que já foi feito — lendo arquivos existentes, inferindo o que está completo. Com `tasks.md`, o agente lê a lista, encontra a primeira `[ ]` e começa imediatamente. **Sem re-leitura, sem re-análise, sem tokens para descobrir o que já foi feito.**

**4. Sem repetição nos documentos**

Cada arquivo da `sdd/` declara apenas o que é *único* daquele nível. O `requirements.md` não repete as regras da `constitution.md` — apenas referencia. O `plan.md` não repete o que já está em `playbooks/microservice.md` — apenas declara as decisões específicas. **Menos tokens por leitura, mais sinal por token.**

**5. Primeira implementação correta**

O maior gasto de tokens no Vibe Code não é a geração inicial — é a *correção*. Um agente sem spec gera algo plausível mas errado; a correção pode custar 3x mais tokens que a geração original. Com spec completa, a taxa de acerto na primeira implementação é dramaticamente maior.

### Estimativa comparativa

| Cenário | Rodadas típicas | Tokens estimados |
|---|---|---|
| Vibe Code — feature nova | 4–8 rodadas de correção | ~50k–150k tokens |
| eng-blueprint — mesma feature | 1 rodada (ler spec + implementar) | ~15k–40k tokens |
| eng-blueprint — sessão retomada | Começa na primeira `[ ]` | ~5k–15k tokens |

> Os valores são estimativas baseadas em uso típico. O ganho real depende da complexidade da feature e da qualidade da spec.

**O investimento:** escrever a `sdd/` antes de implementar custa tokens. Mas esse custo é pago uma vez e recuperado em cada sessão subsequente — especialmente em projetos com múltiplas features, múltiplos desenvolvedores e múltiplas sessões de refinamento.
