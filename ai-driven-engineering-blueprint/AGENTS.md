# AGENTS.md — ai-driven-engineering-blueprint

Vault pessoal de regras e fluxo para evoluir histórias com IA. Conteúdo em `eng-blueprint/`.

## Onde está o quê
- `eng-blueprint/constitution/` — regras universais (índice: `constitution.md`). Leia só a seção aplicável.
- `eng-blueprint/playbooks/` — como construímos por arquitetura. Leia só o que o SDD citar.
- `eng-blueprint/sdd-template/` — template completo (6 arquivos); só para mudanças grandes.
- `.claude/skills/wi-ingest/` — skill `/wi-ingest <ID> [alias] [fix|lite|standard]`.
- `eng-blueprint/PLANO.md` — estado e decisões. `eng-blueprint/docs/` — contexto, não leia sem necessidade.

## Pastas irmãs (fora deste repo)
`../work-items/<ID>-<slug>/` — a história: `refinamento/` (negócio) e `sdd/<repo>/` (um SDD por repo, com `repo.md` apontando para o clone). Docs recebidos entram em `../work-items/_entrada/`.
`../repos-project/<tipo>/<repo>/` — clones; o código é escrito aqui, guiado pelo SDD que fica em `work-items`.
`../docs-compass/` — diretório de documentação (governo/time); **não** faz parte do fluxo de histórias.

## Regras
1. Não invente regra de negócio: lacuna vira `[NEEDS CLARIFICATION: …]`.
2. Refinamento = só negócio. SDD = só implementação, com delta e "o que NÃO muda", e aponta para o repo em `repo.md`.
3. Dois gates humanos: depois do brief e depois do SDD. Implementar é um passo à parte.
4. Não commite, não crie branch e não faça push sem pedido explícito.
5. Extração de .docx: prefira PDF/MD; senão `bash .claude/skills/wi-ingest/extract-docx.sh`, senão o `.ps1`. Se bloquear, não contorne: avise o usuário.
6. Números de tokens neste repo são hipóteses até o piloto (ver PLANO).
