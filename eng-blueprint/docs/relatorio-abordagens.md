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

## Reteste da skill `wi-ingest` (2026-11-13)

**Teste:** um agente executou o `SKILL.md` ao pé da letra num sandbox (docs-compass, work-items e repos-project em miniatura) com dois casos: `HU-150 repo-nucea lite` (Word com imagem, comentário e trecho excluído) e `HU-142 repo-nucea fix` (com um arquivo de trava `~$` do Word ao lado). Foi uma **execução simulada por agente, não uso real**, sobre `.docx` sintéticos.

**O que funcionou**
- O fluxo foi de ponta a ponta sem travar e parou nos dois pontos de revisão, sem implementar nem commitar.
- O extrator avisou imagem, comentário e alteração excluída, e os três viraram `[NEEDS CLARIFICATION]` no brief. Tratou `&` e tabela corretamente.
- Brief sem código, SDD sem link para fora do repo e RN copiadas: regras respeitadas.
- No tier `fix` não foi criado brief, como previsto.

**O que falhou ou ficou indefinido (a corrigir no SKILL.md e nos templates)**
1. O Glob com `..` no padrão (`../docs-compass/**/*ID*`) não funciona; é preciso passar a pasta no parâmetro `path`. O arquivo de trava `~$` também aparece nos resultados, e descartá-lo é manual.
2. O `<slug>` e o nome do arquivo do SDD não estão definidos (o agente inventou `sdd.md`).
3. No tier `fix` não há onde registrar o vínculo "Implementação", e o template `sdd-lite` ainda cita um brief que o `fix` não tem.
4. "Se o arquivo não mudou" não tem critério (hash? data de modificação?).
5. O brief sai quase todo em `[NEEDS CLARIFICATION]` quando o doc não traz solicitante, valor ou critérios, e a regra "não invente" conflita com o template que os exige.
6. O caso "política de execução bloqueia o script" **não foi exercitado**: a sessão do agente estava em `Bypass`.

**Nota do agente: 7/10 de executabilidade.**

**Comparado ao estado anterior:** antes a skill nunca tinha sido executada. Agora há uma execução completa registrada, mas feita por agente em sandbox. O que muda a nota só se confirma com um Word real seu (Fase 5 do PLANO).

### Segunda rodada (mesmo dia, skill já com as 5 correções)

Um agente novo, sem ver a rodada anterior, reexecutou os mesmos dois casos num sandbox limpo. **Nota: 6/10** (era 7/10). A queda não é regressão da skill: nesta rodada o extrator foi **bloqueado pela política de execução** (`Restricted`), que é o caso real da máquina e não tinha sido exercitado antes. O agente escreveu os dois `source.md` à mão para poder continuar (desvio dele, registrado).

**Resolvido:** slug e nome do arquivo do SDD; vínculo no tier `fix`; filtro do arquivo de trava `~$` (manual, funcionou); critério de dúvida bloqueante contra não bloqueante (aplicado de forma clara).

**Ainda falhava e foi corrigido em seguida (sem nova reexecução):**
1. O Glob não aceita caminho relativo em `path` (resolve contra outro diretório) → a skill agora manda montar o caminho absoluto.
2. O Glob não acha diretórios (passo 5) → agora lista com `Get-ChildItem -Directory`.
3. Extrator bloqueado deixava a skill sem caminho → agora oferece três saídas (liberar a política uma vez, colar o texto, ou salvar como `.md`/`.pdf`) e proíbe contornar, inclusive com `-Command` inline.
4. O vínculo do `fix` dentro do `source.md` seria apagado ao reextrair → agora vai em `vinculo.md`.
5. Faltavam regras para: repo sem `AGENTS.md`, `RN` sem `AC` possível, comportamento que o documento não define (não assumir) e conteúdo não lido (imagens, comentários) que não pode virar "assumida" em silêncio.

**Não verificado:** o critério "arquivo não mudou" por data de modificação (o extrator bloqueou), o tier `standard` e o `repos.md` com mais de um repo. Nenhum teste rodou com um Word real seu.

### Terceira rodada e testes dos extratores (2026-11-13)

**Extratores (testes diretos, sem agente)**

