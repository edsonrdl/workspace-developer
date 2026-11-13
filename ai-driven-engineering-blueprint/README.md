# ai-driven-engineering-blueprint — regras e ferramentas

**Camada do workspace:** as **regras** e as **ferramentas** que valem para todas as histórias. Aqui não há histórias nem código de negócio.

**Abra o Claude Code dentro desta pasta.** A skill `/wi-ingest` e os caminhos relativos (`../work-items`, `../repos-project`) partem daqui.

| O que | Onde |
|---|---|
| Regras universais (stack, segurança, qualidade, observabilidade, testes) | [`eng-blueprint/constitution/`](eng-blueprint/constitution/) |
| Como construímos, por arquitetura (microservice, rest-api, modular-monolith, mvc) | [`eng-blueprint/playbooks/`](eng-blueprint/playbooks/) |
| Template completo de SDD (6 arquivos), para mudanças grandes | [`eng-blueprint/sdd-template/`](eng-blueprint/sdd-template/) |
| A skill que transforma o documento recebido em refinamento e SDDs | [`.claude/skills/wi-ingest/`](.claude/skills/wi-ingest/) |
| Instruções curtas para o agente | [`AGENTS.md`](AGENTS.md) (e `CLAUDE.md`, que o importa) |
| Plano, decisões e estado | [`eng-blueprint/PLANO.md`](eng-blueprint/PLANO.md) |
| Por que, governança, FAQ, referências, relatórios | [`eng-blueprint/docs/`](eng-blueprint/docs/) |
| Diagramas (Obsidian) | `eng-blueprint/*.canvas` |

Mais detalhes sobre a estrutura e o uso: [`eng-blueprint/README.md`](eng-blueprint/README.md).

## A skill `/wi-ingest`

```
/wi-ingest <ID> [alias-do-repo] [fix|lite|standard]
```

Lê o documento em `../work-items/_entrada/`, escreve o refinamento de negócio e um SDD por repositório em `../work-items/<ID>-<slug>/`, e para em dois pontos de revisão. **Não implementa** e não faz commit.

Extração de `.docx`: prefira PDF ou MD; senão `extract-docx.sh` (Linux, macOS, Git Bash), senão `extract-docx.ps1` (Windows). Se um script for bloqueado, a skill pede outra saída e **não contorna**.

## Estado

Validada só com dados falsos. Veja `eng-blueprint/docs/relatorio-abordagens.md`.
