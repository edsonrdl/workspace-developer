# work-items — as histórias

**Camada do workspace:** aqui mora tudo que pertence a uma **história de negócio**: o documento como chegou, o refinamento de negócio e os SDDs técnicos (um por repositório). O **código não fica aqui**: cada SDD aponta para o clone em [`../repos-project/`](../repos-project/).

**Quem escreve aqui:** a skill `/wi-ingest`, do [blueprint](../ai-driven-engineering-blueprint/). Você solta o documento em `_entrada/`.

> Repositório privado: as pastas das histórias reais contêm documentos de negócio.

```
work-items/
├── _entrada/                          ← solte aqui o que recebeu (AAAA-MM-DD_<ID>_<slug>.docx|pdf|md); o conteúdo não é versionado
├── _EXEMPLO-HU-142-pagamento-pix/     ← exemplo completo: abra este para ver a camada
└── <ID>-<slug>/                       ← UMA pasta por história real
    ├── README.md                      ← índice: status, links, lista de SDDs
    ├── refinamento/
    │   ├── original.<ext>             ← o que foi recebido (não edite)
    │   ├── source.md                  ← texto extraído (só .docx)
    │   └── refinamento.md             ← refinamento de NEGÓCIO (RN-n, dúvidas, aceite)
    └── sdd/
        ├── <repo-A>/                  ← UM SDD por repositório afetado
        │   ├── repo.md                ← link para repos-project/<tipo>/<repo-A> + branch sugerida
        │   └── sdd.md                 ← (lite/fix)  ou  spec.md + plan.md + tasks.md (standard)
        └── <repo-B>/ …
```

## Fluxo

`_entrada/` → `/wi-ingest <ID> [repo] [tier]` → `refinamento/` e `sdd/<repo>/` → a IA lê o SDD e implementa **no repo apontado por `repo.md`**.

Dois pontos de revisão humana: depois do refinamento (dúvidas) e depois do SDD (antes de implementar).

## Convenções

- **Pasta da história:** `<ID externo>-<slug>`, ex.: `HU-142-pagamento-pix`.
- **Nome na entrada:** `AAAA-MM-DD_<ID>_<slug>.<ext>`.
- **Estados de dúvida:** `bloqueante`, `aberta`, `respondida: …`, `assumida: …`.
- **Tiers:** `fix` (sem refinamento de negócio), `lite` (padrão), `standard` (spec, plan e tasks).