| Teste | Resultado |
|---|---|
| `.ps1` e `.sh` sobre os mesmos dois `.docx` sintéticos | Saída **idêntica caractere a caractere** (244 e 355 caracteres) |
| `.ps1` com `-ExecutionPolicy Restricted` | Bloqueado com a mensagem real do Windows |
| `.sh` na mesma situação | Funciona (não depende de política) |
| `.sh` sem `unzip`/`perl` no PATH | Diagnóstico claro, código de saída 2 |
| `.sh` com arquivo que não é zip (lock `~$` do Word) | "Não parece um .docx", código 1 |
| Read sobre um PDF mínimo | Devolve o texto **e** a página como imagem |

Observação de ambiente: o `CurrentUser` passou de `Undefined` para `RemoteSigned` entre duas medições (não foi alterado por esta sessão), o que explica por que o `.ps1` já rodava no Git Bash. O bloqueio só é reproduzível forçando `Restricted`.

**Skill com agente novo, em três casos mais bloqueio simulado: nota 8/10** (7 → 6 → 8 nas três rodadas).
- `HU-150` (docx): extrator com 3 avisos, que viraram dúvidas abertas; a dúvida bloqueante respondida foi registrada na `RN-1`.
- `HU-160` (PDF): Read funcionou; duas dúvidas bloqueantes sem resposta, sem task.
- `HU-142` (`fix`): vínculo em `vinculo.md`, lock `~$` filtrado, nada assumido.
- Bloqueio simulado: erro literal registrado, nada contornado, oferecidas as três saídas.
- Falhas antigas resolvidas: Glob com caminho absoluto, localização do repo, saída quando bloqueado, vínculo no `fix`, critério de dúvida bloqueante.

**Achados novos, já corrigidos no `SKILL.md` (sem nova reexecução):**
1. O `allowed-tools` só permitia `Bash(powershell *)` e `Bash(git *)`: o caminho `.sh` não estava autorizado (bug meu, introduzido com o `.sh`) → adicionado `Bash(bash *)`.
2. Ambiguidade `.sh` contra `.ps1` quando o ambiente é Windows com Git Bash → regra: `.sh` se `bash` e `unzip` existirem; `.ps1` só como segunda opção.
3. `git rev-parse` falha fora de repo git → usar o diretório atual.
4. PDF gerava dúvida sobre `source.md` → `source.md` só para `.docx`.
5. Faltavam regras para dúvida não bloqueante sem resposta (`aberta`, não impede o SDD), para o número de respostas que destravam o Gate 1 (todas as bloqueantes) e para repo sem código relevante (`ADDED: novo; local a definir`, como dúvida técnica).

**Não verificado:** o `.sh` numa VM Linux real e com um Word exportado de verdade; o critério "arquivo não mudou" por data; o tier `standard`; as correções desta rodada (não reexecutadas).

### Quarta rodada (fechamento de pendências, 2026-11-13)

Agente novo, sandbox limpo, três casos (`HU-150` docx, `HU-160` PDF, `HU-142` fix). **Nota: 8/10 — a meta de 9/10 não foi atingida.** Histórico das quatro rodadas: 7, 6, 8, 8.

**Funcionou sem ambiguidade:** escolha do `.sh` (existiam `bash`, `unzip` e `perl`), Glob com caminho absoluto, filtro do lock `~$`, leitura do PDF, vínculo no `fix`, nenhum comportamento assumido, nada implementado.

**Contradições reais no `SKILL.md` apontadas (corrigidas em seguida, não reexecutadas):**
1. Passo 4 mandava esperar todas as dúvidas bloqueantes e, na mesma frase, dizia que sem resposta a `RN` fica sem task → agora: pergunte e espere; se o usuário mandar seguir, a `RN` fica sem `AC`/task, marcada `bloqueante`.
2. Passo 7 tratava "entrada inválida" como dúvida técnica, enquanto o passo 4 a tratava como bloqueante → agora: comportamento que o negócio deve definir é dúvida de negócio (no brief); só estrutura e local do código são dúvida técnica.
3. Faltavam estados para dúvida respondida e para "assumida" sem dizer o quê → quatro estados definidos: `bloqueante`, `aberta`, `respondida: <…>`, `assumida: <…>`.
4. No tier `fix` não havia onde registrar dúvidas → `vinculo.md` ganhou a seção `## Dúvidas`.
5. O passo 5 usava `Get-ChildItem`, que só passava por `Bash(powershell *)` → agora `bash -c "ls -d …"`, coberto por `Bash(bash *)`.
6. O passo 6 não dizia quais seções da constitution aplicar → critério explícito (`testing` e `quality` sempre; `security`, `observability` e `stack` por condição).

