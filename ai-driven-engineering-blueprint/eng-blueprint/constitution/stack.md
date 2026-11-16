# Stack — Linguagem e tecnologias aprovadas

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.

---

## Stack aprovada

| Camada | Tecnologia aprovada | Observação |
|---|---|---|
| Linguagem | TypeScript | Strict mode obrigatório |
| Runtime | Node.js LTS vigente | Sem versões odd (ex: 19, 21) |
| Cloud | AWS | Único provedor aprovado |
| Infraestrutura como código | Terraform ou AWS CDK | Escolha declarada no `plan.md` do projeto |
| Controle de versão | Git | Branches: `tipo/descricao-curta` |

---

## Adição de nova tecnologia

Qualquer linguagem, provedor ou ferramenta fora desta lista exige aprovação explícita do responsável **antes** de implementar, registrada em Decisões no `plan.md` do SDD (decisão, por quê, alternativa descartada). Sem isso, é experimental e não chega a produção.

---

## Nomenclatura de branches

```
feat/descricao-curta      ← nova funcionalidade
fix/descricao-curta       ← correção de bug
chore/descricao-curta     ← tarefa técnica sem impacto funcional
docs/descricao-curta      ← documentação
refactor/descricao-curta  ← refatoração sem mudança de comportamento
```
