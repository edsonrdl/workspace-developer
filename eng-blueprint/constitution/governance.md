# Governance — Processo de aprovação de padrões

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.

---

## Quando um ADR é obrigatório

| Situação | ADR obrigatório? |
|---|---|
| Nova linguagem ou provedor de cloud | ✅ Sim |
| Nova biblioteca de infraestrutura (banco, fila, cache) | ✅ Sim |
| Mudança em pattern existente (`patterns/`) | ✅ Sim |
| Mudança em seção da `constitution/` | ✅ Sim |
| Nova feature dentro do stack aprovado | ❌ Não — vai no `sdd/plan.md` |
| Decisão técnica específica de um projeto | ❌ Não — vai no `sdd/plan.md` |

---

## Processo de aprovação

```
1. Identificar → decisão se repete em 2+ projetos ou viola o que está nos patterns
       ↓
2. Propor → escrever ADR em docs/adr/ com status "Proposto"
       ↓
3. Revisar → arquiteto responsável revisa rationale e alternativas
       ↓
4. Decidir → aprovado: status "Aceito" + atualiza pattern ou constitution
             recusado: status "Recusado" + justificativa registrada
       ↓
5. Comunicar → time notificado antes de qualquer implementação
```

---

## Promovendo decisões de projeto para pattern

Quando uma decisão em `sdd/plan.md` se repete em dois ou mais projetos:

1. O autor do segundo projeto identifica o padrão duplicado
2. Abre ADR propondo a promoção para `playbooks/`
3. ADR aprovado → decisão migra para `playbooks/[nome].md`
4. Os dois projetos atualizam seus `sdd/plan.md` para referenciar `[[nome-do-pattern]]`

> Isso é como o vault evolui: decisões táticas se tornam padrões estratégicos.

---

## Autoridade de aprovação

| Tipo de mudança | Aprovador |
|---|---|
| Nova seção na `constitution/` | Arquiteto principal |
| Novo arquivo em `playbooks/` | Arquiteto responsável pela área |
| Mudança em `sdd/` de um projeto | Tech lead do projeto |
| Novo projeto em `repos-project/` | Qualquer dev — não requer aprovação |
