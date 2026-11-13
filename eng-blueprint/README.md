# eng-blueprint

> Engenharia de software com governança de IA aplicada.
> Velocidade da IA + rigor de engenharia = outputs auditáveis, versionados e aprovados por humano.

Área de trabalho pessoal: regras (constitution), padrões (playbooks) e templates de SDD que ligam **tarefas de negócio** a **implementações por repositório**.

---

## Mapa

```
eng-blueprint/
├── constitution/   ← regras universais inegociáveis (índice: constitution.md)
├── playbooks/      ← "como construímos" por arquitetura (microservice, rest-api, modular-monolith, mvc)
├── sdd-template/   ← template do SDD de implementação (spec → requirements → contracts → acceptance → plan → tasks)
├── docs/           ← contexto sob demanda (não precisa ser lido para trabalhar)
├── PLANO.md        ← plano de evolução (fases e status)
└── *.canvas        ← diagramas para o Obsidian
```

Camadas (alvo, ver [PLANO.md](PLANO.md)):

| Camada | Onde | Contém |
|---|---|---|
| Negócio | `work-items/` (pasta irmã, a criar) | tarefas, histórias, oportunidades — independentes de projeto |
| Código | `repos-business/<repo>/` (clones, não versionados aqui) | código + `sdd/` de cada mudança |
| Regras | este vault | constitution, playbooks, templates |

---

## Como usar hoje

1. Abra esta pasta como vault no Obsidian (links `[[constitution]]`, `[[microservice]]` resolvem pelo nome do arquivo).
2. Copie `sdd-template/` para `sdd/` na raiz do repo alvo e preencha na ordem de [docs/ordem-de-leitura.md](docs/ordem-de-leitura.md).
3. Instrua o agente: `Siga as especificações que estão em sdd/spec.md`.

Detalhes do template: [sdd-template/README.md](sdd-template/README.md).

---

## Leitura sob demanda

- [docs/porque-sdd.md](docs/porque-sdd.md) — problema do Vibe Code e economia de tokens
- [docs/governanca-hitl.md](docs/governanca-hitl.md) — HITL/HOTL/HIC e phase gates por risco
- [docs/ordem-de-leitura.md](docs/ordem-de-leitura.md) — por que a ordem spec → … → tasks
- [docs/faq.md](docs/faq.md) — perguntas frequentes e evolução de padrões
- [docs/referencias.md](docs/referencias.md) — fontes externas

---

## Roadmap

Ver [PLANO.md](PLANO.md). Pendências herdadas: playbooks `database`, `events`, `auth`; template de ADR; validação de links em CI.
