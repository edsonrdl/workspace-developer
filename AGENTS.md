# AGENTS.md — ai-driven-engineering-blueprint

Vault pessoal de regras e fluxo para evoluir histórias com IA. Conteúdo em `eng-blueprint/`.

## Onde está o quê
- `eng-blueprint/constitution/` — regras universais (índice: `constitution.md`). Leia só a seção aplicável.
- `eng-blueprint/playbooks/` — como construímos por arquitetura. Leia só o que o SDD citar.
- `eng-blueprint/sdd-template/` — template completo (6 arquivos); só para mudanças grandes.
- `.claude/skills/wi-ingest/` — skill `/wi-ingest <ID> [alias] [fix|lite|standard]`.
- `eng-blueprint/PLANO.md` — estado e decisões. `eng-blueprint/docs/` — contexto, não leia sem necessidade.

## Pastas irmãs (fora deste repo)
`../docs-compass/` (docs de negócio) · `../work-items/` · `../repos-project/<tipo>/<repo>/` (clones; SDD em `sdd/<ID>-<slug>/`).

## Regras
1. Não invente regra de negócio: lacuna vira `[NEEDS CLARIFICATION: …]`.
2. Brief = só negócio. SDD = só implementação, com delta e "o que NÃO muda".
3. Dois gates humanos: depois do brief e depois do SDD. Implementar é um passo à parte.
4. Não commite, não crie branch e não faça push sem pedido explícito.
5. Não contorne a política de execução do PowerShell; avise o usuário.
6. Números de tokens neste repo são hipóteses até o piloto (ver PLANO).
