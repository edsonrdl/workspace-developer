# workspace-developer

Área de trabalho para evoluir **histórias de negócio em código com IA**: o que se recebe vira refinamento versionado, o refinamento vira SDD técnico (um por repositório) e a IA implementa no repo apontado.

> **Este repositório deve ser PRIVADO.** Ele guarda documentos de negócio recebidos, refinamentos e planos de implementação.

## As camadas

| Pasta | O que é | Quando você mexe nela |
|---|---|---|
| [`ai-driven-engineering-blueprint/`](ai-driven-engineering-blueprint/) | **Regras e ferramentas**: constitution, playbooks, templates de SDD e a skill `/wi-ingest` | quando muda um padrão ou a skill |
| [`work-items/`](work-items/) | **As histórias**: documento recebido, refinamento de negócio e um SDD por repo | a cada história nova |
| [`repos-project/`](repos-project/) | **O código**: clones dos repos da empresa, por tipo (`apis/`, `microservices/`…). Cada clone tem o seu próprio remoto e **não é versionado aqui** | ao implementar |
| [`docs-compass/`](docs-compass/) | **Documentação** de governo ou de time, consultável por IA. Fora do fluxo de histórias | quando muda a documentação |

## Como as camadas se conectam

```
documento recebido
   └─► work-items/_entrada/            você solta aqui (Word, PDF ou MD)
         └─► /wi-ingest <ID> <repo>     skill do blueprint (2 pontos de revisão humana)
               ├─► work-items/<ID>-<slug>/refinamento/   o negócio, traduzido
               └─► work-items/<ID>-<slug>/sdd/<repo>/    o plano técnico; repo.md aponta para o clone
                     └─► repos-project/<tipo>/<repo>/     a IA implementa AQUI
```

O blueprint dá as **regras** (constitution e playbooks) e a **skill**. O `docs-compass` é um diretório de documentação ao lado e nenhuma skill o lê ou escreve.

## Como usar

1. **Abra o Claude Code dentro de `ai-driven-engineering-blueprint/`.** A skill e os caminhos relativos (`../work-items`, `../repos-project`) partem dali.
2. Solte o documento em `work-items/_entrada/` com o nome `AAAA-MM-DD_<ID>_<slug>.<ext>` (ex.: `2026-11-13_HU-142_pagamento-pix.docx`).
3. Clone o repo de código em `repos-project/<tipo>/<repo>/`.
4. Rode `/wi-ingest <ID> <repo> [fix|lite|standard]`.
5. Revise o refinamento e o SDD. Só então peça a implementação.

Veja um exemplo completo em [`work-items/_EXEMPLO-HU-142-pagamento-pix/`](work-items/_EXEMPLO-HU-142-pagamento-pix/).

## Estado (honesto)

- A skill foi testada **apenas com dados falsos** e agentes simulando o usuário (notas de 8 a 8,5 em 10). Nada foi validado com um Word real nem com repos reais.
- O ganho de tokens **não está provado**: num teste com histórias falsas, a skill gastou cerca de 18% **mais** tokens que colar o texto no baseline, e só ganhou em detecção quando o documento tinha conteúdo que o texto colado perde (imagem, comentário, alterações). Detalhes em `ai-driven-engineering-blueprint/eng-blueprint/docs/relatorio-abordagens.md`.
- O extrator de `.docx` foi validado em Windows (PowerShell e Git Bash). **Não foi testado em Linux nem macOS de verdade.**

## Histórico

Este repositório reúne três repositórios que existiam separados, com o histórico preservado (`git subtree`): `ai-driven-engineering-blueprint`, `docs-compass` (antes `solucao-doc-brq` na pasta local) e `work-items` (começou aqui, sem histórico anterior).
