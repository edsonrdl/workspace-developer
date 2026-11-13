# PLANO — Evolução do eng-blueprint

> Documento vivo. Atualize o status das fases conforme avança.
> Criado em 2026-11-13. Objetivo: transformar este vault em uma **área de trabalho pessoal** que liga *tarefas de negócio* → *SDDs por repositório*, gastando poucos tokens e com o máximo de automação.

---

## 1. Diagnóstico do estado atual

| # | Achado | Impacto |
|---|---|---|
| 1 | `README.md` tem ~35 KB (um terço do vault). Mistura pitch, governança HITL/HOTL, estimativas de tokens, FAQ, roadmap | Caro de carregar; ninguém (nem agente) lê inteiro |
| 2 | Pasta chamada `constitution.md/` (nome de pasta com extensão) contendo `constitution.md` | Confuso; links `[[constitution]]` ambíguos |
| 3 | README descreve `workspace/` e um exemplo `microservico-pagamento/` que **não existem** no repo | Doc mentirosa; `.gitignore` aponta para `eng-blueprint/workspace/*/` |
| 4 | `Fluxo.md` solto na raiz (641 bytes), duplica o que está em `sdd-template/README.md` | Redundância |
| 5 | `sdd-template` tem 6 arquivos (~29 KB de template) para **qualquer** mudança, inclusive um fix | Review overload; custo de tokens fixo alto |
| 6 | O modelo assume **um projeto = um sdd/** dentro do repo. Não há camada de *demanda de negócio* acima dos repos | É exatamente o que você quer resolver |
| 7 | Sem `AGENTS.md`/`CLAUDE.md` na raiz: o agente não sabe como navegar o vault | Cada sessão re-explica |
| 8 | Sem scripts: criar tarefa/SDD é copiar pasta na mão | Sem automação |
| 9 | `.canvas` e `.obsidian/` versionados | Ok, mas `workspace.json` já está ignorado; manter |

---

## 2. Modelo proposto — 3 camadas independentes

```
workspace-developer/
├── ai-driven-engineering-blueprint/   ← ESTE repo: regras, playbooks, templates, scripts (versionado)
├── docs-compass/                      ← ENTRADA: docs de negócio recebidas (repo próprio)
├── work-items/                        ← NEGÓCIO: tarefas/histórias/oportunidades (repo próprio, versionado)
│   └── HU-142-pagamento-pix/
│       ├── brief.md                   ← problema, valor, critérios de negócio, status
│       ├── repos.md                   ← quais repos são afetados e onde está o SDD de cada um
│       └── decisions.md               ← (opcional) decisões de negócio / contexto de reunião
└── repos-project/                     ← CÓDIGO: clones por tipo (não versionados aqui)
    ├── apis/
    ├── microservices/
    │   └── repo-nucea/
    │       └── sdd/HU-142-pagamento-pix/ ← SDD de implementação, versionado COM o código
    └── …
```

**Regra de ouro:** o work-item não conhece código; o SDD não conhece negócio além de um link.

- **Work-item** = *o quê e por quê* (negócio). Nasce sem projeto algum, só com ID + slug. Evolui sozinho.
- **SDD** = *como* (implementação) em **um** repo. Referencia o work-item pelo ID (`WI: HU-142`).
- **Ligação** = `repos.md` do work-item (tabela alias → caminho relativo → pasta do SDD → branch → status). Um work-item pode gerar N SDDs (um por repo).
- **Aliases** em um `repos-registry.md` (ou `.yaml`) no blueprint: `nucea → ../repos-project/microservices/repo-nucea`. Se você mover um clone, muda uma linha.

Por que o SDD fica no repo (e não no work-item): ele versiona junto com o código no PR — decisão já correta no vault atual; mantém-se.

---

## 3. Melhorias no SDD (com base na pesquisa)

### 3.1 Tiers — nem toda mudança precisa de 6 arquivos
A análise de Fowler/Böckeler sobre Kiro, spec-kit e Tessl aponta que o spec-kit é o mais pesado, com risco real de *review overload*; o Kiro usa só 3 arquivos por feature (requirements, design, tasks). Proposta:

| Tier | Quando | Arquivos |
|---|---|---|
| **Lite** | Fix, ajuste pequeno, < ~1 dia | `sdd.md` único (contexto, mudança, aceite, tasks) |
| **Standard** | Feature normal em 1 repo | `spec.md` (problema + requisitos + aceite) · `plan.md` · `tasks.md` |
| **Full** | Contrato novo, multi-serviço, regulatório | os 6 atuais (`spec, requirements, contracts, acceptance, plan, tasks`) |

Regra: comece no menor tier que cabe; promova se precisar.

### 3.2 Brownfield: spec de *delta*
Seus repos já existem. Em vez de especificar o sistema inteiro, o SDD descreve **só a mudança**: `ADDED / MODIFIED / REMOVED` + "o que NÃO muda". (Sugestão minha, derivada do problema; não validada em fonte específica.) Reduz tokens e evita o agente reescrever o que funciona.

### 3.3 Práticas incorporadas do ecossistema SDD
- **Constitution como gate**: `plan.md` ganha seção "Constitution check" (spec-kit faz o plano ser ancorado na constitution).
- **Marcador `[NEEDS CLARIFICATION: …]`**: o agente não adivinha; pára e pergunta. Passo opcional de *clarify* antes do plano.
- **Passo `analyze`** (checklist ou prompt) que cruza spec ↔ plan ↔ tasks e aponta inconsistências, como o `/speckit.analyze`.
- **Tasks pequenas e testáveis isoladamente** (já tem INVEST); adicionar marcador `[P]` para tarefas paralelizáveis e referência ao ID do requisito (`FR-003`) → rastreabilidade.
- **Non-Goals e decisões com alternativas rejeitadas**: já existem — manter.
- **Nível de maturidade explícito**: hoje você está em *spec-first*. Declare no README que o alvo é *spec-anchored* (spec mantida junto ao código); *spec-as-source* não é realista agora (o próprio Böckeler duvida que alguma ferramenta entregue isso).

### 3.4 Economia de tokens (contexto)
Consenso das fontes (majoritariamente blogs; números exatos são estimativas, não verificados):
1. Arquivo sempre-carregado **enxuto**: `CLAUDE.md`/`AGENTS.md` ≲ 200 linhas (heurística; alguns sugerem ~60). Teste de poda: "se eu remover esta linha, o agente erra?" Se não, corte.
2. **Progressive disclosure**: ponteiros para docs em vez de colar conteúdo; skills carregam só nome+descrição até serem usadas; `SKILL.md` < ~500 linhas.
3. **Hooks/scripts** para checagens determinísticas (lint, validar links, validar estrutura) — fora do contexto.
4. **Não repetir** o que o modelo já faz por padrão ("escreva código limpo").
5. Ressalva: uma avaliação citada em segunda mão achou um índice compacto no AGENTS.md superior a skills carregadas dinamicamente. → **Meça** com seu uso real antes de dogmatizar.

Aplicação aqui:
- `README.md` vira ≤ 150 linhas (o que é, mapa, como começar). O resto vai para `docs/` (`docs/porque-sdd.md`, `docs/governanca-hitl.md`, `docs/referencias.md`) — lido só sob demanda.
- **Constitution condensada**: um `constitution.md` único de ~1 página com regras *imperativas e curtas*; detalhes por seção ficam como ponteiros.
- **Context pack**: o `spec.md`/`sdd.md` lista, no topo, **apenas** os arquivos necessários (não a lista inteira de 8 sempre).

---

## 4. Estrutura-alvo do blueprint

```
ai-driven-engineering-blueprint/
├── AGENTS.md              ← ≤ 100 linhas: mapa, regras de navegação, comandos
├── CLAUDE.md              ← 1 linha: "@AGENTS.md"
├── README.md              ← curto
├── PLANO.md               ← este arquivo
├── constitution/          ← (renomeada de constitution.md/) index.md + seções
├── playbooks/             ← (renomeada) microservice, rest-api, modular-monolith, mvc
├── templates/
│   ├── work-item/         ← brief.md, repos.md
│   ├── sdd-lite/          ← sdd.md
│   ├── sdd-standard/      ← spec.md, plan.md, tasks.md
│   └── sdd-full/          ← os 6 atuais
├── docs/                  ← README antigo fatiado + ADRs + referências
├── scripts/               ← automação (seção 5)
└── repos-registry.md      ← alias → caminho dos clones
```
(O diretório `eng-blueprint/` interno pode ser achatado: o repo já se chama *ai-driven-engineering-blueprint*. Decidir na Fase 1.)

---

## 5. Automação (alvo da Fase 4)

Scripts simples (PowerShell, pois é Windows; ou Node/Python se preferir portabilidade):

| Comando | Faz |
|---|---|
| `new-work-item "título"` | Cria `work-items/AAAA-NNN-slug/` com `brief.md` + `repos.md` do template |
| `link-repo <WI> <alias>` | Adiciona o repo em `repos.md` do work-item |
| `new-sdd <WI> <alias> [lite\|standard\|full]` | Cria `sdd/<WI>/` **dentro do clone**, com o tier escolhido e o ID do work-item preenchido |
| `check` | Valida: links `[[ ]]` resolvem, IDs de requisito têm task, nenhum `NEEDS CLARIFICATION` aberto |
| `status` | Lista work-items e o % de tasks `[x]` por SDD (um único arquivo de saída, barato de ler) |

Depois: **skills/slash commands** do Claude Code (`/wi-new`, `/sdd-plan`, `/sdd-implement`, `/sdd-analyze`) que apenas orquestram os scripts + templates — assim o agente carrega instruções só quando invocado.

---

## 6. Fases e checklist

### Fase 0 — Limpeza (este workspace) · **status: concluída e publicada em 2026-11-13**
- [x] Renomear `constitution.md/` → `constitution/` e `engineering-playbooks/` → `playbooks/` (referências textuais ajustadas; wikilinks `[[ ]]` resolvem por nome de arquivo, não quebram)
- [x] Fatiar `README.md` (35 KB → 2,3 KB) em `docs/porque-sdd.md`, `governanca-hitl.md`, `referencias.md`, `faq.md`
- [x] `Fluxo.md` → `docs/ordem-de-leitura.md`
- [x] Remover menções a `workspace/` e `microservico-pagamento/` inexistentes; `.gitignore` atualizado
- [ ] Decidir: achatar `eng-blueprint/` interno? (adiado → Fase 1, decisão em aberto 3)
- [x] `.canvas` atualizados (legenda, nomes de pastas) e novo `workspace-pastas.canvas` com layout e fluxo (2026-11-13)
- Pendência menor: `constitution/governance.md` cita `repos-project/` como regra de aprovação — revisar na condensação da constitution (Fase 1).

### Fase 1 — Contexto enxuto · **pendente**
- [ ] `AGENTS.md` (+ `CLAUDE.md` apontando para ele)
- [ ] Condensar `constitution` (1 página imperativa)
- [ ] Aplicar teste de poda nos playbooks

### Fase 2 — Camada de work-items · **pendente**
- [ ] Template `brief.md` (problema, valor, stakeholders, critérios de negócio, status, não-objetivos)
- [ ] Template `repos.md` + `repos-registry.md`
- [ ] Criar repo/pasta irmã `work-items/`
- [ ] Convenção de ID: `AAAA-NNN-slug`; status: `ideia → refinada → em-execução → entregue → arquivada`

### Fase 3 — SDD em tiers · **pendente**
- [ ] `sdd-lite`, `sdd-standard`; enxugar `sdd-full`
- [ ] Seções: delta (ADDED/MODIFIED/REMOVED), Constitution check, `[NEEDS CLARIFICATION]`, `[P]`, IDs rastreáveis
- [ ] Guia "qual tier usar" (1 tabela)

### Fase 4 — Automação · **pendente**
- [ ] Scripts da seção 5
- [ ] Skills/slash commands
- [ ] (Opcional) CI/hook para `check`

### Fase 5 — Piloto e medição · **pendente**
- [ ] Rodar 1 work-item real em 1 repo (ex.: `repo-nucea`) fim a fim
- [ ] Medir tokens por sessão antes/depois e ajustar (`/context` / uso da sessão)
- [ ] Promover padrões repetidos para `playbooks/` via ADR (processo já descrito)

---

## 6b. Revisão após comparar abordagens (2026-11-13)
Ver [docs/relatorio-abordagens.md](docs/relatorio-abordagens.md). Decisão: **A (convenção + scripts) como fundação; B (skills/hook) por cima após piloto; C (OpenSpec) só em observação.** Nova ordem: Fase 1 → 2 → 3 (tiers com delta) → **5 (piloto manual + medição)** → 4a (scripts) → 4b (skills/hook).

## 6c. Ingestão de docs de negócio (2026-11-13)
Nomes de pastas definidos em 2026-11-13: `repos-project/<tipo>/<repo>` (tipos: `apis`, `microservices`, ...), `docs-compass/` (repo de entrada; localmente a pasta ainda se chama `solucao-doc-brq`) e raiz `workspace-developer/`. Layout visual em `workspace-pastas.canvas`.
Skill `/wi-ingest` em `.claude/skills/wi-ingest/` (raiz do repo): doc humanizada (Word/PDF/MD) em `../docs-compass/` → `work-items/<ID>-<slug>/{brief,source,repos}.md` → SDD lite/standard no repo alvo, com dois gates humanos (após o brief; após o SDD) e sem implementar.
- **Convenção de nome em `docs-compass/`:** `AAAA-MM-DD_<ID>_<slug>.<ext>`, ex. `2026-11-13_HU-142_pagamento-pix.docx`.
- **Mudança de decisão:** o ID do work-item passa a ser o **ID externo da história** (`HU-142-pagamento-pix`) em vez de `2026-001-…`; rastreia direto ao tracker.
- Extrator de `.docx` sem dependências (PowerShell), testado com `.docx` sintético (acentos, lista, tabela). **Não testado ainda** rodando a skill inteira no Claude Code nem com um Word real do seu fluxo → entra no piloto (Fase 5).
- Limites: imagens/diagramas e comentários de `.docx` **não são lidos, mas o extrator agora avisa** (e o aviso vira `[NEEDS CLARIFICATION]`); `.pdf` depende do leitor do Claude. Testado com `.docx` sintético (imagem, comentário, texto excluído, título, lista aninhada, arquivo travado); não testado com Word real.

## 6d. Crítica independente e cortes (2026-11-13)
Quatro críticos (Tech Lead Cético, Dev Sênior Usuária, Engenheiro de Contexto, Auditor de Honestidade) leram este repo e o `docs-compass`. Consenso: a ideia central ajuda, mas há mais texto que função (~5,5:1 doc/executável no blueprint segundo o Auditor) e **nenhuma economia de tokens foi medida**. Veredito resumido: parcial / usaria com cortes / alegação de tokens frágil / capricho 7 de 10.

**Aplicado:** extrator avisa imagens, comentários e alterações ignoradas; lê arquivo travado; títulos e listas aninhadas; skill sem `-ExecutionPolicy Bypass`, com tier `fix` (sem brief), filtro `~$`, ID exato, sem `source.md` para `.md`, sem `repos.md` obrigatório; SDD sem link para fora do repo (copia as RN); `AGENTS.md` curto + `CLAUDE.md`; alegações de tokens rebaixadas a hipótese em `docs/porque-sdd.md` e `docs/governanca-hitl.md`.

**Congelado até o teste A/B (não construir):** subagentes, hook de validação, `repos-registry`, scripts `link-repo`/`check`/`status`, tier Full como padrão, novos relatórios.

**Mantido:** skill `wi-ingest`, SDD lite com delta + `[NEEDS CLARIFICATION]`, `AGENTS.md` curto, convenção de nome.

**Teste A/B (1 semana, 3 histórias reais):** para cada história, (A) `CLAUDE.md` curto + texto da doc colado + "plano de mudança + tasks"; (B) `/wi-ingest` lite. Medir tokens totais (`/cost`), tempo até a primeira task aprovada, correções feitas no SDD, ambiguidades de negócio pegas antes de codar. Critério: B só se justifica se gastar ≤ A em tokens **ou** pegar ≥ 1 ambiguidade a mais por história, sem aumentar o tempo de revisão. Empate → ficar com A e apagar o resto.

**Fora deste repo (docs-compass), apontado pelos críticos:** contagem "12 de 12" não fecha com 15 execuções; `COMECE-AQUI.md` cita `corpus/lacunas.md` e `TESTE-AGENTES.md` cita um `CLAUDE.md` que não existem; teste circular (aliases e perguntas do mesmo gerador); script de busca nunca rodou; pasta local ainda `solucao-doc-brq`.

## 6e. Estado após fechar pendências (2026-11-13)
**Feito:** pastas `work-items/` (com `git init` local, sem remote) e `repos-project/{apis,microservices}` criadas ao lado deste repo; extrator em `.sh` (Linux/Git Bash) além do `.ps1`; skill prefere PDF/MD, depois `.sh`, depois `.ps1`, e trata bloqueio sem contornar; `allowed-tools` inclui `bash`; `AGENTS.md` e `CLAUDE.md` na raiz; `.gitattributes` fixa LF nos `.sh`; ruído de fim de linha do `sdd-template` limpo; `/.obsidian/` da raiz ignorado. No docs-compass: `CLAUDE.md` e `corpus/lacunas.md` criados, rótulo da contagem 12+2+1=15 esclarecido, três conjuntos de perguntas cegas (ver seção 18.1 do relatório de lá).

**Não fechável sem você:**
1. Rodar `/wi-ingest` com um **Word real** seu (tudo foi testado com `.docx`/PDF sintéticos e agente simulando o uso).
2. O **teste A/B com 3 histórias reais**. Feito com histórias falsas (ver `docs/relatorio-abordagens.md`): a skill gastou +18,6% de tokens e só ganhou em detecção no documento com conteúdo não-textual. A prova real segue pendente.
3. Testar o `.sh` numa **VM Linux real** (o WSL desta máquina não tem distribuição instalada).
4. Definir os repos reais em `repos-project/` (clones).
5. Decidir se o remote `work-items` existe e qual é.

**Meta de 90% (busca do docs-compass):** atingida só no conjunto de perguntas que usa o vocabulário dos docs (95% no top-3). Agrupando 60 perguntas, 80% no top-3 e 57% no top-1; nenhuma mudança de algoritmo ou glossário saiu do ruído. Não é um defeito corrigível por código neste corpus: ver o relatório do docs-compass.

## 7. Decisões em aberto
1. Scripts em **PowerShell**, Node ou Python?
2. `work-items/` como **repo git próprio** (recomendo) ou dentro deste?
3. Achatar `eng-blueprint/` interno?
4. Manter Obsidian com `[[wikilinks]]` (agentes leem bem texto, mas wikilinks não são caminhos de arquivo) ou migrar para links markdown relativos que ferramentas resolvem? *Recomendo links relativos + wikilinks só onde o Obsidian importar.*

---

## Fontes consultadas
- [Understanding SDD: Kiro, spec-kit, Tessl — Böckeler/Fowler](https://www.martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
- [Building software with Spec Kit — Xebia](https://xebia.com/blog/building-software-with-spec-kit/)
- [GitHub Spec Kit practical guide — Augment Code](https://www.augmentcode.com/guides/github-spec-kit-practical-guide-sdd-workflow)
- [Spec Kit — Microsoft Developer blog](https://developer.microsoft.com/blog/spec-driven-development-spec-kit/)
- [Context engineering for IDEs: AGENTS.md, Agent Skills — LogRocket](https://blog.logrocket.com/context-engineering-for-ides-agents-md-agent-skills)
- [How to structure context for AI agents — Nunes](https://medium.com/@lnfnunes/how-to-structure-context-for-ai-agents-without-wasting-tokens-16dd5d333c8d)
- [Progressive disclosure for AI agents — CodeMySpec](https://codemyspec.com/blog/progressive-disclosure)
- [CLAUDE.md token budget optimization](https://thepromptshelf.dev/blog/claude-md-token-budget-optimization/)

> Nota: as fontes são majoritariamente secundárias (blogs); números de economia de tokens são estimativas não verificadas. Validar na Fase 5 com seu próprio uso.