**Leitura:** a nota parou em 8 porque cada rodada acha novas ambiguidades nas regras de dúvida, que são decisões de processo e não bugs. Não é possível garantir 9/10 sem outra reexecução, e agentes diferentes podem achar apontamentos diferentes. O que realmente valida a skill continua sendo um Word real seu.

## Teste A/B com histórias FALSAS (2026-11-13)

**O que é e o que não é.** Três histórias inventadas em Word (`HU-901` trivial, `HU-902` média com tabela, `HU-903` ruim, com imagem, comentário, trecho excluído e nota de rodapé), num repo TypeScript falso de 4 arquivos. Para cada história, dois agentes novos: **A (baseline)**, com um `CLAUDE.md` de 5 linhas e o texto colado como um usuário colaria (sem imagem, comentário, trecho excluído nem nota), que planeja e lista dúvidas; **B**, que roda `/wi-ingest` até o Gate 2. Não implementam nada. Tokens vêm do total de cada subagente (inclui a partida a frio). **Não substitui o teste com histórias reais.**

| História | Braço | Tokens | Chamadas | Tempo | Dúvidas sinalizadas | Plantadas achadas |
|---|---|---:|---:|---:|---:|---:|
| HU-901 (0 plantadas) | A | 53.805 | 10 | 27 s | 4 (todas especulativas) | 0/0 |
| HU-901 | B (`fix`) | 61.924 | 9 | 43 s | 1 (assumida) | 0/0 |
| HU-902 (3 plantadas) | A | 53.950 | 4 | 31 s | 14 | 3/3 |
| HU-902 | B (`lite`) | 63.915 | 9 | 58 s | 7 | 3/3 |
| HU-903 (7 plantadas) | A | 53.260 | 4 | 30 s | 12 | 4/7 |
| HU-903 | B (`lite`) | 65.056 | 10 | 52 s | 5 (3 bloqueantes + 2 abertas, estas cobrindo imagem, comentário, trecho excluído e nota) | 7/7 |
| **Total** | **A** | **161.015** | | | **30** | **7/10** |
| **Total** | **B** | **190.895 (+18,6%)** | | | **13** | **10/10** |

**Veredito pelo critério definido antes do teste** ("B só se justifica se gastar ≤ A em tokens **ou** pegar ≥ 1 ambiguidade a mais por história, sem aumentar o tempo de revisão"):
- **Tokens:** B gastou **mais** em todas as histórias (+15%, +18%, +22%). A primeira condição **não** é atendida.
- **Ambiguidades:** B achou 3 a mais, mas **todas na `HU-903`** (os elementos que o texto colado não carrega). Nas histórias só de texto, `HU-901` e `HU-902`, A achou o mesmo que B. A segunda condição vale em **1 de 3** histórias.
- **Ruído:** A listou 30 dúvidas contra 13 de B, a maioria especulativa (na `HU-901`, que não tem ambiguidade, A inventou 4). Isso reduz o tempo de revisão, mas não é um ganho de tokens.

**Conclusão:** neste teste, `/wi-ingest` **não se paga em tokens** e só se justifica quando o documento tem conteúdo que o texto colado perde (imagem, comentário, alterações, notas) ou quando é ruim. Para correção trivial só de texto, colar o texto no baseline é mais barato e achou o mesmo.

**Ressalvas:** (1) histórias e repo falsos, uma execução por caso, um só modelo; (2) o repo falso é minúsculo: num repo real o baseline lê mais código e o custo fixo do `/wi-ingest` (skill, templates, constitution, cerca de 8 a 12 mil tokens) pesa menos; (3) B também persiste brief e SDD reutilizáveis e faz o constitution check, e A não: as saídas não são equivalentes; (4) o braço A recebeu o texto sem o que o Word esconde, o que é justamente o cenário que o teste quer medir, mas um usuário atento pode ler o comentário e a nota no Word antes de colar.

**Ambiguidades do `SKILL.md` reveladas pelos três agentes B (corrigidas, não reexecutadas):** diretório do Bash reiniciado a cada chamada; formato do `vinculo.md`; "não informado" contra dúvida de negócio; status inicial do brief; campo Tier do template; ordem dos passos 5 e 8; frase vaga que não vira RN; lacuna de lint/cobertura no repo; marcação `(provável)` do local do delta.
