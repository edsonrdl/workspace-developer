# sdd-template — Como usar

> Template geral de Spec-Driven Development para usar com agentes de IA.
> Copie esta pasta para a raiz do seu projeto como `sdd/`, preencha os arquivos na ordem abaixo e instrua o agente com um único comando.

---

## Como aplicar em um novo projeto

```bash
# 1. Copie o template para a raiz do seu projeto
cp -r sdd-template/ seu-projeto/sdd/

# 2. Preencha os arquivos na ordem obrigatória
# 3. Abra no Obsidian para validar os links
# 4. Instrua o agente:
#    "Siga as especificações em sdd/spec.md"
```

---

## Ordem de preenchimento (e de leitura pelo agente)

```
spec.md → requirements.md → contracts.md → acceptance.md → plan.md → tasks.md
```

Cada arquivo tem um papel único. **Não repita informação entre eles** — use `[[links]]` para referenciar.

| Arquivo | Você responde | O agente usa para |
|---|---|---|
| `spec.md` | *Por que isso existe?* | Entender o contexto antes de qualquer decisão |
| `requirements.md` | *O que precisa ser feito?* | Saber o que implementar e o que **não** implementar |
| `contracts.md` | *O que vai ser produzido?* | Saber exatamente as interfaces, modelos e eventos |
| `acceptance.md` | *Como validar?* | Escrever testes e saber quando uma task está concluída |
| `plan.md` | *Como vai ser construído?* | Tomar decisões técnicas sem adivinhar |
| `tasks.md` | *Em que ordem fazer?* | Implementar atomicamente, marcar `[x]` e retomar sessões |

---

## Princípios do template

**1. Cada arquivo declara apenas o que é único seu.**
O que já está em `[[constitution]]` ou `[[microservice]]` não se repete — apenas referencia.

**2. Links são a memória do sistema.**
`[[requirements]]`, `[[contracts]]`, `[[plan]]` dentro dos arquivos criam o grafo que o Obsidian visualiza e o agente percorre.

**3. Non-Goals são tão importantes quanto Goals.**
Listar explicitamente o que está *fora do escopo* evita que o agente over-engineer e que o time discuta o que já foi decidido.

**4. Tasks seguem o princípio INVEST.**
Cada task deve ser: **I**ndependente, **N**egociável, **V**aliosa, **E**stimável, **S**mall (pequena), **T**estável. Se uma task não pode ser testada isoladamente, ela deve ser dividida.

**5. Decisões técnicas têm rationale e alternativas rejeitadas.**
`plan.md` não apenas diz *o que* foi decidido — diz *por que* e *o que foi considerado e descartado*. Isso evita que o agente (ou um novo dev) reabra decisões já tomadas.

---

## Quando cada arquivo está pronto

- **`spec.md`** — quando qualquer pessoa que leia entende o problema e o escopo em menos de 2 minutos
- **`requirements.md`** — quando cada requisito tem um ID único (FR-xxx / NFR-xxx) e pode ser testado individualmente
- **`contracts.md`** — quando um dev de outro time consegue integrar sem precisar perguntar nada
- **`acceptance.md`** — quando você consegue responder "a feature está pronta" sem ambiguidade
- **`plan.md`** — quando o agente não precisa tomar nenhuma decisão técnica por conta própria
- **`tasks.md`** — quando cada task pode ser implementada e testada sem depender de outra `[ ]`

---

## Referências externas

- [Spec-Driven Development: The Definitive Guide (Augment Code)](https://www.augmentcode.com/guides/what-is-spec-driven-development)
- [EARS: Easy Approach to Requirements Syntax](https://alistairmavin.com/ears/)
- [Understanding SDD Tools: Kiro, spec-kit, Tessl (Martin Fowler)](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
- [SpecOps 2026 — Workshop Acadêmico Internacional](https://conf.researchr.org/home/splash-issta-2026/specops-2026)
