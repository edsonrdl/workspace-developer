---
name: wi-ingest
description: Transforma o refinamento de negócio de uma história (Word/PDF/MD) em refinamento versionado e em SDDs técnicos (um por repositório), que apontam para o clone em repos-project. Uso manual.
argument-hint: <ID da história> [alias-do-repo] [fix|lite|standard]
disable-model-invocation: true
allowed-tools: Read Write Edit Glob Grep Bash(powershell *) Bash(bash *) Bash(git *)
---

# wi-ingest — refinamento de negócio → SDD técnico

Argumentos: `$ARGUMENTS` → 1º = ID da história (`HU-142`); 2º (opcional) = alias do repo; 3º (opcional) = tier. Tiers: `fix` (sem refinamento de negócio, só SDD), `lite` (padrão), `standard`.

## A camada (pastas irmãs da raiz deste repo)

```
work-items/                              ← repo git próprio: tudo que pertence à história
├── _entrada/                            ← onde você solta o que recebeu: AAAA-MM-DD_<ID>_<slug>.<ext>
└── <ID>-<slug>/                         ← UMA pasta por história
    ├── README.md                        ← índice: status, links, lista de SDDs
    ├── refinamento/
    │   ├── original.<ext>               ← o que foi recebido (movido de _entrada; não edite)
    │   ├── source.md                    ← texto extraído (só .docx)
    │   └── refinamento.md               ← refinamento de NEGÓCIO (RN-n, dúvidas, aceite)
    └── sdd/
        └── <alias-do-repo>/             ← UM SDD por repo afetado
            ├── repo.md                  ← link para o clone em repos-project
            └── sdd.md                   ← (lite/fix)   ou   spec.md + plan.md + tasks.md (standard)
repos-project/<tipo>/<alias>/            ← clones; o código é escrito AQUI. O SDD aponta para cá.
```

O SDD **fica com a história** (versionado no repo `work-items`) e **aponta** para o repo de código. Quando o agente implementa, lê o SDD e escreve no clone indicado em `repo.md`.

**`<slug>`** = kebab-case do nome do arquivo sem a data e sem o ID (`2026-11-13_HU-142_pagamento-pix.docx` → `pagamento-pix`). Se não houver slug, derive do título (até 5 palavras).

Glob, Read e Write usam **caminho absoluto**. Cada chamada de Bash começa em outro diretório: inicie todo comando com `cd <raiz deste repo> &&`.

## Passos

1. **Localizar o original.** Glob com **caminho absoluto** (não aceita `..`): `path=<pasta pai>/work-items/_entrada`, `pattern=*<ID>*`. A pasta pai é a acima da raiz deste repo (`git rev-parse --show-toplevel`; se falhar, o diretório de trabalho atual, uma pasta acima). Se o usuário deu um caminho, use-o. Descarte `~$*` (lock do Word) e nomes em que o ID é seguido de dígito (`HU-14` ≠ `HU-142`). Várias versões → a mais recente, e avise. Nada achado → liste o que há em `_entrada/` e pare. **Se a pasta `work-items/<ID>-*/` já existir** (segundo repo da mesma história), **pule os passos 1 a 4**: reaproveite `refinamento/` como está e vá ao passo 5; só o SDD novo e a linha nova no `README.md` são criados.
2. **Guardar e extrair.** Crie `work-items/<ID>-<slug>/refinamento/` e, **só depois de a extração ter dado certo** (ou de o PDF/MD ter sido lido), **mova** o original para lá como `original.<ext>`. Passe ao script **caminhos absolutos** (origem e destino).
   - **Formato preferido: `.pdf` ou `.md`** (sem script): `.pdf` pelo Read (lê texto **e** imagens; `pages` se passar de 10 páginas); `.md`/`.txt` direto, sem `source.md`.
   - `.docx`: **se `bash` e `unzip` existirem, use o `.sh`**; senão o `.ps1`.
     - `.sh`: `bash .claude/skills/wi-ingest/extract-docx.sh <original> <pasta-da-história>/refinamento/source.md`
     - `.ps1`: `powershell -NoProfile -File .claude/skills/wi-ingest/extract-docx.ps1 -Path <original> -Out <pasta-da-história>/refinamento/source.md`
   - Se o script for **bloqueado** (política, `noexec`, ferramenta ausente, antivírus), **não contorne**: ofereça **uma** saída: (a) salvar como `.pdf`/`.md`; (b) colar o texto no chat; (c) liberar o script com a TI/usuário (Windows: `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`).
   - Não reextraia se `source.md` for mais novo que o original.
   - `AVISO` do extrator (imagens, comentários, alterações, notas de rodapé, corpo vazio) vira `[NEEDS CLARIFICATION]`; pergunte **uma vez** no Gate 1 se há regra importante ali. Sem resposta: `aberta (perguntado no Gate 1, sem resposta)`. Vale só para `.docx`: o Read de PDF enxerga imagens e não gera aviso. **Se o texto lido remete ao elemento não lido** ("veja a imagem abaixo", "conforme o comentário"), a dúvida é `bloqueante`; senão, `aberta`.
