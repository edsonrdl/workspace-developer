---
name: wi-ingest
description: Converte a doc de negócio de uma história (Word/PDF/MD no repo docs-compass) em brief e SDD técnico dentro do repo alvo. Uso manual.
argument-hint: <ID da história> [alias-do-repo] [fix|lite|standard]
disable-model-invocation: true
allowed-tools: Read Write Edit Glob Grep Bash(powershell *) Bash(git *)
---

# wi-ingest — doc de negócio → brief → SDD

Argumentos: `$ARGUMENTS` → 1º = ID da história (`HU-142`); 2º (opcional) = alias do repo; 3º (opcional) = tier. Tiers: `fix` (sem brief), `lite` (padrão), `standard`.

## Pastas (relativas à raiz deste repo; pastas irmãs)
- `../docs-compass/` — docs de negócio recebidas. Se não existir, tente `../solucao-doc-brq/` (nome local antigo). **Ignore** `corpus/` (é base de consulta, não entrada).
- `../work-items/<ID>-<slug>/` — `brief.md` e, só para `.docx`/`.pdf`, `source.md` (cache do texto extraído). Crie a pasta se faltar.
- `../repos-project/<tipo>/<alias>/sdd/<ID>-<slug>/` — SDD (tipo = `apis`, `microservices`, …), versionado com o código.

## Passos

1. **Localizar** o arquivo: Glob `../docs-compass/**/*<ID>*`, descartando `~$*` (lock do Word) e nomes em que o ID é seguido de dígito (`HU-14` ≠ `HU-142`). Convenção do nome: `AAAA-MM-DD_<ID>_<slug>.<ext>`; aceite também o ID solto. Várias versões → a mais recente, avise. Nada achado → liste os candidatos e pare.
2. **Extrair o texto uma vez.**
   - `.docx`: `powershell -NoProfile -File .claude/skills/wi-ingest/extract-docx.ps1 -Path <arquivo> -Out ../work-items/<ID>-<slug>/source.md`. Se a política de execução bloquear o script, **não contorne**: avise o usuário e sugira `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.
   - `.pdf`: leitor de PDF do Read; se falhar, peça o texto. `.md`/`.txt`: leia direto, **não copie** para `source.md`.
   - Se o extrator avisar (`AVISO`) de imagens, comentários ou alterações ignoradas, isso **entra no brief** como `[NEEDS CLARIFICATION]` e é dito ao usuário: o conteúdo desses elementos não foi lido.
   - Se `source.md` já existir e o arquivo não mudou, não reextraia.
3. **Brief** (`templates/brief.md`), exceto no tier `fix`. Só negócio: problema, valor, regras `RN-n`, critérios, fora de escopo.
   - **Não invente.** Dúvida, contradição ou lacuna → `[NEEDS CLARIFICATION: pergunta]`.
   - Sem classes, tabelas ou código. Preserve números e termos do negócio literalmente.
4. **Gate 1 — parar e mostrar** o resumo do brief e as dúvidas. Pendência que bloqueie o escopo → peça resposta antes de seguir. No tier `fix`, mostre só as dúvidas.
5. **Escolher o repo.** Sem alias, pergunte. Localize o clone com Glob `../repos-project/*/<alias>`; zero ou mais de um → pergunte.
6. **Investigar barato:** Glob/Grep por termos do brief, ler só o relevante, `AGENTS.md`/`CLAUDE.md` do repo e só as seções aplicáveis da [constitution](../../../eng-blueprint/constitution/constitution.md).
7. **SDD** com `templates/sdd-lite.md` (em `standard`, separe em `spec.md`/`plan.md`/`tasks.md`). Deve ter delta (ADDED/MODIFIED/REMOVED + NÃO muda), **cópia das RN relevantes** (o SDD não linka para fora do repo), aceite Dado/Quando/Então ligado às RN, context pack, constitution check e tasks pequenas e testáveis. No tier `fix`, as RN vêm direto da doc.
8. **Registrar o vínculo** no brief, na seção `## Implementação` (alias + caminho do SDD + estado `planejado`). Não crie `repos.md` a menos que o work-item afete mais de um repo.
9. **Gate 2 — parar.** Não implemente, não commite, não crie branch. Mostre os caminhos e peça revisão. Implementar é outro passo: "implemente a primeira task `[ ]` de `<caminho do sdd>`".

## Quando usar cada tier
- `fix`: correção pequena (doc curta, 1–2 arquivos). Sem brief; `source.md` + SDD lite.
- `lite`: padrão. `standard`: mais de um módulo, contrato novo (API/evento), migração ou > 1 dia.

## Não fazer
Não editar o original em `docs-compass/`; não copiar o documento inteiro para o SDD; não usar `-ExecutionPolicy Bypass`.
