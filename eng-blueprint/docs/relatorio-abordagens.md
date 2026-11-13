# Relatório — três abordagens para work-item → SDD com agentes

> Data: 2026-11-13. Três agentes com perfis diferentes projetaram e (quando possível) prototiparam cada abordagem em sandbox fora do repo. As notas são **dos próprios agentes**; nenhum protótipo rodou de ponta a ponta com um agente real em um repo real. Os números de tokens são de sandbox minúsculo (bytes/4): valem como proporção, não como valor absoluto.

## Resumo

| | A — Convenção + scripts | B — Claude Code nativo | C — Adotar OpenSpec + work-item próprio |
|---|---|---|---|
| Ideia | `work-items/` + SDD em tiers + scripts PowerShell | Skills, subagentes e hook sobre a mesma estrutura | OpenSpec em cada repo (delta specs); work-item próprio |
| Nota do agente | 8/10 | 8/10 | 7/10 |
| Esforço | 1–1,5 dia | 1 dia + 1–2 de piloto | 1–2 dias piloto + 3–4 de scripts |
| Testado de verdade | Scripts executados no sandbox (achou 6 bugs) | Sintaxe conferida na doc; `status.sh` e hook rodaram; **nunca rodou no Claude Code** | **Nada instalado** (sem Node/Python); só documentação |
| Custo fixo de contexto | ~175 tokens (AGENTS.md) | ~325 tokens (AGENTS + descrições de agentes) | não medido |
| Dependências | PowerShell 5.1 | Claude Code, Git Bash | Node ≥ 22.12 |
| Lock-in | Nenhum | Alto na camada `.claude/`; templates e work-items portáveis | Baixo (markdown, MIT) |
| Principal risco | Disciplina manual; 2 repos git sem atomicidade | Custo dos forks (não medido); manutenção de 6 skills + 4 agentes | Multi-repo (Stores) em beta; dois ecossistemas de convenção |

## O que cada uma provou

**A — scripts.** O fluxo `STATUS.md → brief → repos.md → tasks` funcionou: ~416 tokens para retomar uma sessão e ~64 tokens só para triar vários work-items. Tiers lite/standard são ~5–15x menores que os 6 arquivos full (~7k tokens vazios). Bugs encontrados são de Windows/PS 5.1 (BOM, `Resolve-Path`, execution policy, colisão `$wi`/`$WI`), mais quatro abertos: ID curto não resolve, slug perde acento, `status` conta AC como task, `NEEDS CLARIFICATION` do brief não é contado.

**B — Claude Code nativo.** Desenho com `/wi-new`, `/wi-refine`, `/sdd-plan`, `/sdd-implement`, `/sdd-analyze`, `/wi-status`; subagentes com contexto isolado (haiku nos papéis leves) e um hook que bloqueia brief citando código (regra "work-item não conhece código" imposta sem gastar tokens). Campos validados contra a doc oficial. Em aberto: se `agent:` custom resolve, se o fork cumpre o papel, e o custo real dos forks (cada um relê o repo).

**C — adotar.** OpenSpec é a única ferramenta pesquisada com delta specs nativos (ADDED/MODIFIED/REMOVED) e 4 artefatos por mudança. Não cobre o work-item de negócio, o vínculo repo↔work-item nem status agregado; Stores (multi-repo) é beta. Spec Kit foi descrito como o mais pesado (~8 arquivos por spec, risco de review overload). Nenhuma medição de tokens das ferramentas foi obtida.

## Leitura crítica

- **As três notas são quase iguais e nenhuma foi validada com agente real.** Não escolha por 8 vs 7.
- **A e B não competem:** B é uma camada de automação sobre a estrutura de A. Sem os templates, scripts e `repos.md` de A, as skills de B não têm o que orquestrar.
- **C resolve a parte que você já decidiu fazer pequena** (SDD standard por repo). Seus 4 artefatos ≈ o tier standard de A. O ganho extra (delta specs) dá para obter com uma seção no template, sem Node nem beta.
- O que **nenhuma** das três resolve sozinha: o commit duplo (work-item e repo são repos git distintos) e a divergência entre `repos.md` e a realidade.

## Recomendação: **A agora, B por cima depois do piloto, C só como experimento**

1. **Fundação = A.** É a mais viável: zero dependências, o ganho de tokens vem dos tiers e do `STATUS.md`, e o resto (B ou C) reaproveita sua estrutura. Corrija os 4 bugs abertos e acrescente `link-repo` e `check`.
2. **Antes de escrever scripts, rode o piloto à mão** com 1 work-item real em `repo-nucea` e meça tokens reais por sessão.
3. **Camada B (skills/hook) em seguida, mínima:** comece só com `/wi-new`, `/sdd-plan` e o hook de validação; adie subagentes de implementação até medir o custo dos forks.
4. **C fica em observação.** Reavalie quando Stores sair do beta ou se o piloto mostrar que sua seção de delta não basta. Se testar, instale Node de forma consciente e meça os artefatos.

### Ajustes ao PLANO
- Fase 3 (tiers) passa a vir **antes** da Fase 4 e vira o miolo; incorporar delta (ADDED/MODIFIED/REMOVED) no tier standard.
- Fase 5 (piloto) sobe para logo após Fase 2 + tiers, antes da automação.
- Fase 4 divide em 4a (scripts de A) e 4b (skills de B).
- Decisão 1 do plano (linguagem dos scripts): PowerShell funciona; para evitar os bugs de PS 5.1 e execution policy, considerar Git Bash (B já usa) ou PowerShell 7.

## Fontes
- [Skills — Claude Code docs](https://code.claude.com/docs/en/skills), [Subagents](https://code.claude.com/docs/en/sub-agents), [Hooks](https://code.claude.com/docs/en/hooks), [Memory](https://code.claude.com/docs/en/memory)
- [OpenSpec](https://github.com/Fission-AI/OpenSpec), [OpenSpec Stores](https://openspec.dev/docs/stores)
- [Spec Kit](https://github.com/github/spec-kit), [BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD)
- [Böckeler/Fowler: Kiro, spec-kit, Tessl](https://www.martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
