---
name: wi-ingest
description: Converte a doc de negócio de uma história (Word/PDF/MD no repo docs-compass) em work-item (brief) e, se pedido, em SDD técnico dentro do repo alvo. Uso manual.
argument-hint: <ID da história ou nome do arquivo> [alias-do-repo] [lite|standard]
disable-model-invocation: true
allowed-tools: Read Write Edit Glob Grep Bash(powershell *) Bash(git *)
---

# wi-ingest — doc de negócio → work-item → SDD

Argumentos: `$ARGUMENTS` → 1º = ID da história (`HU-142`) ou nome do arquivo; 2º (opcional) = alias do repo; 3º (opcional) = tier (`lite` padrão, `standard`).

## Pastas (relativas à raiz deste repo; pastas irmãs)
- `../docs-compass/` — repo com as docs de negócio recebidas (pode ter subpastas; busque recursivamente). Se ainda não existir com esse nome, tente `../solucao-doc-brq/` (nome local antigo). Nome: `AAAA-MM-DD_<ID>_<slug>.<ext>` (ex.: `2026-11-13_HU-142_pagamento-pix.docx`). O **ID** é o da história no seu tracker; a data é a de recebimento.
- `../work-items/<ID>-<slug>/` — saída de negócio: `brief.md`, `source.md`, `repos.md`.
- `../repos-project/<tipo>/<alias>/sdd/<ID>-<slug>/` (tipo = `apis`, `microservices`, …) — saída técnica (versionada com o código).

## Passos

1. **Localizar** o arquivo em `../docs-compass/` (Glob `../docs-compass/**/*<ID>*`). Se houver mais de uma versão, use a de data mais recente e avise. Nenhum achado → pare e liste os candidatos mais recentes.
2. **Extrair texto uma vez** para `../work-items/<ID>-<slug>/source.md`:
   - `.docx`: `powershell -NoProfile -ExecutionPolicy Bypass -File .claude/skills/wi-ingest/extract-docx.ps1 -Path <arquivo> -Out <source.md>`
   - `.md`/`.txt`: copie. `.pdf`: use a leitura de PDF do Read; se falhar, peça o texto.
   - Se `source.md` já existir e o arquivo não mudou, **não reextraia**.
3. **Escrever `brief.md`** com `templates/brief.md`. Só negócio: problema, valor, regras (`RN-n`), critérios, fora de escopo. Regras:
   - **Não invente.** Dúvida, contradição ou lacuna vira `[NEEDS CLARIFICATION: pergunta]`.
   - **Sem código, sem nome de classe/tabela/repo** no brief (a regra de ouro: work-item não conhece código).
   - Preserve os números e termos do negócio literalmente (prazos, valores, nomes de status).
   - Registre a origem: arquivo, data, ID.
4. **Parar e mostrar** ao usuário: resumo do brief + lista de `NEEDS CLARIFICATION`. Se houver pendências que bloqueiem o escopo, peça respostas antes de seguir. (Gate HITL 1.)
5. **Escolher o repo.** Sem alias no argumento, pergunte (ou use `repos.md` se já existir). Localize o clone com Glob `../repos-project/*/<alias>`; se não achar ou houver mais de um, pergunte.
6. **Investigar o repo de forma barata:** `Glob`/`Grep` por termos do brief para achar onde mexer; leia só os arquivos relevantes. Leia o `AGENTS.md`/`CLAUDE.md` do repo se existir e a [constitution](../../../eng-blueprint/constitution/constitution.md) apenas nas seções aplicáveis.
7. **Escrever o SDD** em `../repos-project/<tipo>/<alias>/sdd/<ID>-<slug>/` (tipo = `apis`, `microservices`, …) com `templates/sdd-lite.md` (ou, em `standard`, separe em `spec.md`/`plan.md`/`tasks.md`). Deve ter:
   - **Delta:** `ADDED / MODIFIED / REMOVED` + **O que NÃO muda**.
   - **Aceite** em Dado/Quando/Então, cada um apontando para a `RN-n` do brief.
   - **Context pack:** os arquivos de código que o agente deve ler (caminho + por quê).
   - **Constitution check:** só as seções que se aplicam.
   - **Tasks** pequenas, testáveis isoladamente, com `[ ]`, ligadas a `AC-n`.
8. **Atualizar `repos.md`** do work-item (linha: alias, caminho do SDD, tier, branch, estado `planejado`).
9. **Parar.** Não implemente. Mostre os caminhos criados e peça revisão (Gate HITL 2). Implementação é um passo separado: "implemente a primeira task `[ ]` de `<caminho do sdd>`".

## Quando usar `standard` em vez de `lite`
Mais de um módulo/serviço, contrato novo (API/evento), migração de dados ou tempo estimado > 1 dia.

## Não fazer
- Não copie o documento inteiro para dentro do SDD; referencie `RN-n`.
- Não edite o arquivo original em `docs-compass/`.
- Não crie commits nem branches.
