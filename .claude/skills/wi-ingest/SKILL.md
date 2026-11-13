---
name: wi-ingest
description: Converte a doc de negócio de uma história (Word/PDF/MD no repo docs-compass) em brief e SDD técnico dentro do repo alvo. Uso manual.
argument-hint: <ID da história> [alias-do-repo] [fix|lite|standard]
disable-model-invocation: true
allowed-tools: Read Write Edit Glob Grep Bash(powershell *) Bash(bash *) Bash(git *)
---

# wi-ingest — doc de negócio → brief → SDD

Argumentos: `$ARGUMENTS` → 1º = ID da história (`HU-142`); 2º (opcional) = alias do repo; 3º (opcional) = tier. Tiers: `fix` (sem brief), `lite` (padrão), `standard`.

## Pastas (irmãs da raiz deste repo; use caminhos relativos à raiz)
Glob, Read e Write usam **caminho absoluto**. Cada chamada de Bash começa em outro diretório: inicie todo comando com `cd <raiz do repo> &&` (assim `../work-items` e `.claude/...` funcionam).
- `../docs-compass/` — docs recebidas. Se não existir, tente `../solucao-doc-brq/`. **Ignore** `corpus/` (base de consulta, não entrada). A busca é recursiva: subpastas são aceitas. No campo "Origem" do brief, escreva o caminho relativo à pasta pai (ex.: `docs-compass/…` ou `solucao-doc-brq/…`, o que existir).
- `../work-items/<ID>-<slug>/` — `brief.md` e, só para `.docx`, `source.md` (PDF e MD são lidos direto, sem cópia). O extrator cria a pasta; para PDF/MD crie-a você ao escrever o brief.
- `../repos-project/<tipo>/<alias>/sdd/<ID>-<slug>/` — SDD (tipo = `apis`, `microservices`, …), versionado com o código.

**`<slug>`** = kebab-case do nome do arquivo sem a data e sem o ID (`2026-11-13_HU-142_pagamento-pix.docx` → `pagamento-pix`). Se o nome não tiver slug, derive do título do documento (até 5 palavras).

## Passos