3. **Refinamento de negócio** (`templates/refinamento.md` → `refinamento/refinamento.md`), exceto no tier `fix`. Só negócio.
   - **Não invente.** Campo de **contexto** ausente (solicitante, valor, métrica) → `não informado`. **Regra de comportamento** ausente ou contraditória (exceção, entrada inválida, limite, o que "prazo" ou "promoção" significa) → `[NEEDS CLARIFICATION: pergunta]`. Frase vaga sem regra verificável não vira `RN`: vira dúvida `aberta`.
   - Sem classes, tabelas ou código. Preserve números e termos do negócio. Status inicial: `ideia`.
4. **Gate 1 — parar e mostrar** o resumo e as dúvidas (no tier `fix`, não há `refinamento.md`: resuma o original em 3 a 5 linhas e liste as dúvidas). **Bloqueante**: sem resposta, não dá para escrever `RN-n` ou `AC-n`; **não bloqueante**: só falta contexto. Comportamento que o negócio deve definir é dúvida **de negócio** (no refinamento); só estrutura e local do código são dúvida técnica (no SDD). Estados, sempre assim: `bloqueante`, `aberta`, `respondida: <resposta>`, `assumida: <o que foi assumido>`. **Pergunte e espere** as bloqueantes. Se o usuário mandar seguir, a dúvida bloqueia **só a parte que depende dela**: escreva `AC` e task para o que está definido (ex.: "até 15%") e deixe de fora o indefinido (ex.: "acima de 15%"), marcado `bloqueante`; se nada na `RN` está definido, ela fica sem `AC` e sem task. Um SDD pode ficar **sem nenhuma task**: Estado `bloqueado`, e o Gate 2 lista o que o destrava. Não bloqueante sem resposta → `aberta`. Um "ok, siga" **genérico** marca como `assumida: <o que>` apenas dúvidas não bloqueantes sobre conteúdo **lido**, e o Gate 2 lista o que foi assumido; **nunca** os avisos do extrator. Registre cada dúvida onde nasceu (`refinamento.md`; no `fix`, no `README.md` da história); o SDD só a repete se muda um `AC`.
5. **Escolher o repo.** Sem alias, pergunte. Localize o clone listando diretórios: `bash -c "ls -d <absoluto>/repos-project/*/<alias>"`. Zero ou mais de um → pergunte. O `<tipo>` do `repo.md` é a pasta pai do alias no resultado (`.../repos-project/<tipo>/<alias>`). Um work-item pode ter vários SDDs: repita 5–8 por repo. **Se o documento não toca o repo informado**, não crie SDD vazio: avise e pergunte se o repo deve mesmo entrar; só com confirmação, crie o SDD com Estado `sem-mudança` e a justificativa.
6. **Investigar barato** (no clone): Glob/Grep por termos do refinamento; leia só o relevante, o `AGENTS.md`/`CLAUDE.md` do repo (se não houver, anote "sem AGENTS.md" no context pack) e as seções da [constitution](../../../eng-blueprint/constitution/constitution.md): `testing` e `quality` sempre; `security` se houver dado pessoal, credencial ou autenticação; `observability` se houver endpoint, job ou fila; `stack` só com dependência nova. O que a constitution exige e o repo não tem (lint, cobertura) vira dúvida técnica e **não bloqueia**.
7. **SDD** em `work-items/<ID>-<slug>/sdd/<alias>/`: `repo.md` (`templates/repo.md`) e, em `lite`/`fix`, `sdd.md` (`templates/sdd-lite.md`); em `standard`, `spec.md`, `plan.md` e `tasks.md`. Deve ter: delta (ADDED/MODIFIED/REMOVED + NÃO muda), **cópia das RN relevantes** (o agente lê só o SDD), aceite Dado/Quando/Então ligado às RN, context pack (caminhos **dentro do repo alvo**), constitution check e tasks pequenas e testáveis. Sem local de código óbvio: `ADDED: novo; local a definir` (ou `(provável)`) como dúvida técnica. Não assuma comportamento que o documento não define. `RN` sem `AC` possível: sem task, `bloqueante`. O campo **Tier** leva o tier real; **Estado**: `planejado`, `bloqueado` (nenhuma task possível) ou `sem-mudança`. No `repo.md`, a **branch** é só uma sugestão em texto (`feat/<ID>-<slug>`, ou `fix/…` no tier `fix`): a skill não cria branch. No tier `fix`, a linha "Origem" do SDD aponta para `refinamento/original.<ext>` (não há `refinamento.md`).
8. **Índice da história**: crie/atualize `README.md` (`templates/README-historia.md`) com a tabela de SDDs e, no `fix`, as dúvidas.
9. **Gate 2 — parar.** Em uma segunda execução (passos 1–4 pulados) não há novo Gate 1: dúvida que só apareceu pelo repo vai para o SDD e é mostrada aqui. Liste também o que foi `assumida`. Não implemente, não commite, não crie branch. Mostre os caminhos e peça revisão. Implementar é outro passo: "implemente a primeira task `[ ]` de `<sdd>` no repo de `repo.md`".

## Tiers
- `fix`: correção pequena (1–2 arquivos). Sem `refinamento.md`: o refinamento é o próprio original + `sdd.md`.
- `lite`: padrão. `standard`: mais de um módulo, contrato novo, migração ou > 1 dia. Para casos grandes, use o `sdd-template/` completo (6 arquivos) dentro de `sdd/<alias>/`.

## Não fazer
Não editar `original.*`; não copiar o documento inteiro para o SDD; não usar `-ExecutionPolicy Bypass`; não escrever código de produção.
