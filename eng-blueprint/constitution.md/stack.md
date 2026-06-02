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

Qualquer linguagem, provedor ou ferramenta fora desta lista requer:

1. Proposta em formato ADR em `docs/adr/`
2. Aprovação do arquiteto responsável
3. Registro em [[governance]] antes de qualquer implementação

Implementações sem ADR aprovado são consideradas experimentais e não chegam a produção.

---

## Nomenclatura de branches

```
feat/descricao-curta      ← nova funcionalidade
fix/descricao-curta       ← correção de bug
chore/descricao-curta     ← tarefa técnica sem impacto funcional
docs/descricao-curta      ← documentação
refactor/descricao-curta  ← refatoração sem mudança de comportamento
```