1. **Localizar.** O Glob **não aceita `..` no padrão nem caminho relativo em `path`** (resolve contra outro diretório). Monte o **caminho absoluto**: a pasta pai da raiz deste repo (`git rev-parse --show-toplevel`; se falhar, o diretório de trabalho atual, uma pasta acima) + `docs-compass`. Use `path=<absoluto>/docs-compass`, `pattern=**/*<ID>*`. Vale para todas as pastas irmãs. Depois filtre à mão: descarte `~$*` (lock do Word) e nomes em que o ID é seguido de dígito (`HU-14` ≠ `HU-142`). Várias versões → a de data mais recente, e avise. Nada achado → liste os candidatos e pare.
2. **Extrair o texto uma vez.**
   - **Formato preferido: `.pdf` ou `.md`** (não exigem script nem permissão). `.pdf`: use o Read (ele lê texto **e** imagens/diagramas; use `pages` se passar de 10 páginas). `.md`/`.txt`: leia direto, **não copie** para `source.md`. Se vier `.docx` e houver um PDF/MD do mesmo documento, use esse.
   - `.docx`, escolha assim: **se `bash` e `unzip` existirem (Linux, macOS ou Git Bash no Windows), use o `.sh`** (não depende de política de execução); só se não existirem, use o `.ps1` (Windows).
     - **`.sh`:** `bash .claude/skills/wi-ingest/extract-docx.sh <arquivo> ../work-items/<ID>-<slug>/source.md` (precisa de `unzip` e `perl`; não depende de política nem de permissão de execução).
     - **`.ps1`:** `powershell -NoProfile -File .claude/skills/wi-ingest/extract-docx.ps1 -Path <arquivo> -Out ../work-items/<ID>-<slug>/source.md`.
   - Se o script for **bloqueado** (política de execução, `noexec`, ferramenta ausente, antivírus/EDR), **não contorne** (nem com `-Command` inline, `Bypass` ou copiando para outro lugar): pare e ofereça **uma** saída: (a) salvar o documento como `.pdf` ou `.md` em `docs-compass/` (Word: Arquivo → Salvar como → PDF); (b) colar o texto no chat; (c) liberar o script com a TI/usuário (Windows: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`). Só continue quando ele escolher.
   - **Não reextrair** se `source.md` existir e for **mais novo** (data de modificação) que o arquivo original.
   - Se o extrator avisar (`AVISO`) de imagens, comentários ou alterações ignoradas, isso vira `[NEEDS CLARIFICATION]` e é dito ao usuário: o conteúdo desses elementos não foi lido. No Gate 1, pergunte **uma vez** se há regra importante nesses elementos. Sem resposta, a dúvida segue `aberta (perguntado no Gate 1, sem resposta)` no brief (nunca "assumida" em silêncio).
3. **Brief** (`templates/brief.md`), exceto no tier `fix`. Só negócio. Regras:
   - **Não invente.** Campo de **contexto** que o documento não traz (solicitante, valor esperado, métrica) vira `não informado`, sem pergunta. **Regra de comportamento** ausente (o que fazer em exceção, entrada inválida, limite, o que um termo vago como "prazo" ou "promoção" significa) é dúvida de negócio: `[NEEDS CLARIFICATION: pergunta]`, também quando o documento se contradiz (ver Gate 1). Frase vaga sem regra verificável ("fazer do jeito de sempre") **não vira `RN`**: vira dúvida `aberta`.
   - Status inicial do brief: `ideia`.
   - Sem classes, tabelas ou código. Preserve números e termos do negócio literalmente.
4. **Gate 1 — parar e mostrar** o resumo do brief e as dúvidas. Uma dúvida é **bloqueante** se, sem resposta, não dá para escrever uma regra `RN-n` ou um aceite `AC-n`; é **não bloqueante** se só falta contexto (solicitante, métrica, prazo de entrega). **Comportamento que o negócio deve definir** (entrada inválida, limite excedido, exceção, o que o "prazo" mede) é dúvida **de negócio**: vai no brief e é bloqueante se faltar para o `AC`. Só estrutura e local do código são dúvida técnica (no SDD). Estados de uma dúvida, sempre escritos assim: `bloqueante`, `aberta`, `respondida: <resposta do usuário>` ou `assumida: <o que foi assumido>`. **Pergunte e espere** as bloqueantes. Se o usuário mandar seguir sem responder, escreva o SDD só com o que está definido: a `RN` sem resposta fica **sem `AC` e sem task**, marcada `bloqueante`. Não bloqueante sem resposta (ex.: conteúdo de imagens não lido) → `aberta`, não impede o SDD. Não bloqueante e o usuário disse "ok, siga" → `assumida: <o que>`. No tier `fix`, mostre só as dúvidas e registre-as em `vinculo.md`, seção `## Dúvidas`. Registre cada dúvida **onde ela nasceu** (brief, ou `vinculo.md` no `fix`); o SDD só a repete se ela muda um `AC`.
5. **Escolher o repo.** Sem alias, pergunte. Localize o clone **listando diretórios** (o Glob acha arquivos, não pastas): `bash -c "ls -d <absoluto>/repos-project/*/<alias>"`. Zero ou mais de um resultado → pergunte.
6. **Investigar barato:** Glob/Grep por termos do brief; leia só o relevante, o `AGENTS.md`/`CLAUDE.md` do repo (se não houver, siga sem e anote "sem AGENTS.md" no context pack) e as seções da [constitution](../../../eng-blueprint/constitution/constitution.md) pelo critério: `testing` e `quality` sempre; `security` se houver dado pessoal, credencial ou autenticação; `observability` se houver endpoint, job ou fila; `stack` só se a mudança trouxer dependência nova. Se o repo não tem o que a constitution exige (lint, cobertura), registre como dúvida técnica no constitution check; isso **não bloqueia**.
7. **SDD.** Tier `lite` e `fix`: um arquivo, `sdd.md` (`templates/sdd-lite.md`). Tier `standard`: `spec.md`, `plan.md` e `tasks.md`, divididos a partir do mesmo template. Deve ter delta (ADDED/MODIFIED/REMOVED + NÃO muda), **cópia das RN relevantes** (o SDD não linka para fora do repo), aceite Dado/Quando/Então ligado às RN, context pack, constitution check e tasks pequenas e testáveis. Se o repo não tem código relevante para o delta, escreva `ADDED: novo; local a definir` e registre como dúvida técnica (não invente o arquivo). Se há um local provável (ex.: um arquivo existente do mesmo domínio), escreva-o marcado `(provável)`. O campo **Tier** do `sdd.md` leva o tier real (`lite`, `fix` ou `standard`). No `fix`, as RN vêm direto do documento. **Não assuma comportamento que o documento não define**: é dúvida de negócio (passo 4), não do SDD. Uma `RN` para a qual não dá para escrever `AC` fica sem task e marcada `bloqueante`. Uma `RN` sem local de código óbvio (ex.: um prazo) ganha task só se houver algo testável; senão, fica como dúvida técnica.
8. **Registrar o vínculo**, só depois de o repo ter sido validado no passo 5, numa seção `## Implementação` (alias, caminho do SDD, estado `planejado`): no `brief.md`; no tier `fix`, num `vinculo.md` na pasta do work-item, com `## Implementação` (uma linha: `alias · caminho do SDD · estado`) e `## Dúvidas` (uma linha por dúvida, no formato de estados do passo 4), nunca dentro do `source.md`, que é regravado ao reextrair. `repos.md` só se o work-item afetar mais de um repo.
9. **Gate 2 — parar.** Não implemente, não commite, não crie branch. Mostre os caminhos e peça revisão. Implementar é outro passo: "implemente a primeira task `[ ]` de `<caminho do sdd>`".

## Quando usar cada tier
- `fix`: correção pequena (doc curta, 1–2 arquivos). Sem brief.
- `lite`: padrão. `standard`: mais de um módulo, contrato novo (API/evento), migração ou > 1 dia.

## Não fazer
Não editar o original em `docs-compass/`; não copiar o documento inteiro para o SDD; não usar `-ExecutionPolicy Bypass`.
