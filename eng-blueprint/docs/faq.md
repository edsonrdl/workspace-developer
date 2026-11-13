# FAQ e evolução de padrões

## Como um padrão vira playbook?

Quando uma decisão técnica se repete em dois ou mais projetos:

1. **Identificar** — aparece no `plan.md` de dois SDDs diferentes
2. **Propor** — ADR em `docs/adr/` do repo de origem
3. **Revisar** — aprovação do arquiteto responsável (ver [[governance]])
4. **Publicar** — mover para o arquivo adequado em `playbooks/`
5. **Referenciar** — os `plan.md` passam a apontar `[[nome-do-playbook]]`

## Os clones precisam ficar dentro do vault?

Não mais. No modelo atual os clones ficam em `repos-project/`, pasta irmã deste vault. Os links `[[ ]]` do Obsidian só resolvem dentro do vault; o agente segue pelo nome do arquivo ou por caminho relativo. Decisão sobre wikilinks vs. links relativos: ver "Decisões em aberto" no [PLANO.md](../PLANO.md).

## E se um projeto não usar TypeScript/Node?

[[stack]] define TypeScript como padrão. Outra stack exige aprovação do arquiteto e ADR ([[governance]]). Novos playbooks podem ser criados sem alterar a constitution.

## Posso usar sem Obsidian?

Sim: é Markdown puro. O Obsidian serve para navegar e validar links visualmente.

## O agente pode quebrar a constitution?

Só se a spec não mandar ler `[[constitution]]` antes de agir. A constitution tem prioridade sobre playbooks e specs.
