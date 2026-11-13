# HU-142 — Pagamento via PIX no checkout   *(EXEMPLO)*

> Esta pasta é um **exemplo** de como fica uma história. Os repos citados abaixo (`api-pagamentos`, `worker-notificacoes`) são ilustrativos e ainda não existem em `repos-project/`.

- **Status:** refinada
- **Original recebido:** [refinamento/original.md](refinamento/original.md) *(no caso real: `original.docx` ou `.pdf`)*
- **Refinamento de negócio:** [refinamento/refinamento.md](refinamento/refinamento.md)

## SDDs (um por repositório afetado)

| Repo | Onde está o código | Tier | SDD | Estado |
|---|---|---|---|---|
| api-pagamentos | `repos-project/apis/api-pagamentos` | standard | [sdd/api-pagamentos/](sdd/api-pagamentos/) | planejado |
| worker-notificacoes | `repos-project/microservices/worker-notificacoes` | lite | [sdd/worker-notificacoes/](sdd/worker-notificacoes/) | planejado |

## Como ler esta pasta (de cima para baixo)
1. `refinamento/original.*`: o que chegou, sem mexer.
2. `refinamento/refinamento.md`: o **negócio** traduzido (regras `RN-n`, dúvidas).
3. `sdd/<repo>/`: o **plano técnico** para a IA implementar naquele repo. O `repo.md` de cada um diz **onde está o código** e em qual branch trabalhar.
