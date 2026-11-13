# repos-project — o código

**Camada do workspace:** aqui ficam os **clones dos repositórios de código da empresa**, organizados por tipo. É onde a IA escreve o código, guiada pelo SDD que fica em [`../work-items/`](../work-items/).

**Estes clones NÃO são versionados neste repositório.** Cada um tem o seu próprio remoto; o `.gitignore` da raiz ignora `repos-project/<tipo>/<repo>/`. Só este README e os `.gitkeep` dos tipos entram no git.

```
repos-project/
├── apis/
│   └── <repo>/            ← git clone <url-do-repo> repos-project/apis/<repo>
├── microservices/
│   └── <repo>/
└── …                      ← crie outros tipos conforme precisar
```

## Como adicionar um repo

```bash
git clone <url-do-repo> repos-project/<tipo>/<repo>
```

O `<tipo>` e o nome do repo são usados pela skill `/wi-ingest` para montar o `repo.md` de cada SDD (`../../../../repos-project/<tipo>/<repo>`). Use o mesmo nome do repo no remoto.

## Regra para a IA

Implemente **dentro do clone** indicado no `repo.md` do SDD, siga o `AGENTS.md`/`CLAUDE.md` do próprio repo (se houver) e não altere outros clones. O SDD **não** é copiado para o repo de código.
