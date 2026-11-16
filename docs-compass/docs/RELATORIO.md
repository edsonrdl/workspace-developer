# Relatório: democratizar a documentação do sistema com IA

Documento completo da investigação: o problema, as soluções comparadas, como cada uma foi testada, os resultados, a recomendação, como usar e como manter. Documentos complementares: [CURADORIA.md](../CURADORIA.md) (regras para manter as referências dos docs), [DECISOES.md](DECISOES.md) (cada decisão, alternativas, evidência e consequências, com o diagrama do fluxo em [diagramas/fluxo-docs-compass.drawio](diagramas/fluxo-docs-compass.drawio)), [TESTE-AGENTES.md](TESTE-AGENTES.md) (segundo teste, com agentes Claude reais, sobre a IA consultar os docs em vez da internet) e [lab/sim/resultado.md](../lab/sim/resultado.md) (tabelas brutas geradas pela simulação).

> **Atualização após uma revisão crítica independente:** o corpus ganhou a seção `## For future agent` e o campo `confidence`, e a skill passou a só propor (não gravar) lacunas. A simulação foi reexecutada: as tabelas das seções 6 e 7 deste relatório vêm da execução **anterior** a essa mudança; os valores atuais estão em `lab/sim/resultado.md` (acerto top-3 até +0,3 ponto, tokens médios +2% a +5%, sem mudança de ranking). Os custos por pergunta dessas tabelas **não incluem** o corpo da skill (~935 tokens quando ela dispara).

> **Atualização após o teste com agentes reais:** o script `DocSearch.ps1` não rodou em nenhum agente (política de execução do PowerShell `Restricted` na máquina), e mesmo assim 12 de 12 respostas existentes saíram corretas pelo grep no frontmatter e pelos mapas. A skill foi ajustada para não depender do script. Detalhes e ressalvas em [TESTE-AGENTES.md](TESTE-AGENTES.md).

> **Reteste de 2026-11-13 (seção 18):** a simulação reproduz os mesmos números (é determinística, seed 7). Um teste novo, com 20 perguntas escritas por alguém que não viu aliases nem glossário, deu **top-1 de 45% (9/20) e top-3 de 80% (16/20)** na busca por seção, contra 71,9% e 84,3% da simulação. O top-3 ficou próximo; o top-1 ficou bem abaixo. Com mais dois conjuntos de perguntas (seção 18.1), o resultado agrupado é de 57% no 1º e 80% no top-3, e varia de 65% a 95% no top-3 conforme o estilo das perguntas.

## Índice

1. [Contexto e objetivo](#1-contexto-e-objetivo)
2. [Resumo executivo](#2-resumo-executivo)
3. [Conceitos usados](#3-conceitos-usados)
4. [As estratégias comparadas](#4-as-estratégias-comparadas)
5. [Como o teste foi feito](#5-como-o-teste-foi-feito)
6. [Resultados completos](#6-resultados-completos)
7. [O que os resultados ensinam](#7-o-que-os-resultados-ensinam)
8. [Limitações](#8-limitações)
9. [Arquitetura recomendada](#9-arquitetura-recomendada)
10. [Como usar no dia a dia](#10-como-usar-no-dia-a-dia)
11. [Plano de implantação](#11-plano-de-implantação)
12. [Curadoria: manter as referências atualizadas](#12-curadoria-manter-as-referências-atualizadas)
13. [Inventário de arquivos](#13-inventário-de-arquivos)
14. [Riscos e decisões em aberto](#14-riscos-e-decisões-em-aberto)
15. [Como reproduzir os testes](#15-como-reproduzir-os-testes)
16. [Teste com agentes Claude reais](#16-teste-com-agentes-claude-reais)
17. [Limites de escala: quando partir para RAG, arquivos grandes e links](#17-limites-de-escala-quando-partir-para-rag-arquivos-grandes-e-links)

---

## 1. Contexto e objetivo

Uma pessoa de outra equipe escreveu centenas de documentos `.md` sobre um sistema e funciona como "dono do conhecimento": o time pergunta tudo a ela. A coordenação quer **democratizar** esse conhecimento, para o time consultar sozinho, usando Claude Code ou outro agente de IA, e parar de interromper essa pessoa.

**Perguntas que o trabalho precisava responder**

- Onde ficam os arquivos: repositório central versionado ou algo que cada pessoa baixa?
- Como a IA acha o arquivo certo entre centenas, sem ler tudo?
- Como lidar com o caso em que a resposta está **no fim** de um arquivo cujo título não diz isso?
- Como manter isso atualizado depois?

**Restrições impostas**

- Sem embeddings/vetorização como base da solução.
- Sem subir API/servidor (custo e manutenção).
- Ideal: algo que rode local, com ferramentas que o time já tem.
- O repositório pessoal de "segundo cérebro" em Obsidian (arquivos `.md` ligados por links) serve de inspiração.

**Como foi atacado:** criei um corpus de docs inventados, implementei vários jeitos de recuperar informação, e simulei usuários de perfis diferentes fazendo perguntas, para ver qual jeito acerta mais gastando menos.

---

## 2. Resumo executivo

**Recomendação:** um repositório Git único (`docs-compass`) onde cada doc tem um **cabeçalho enriquecido** (título, resumo, aliases, perguntas), mais uma **busca local por seção** sem embeddings, mais **mapas de navegação** (MOC) gerados automaticamente como reserva, mais uma **skill do Claude Code** que só roteia (roda a busca; se falhar, navega pelos mapas).

**Números da simulação** (720 perguntas, 120 docs):

| Abordagem | Acerto | Tokens por pergunta |
|---|---:|---:|
| **Recomendada (S7)** | **97,2%** | **~720** |
| Skill com glossário plano de títulos (S1) | 56,5% | ~3.600 |
| Colocar todos os docs no contexto | n/d | ~105.000 |

**Três descobertas principais**

1. Um glossário plano de títulos falha por motivo estrutural: com título genérico acerta **0%**, e com títulos parecidos vira sorteio.
2. O que mais faz diferença é o **cabeçalho enriquecido** de cada doc. Escrito uma vez (o Claude pode gerar em lote), ele resolve o "resposta no fim do arquivo".
3. Indexar por **seção** em vez de por arquivo não muda muito o acerto, mas reduz o custo de ~1.600 para ~530 tokens por pergunta.

**Ressalva importante:** a IA que lê listas foi **simulada** com regras minhas, e o corpus é inventado. O ranking entre as estratégias é confiável; os percentuais absolutos não. O passo seguinte recomendado é validar com agentes Claude reais nos docs reais (seção 14).

---

## 3. Conceitos usados

| Termo | O que significa aqui |
|---|---|
| **Doc** | Um arquivo `.md` com conhecimento sobre um assunto. |
| **Seção** | Um bloco do doc que começa com `## Título`. A busca indexa e devolve seções. |
| **Frontmatter** | Bloco no topo do `.md`, entre `---`, com metadados. Aqui: `id`, `title`, `dominio`, `topico`, `resumo`, `aliases`, `perguntas`, `owner`, `atualizado`. |
| **Resumo** | Uma frase dizendo o que o doc responde, incluindo o que está no fim. É o campo mais importante. |
| **Aliases** | Jeitos como as pessoas falam o assunto sem usar o termo técnico (negócio, sintomas, erros, nomes antigos). |
| **MOC** (Map of Content) | Arquivo-índice que lista e descreve outros arquivos, com links. Aqui: `INDEX.md` (domínios) e `<dominio>/_INDEX.md` (tópicos e docs). |
| **Glossário** | `glossario.txt`: ensina sinônimos à busca (`termo técnico = alias 1 \| alias 2`). |
| **BM25** | Fórmula clássica de ranking por palavras (a mesma família usada em buscadores). Dá mais peso a palavras raras e não precisa de embeddings nem de servidor. |
| **Stem / radical** | A busca corta cada palavra nos 6 primeiros caracteres para "cobrança" e "cobrado" se parecerem. É uma aproximação simples. |
| **Token** | Unidade de custo de uma IA. Estimei como caracteres ÷ 4. |
| **Persona** | Um estilo de usuário que faz perguntas de um jeito próprio. |
| **Top-3** | Considerei acerto quando o doc certo está entre os 3 candidatos que a estratégia entrega ou que o agente abre. |
| **Divulgação progressiva** | A skill mantém só uma descrição curta sempre carregada; o conteúdo só entra no contexto quando necessário. |

---

## 4. As estratégias comparadas

Sete estratégias, de S1 (mais simples) a S7 (recomendada). Para cada uma: o que é, passo a passo, onde está, pontos fortes e fracos.

### S1: Skill com glossário plano de títulos

- **O que é:** o modelo mental mais comum de skill: uma lista com o título de todos os docs, e a IA escolhe pelo título.
- **Passo a passo:** a IA lê as 120 linhas (`id | título`), escolhe os 3 títulos mais prováveis e abre esses 3 arquivos inteiros até achar a resposta.
- **Onde está:** só no laboratório, função `Run-S1` em `lab/Simulate.ps1`.
- **Forte:** zero infraestrutura.
- **Fraco:** só vê o título. Título genérico = invisível; títulos parecidos = sorteio; a resposta no fim do arquivo só é achada depois de abrir o arquivo inteiro; a lista inteira é relida em toda pergunta (~1.400 tokens só nisso).

### S2: Agente com grep literal

- **O que é:** a IA usa busca de texto exata (grep/ripgrep) nos arquivos originais, sem cabeçalho enriquecido.
- **Passo a passo:** extrai as palavras da pergunta, conta quantas aparecem em cada doc, abre os 3 melhores. Se o melhor tem menos de 2 palavras casando, em 50% das vezes a IA "chuta" o termo técnico e tenta de novo.
- **Onde está:** só no laboratório, função `Run-S2`.
- **Forte:** funciona sem nenhuma preparação; ótimo para quem sabe o termo exato (persona sênior: 100%).
- **Fraco:** não entende sinônimos. Se a pessoa disser "teto" e o doc disser "limite máximo", não acha (persona PO: 28%).

### S3: MOC em 2 níveis (domínio, depois docs)

- **O que é:** navegação por mapas. Primeiro uma lista curta de domínios; depois a lista de docs daquele domínio, com resumo de uma linha.
- **Passo a passo:** a IA lê 6 linhas (domínios e seus tópicos), escolhe um domínio, lê as ~20 linhas dos docs dele (título + resumo), abre os 3 melhores.
- **Onde está:** a navegação é feita por arquivos reais: `corpus/INDEX.md` e `corpus/<dominio>/_INDEX.md`, gerados por `src/Gen-Index.ps1`. A simulação está em `Run-S3`.
- **Forte:** listas curtas em cada passo, a IA entende sinônimos, aproveita o resumo que conhece o fim do doc.
- **Fraco:** se escolher o domínio errado, falha; vários passos em sequência; depende do resumo estar bom.

### S4: BM25 por arquivo com cabeçalho

- **O que é:** um programa dá nota de relevância a cada **arquivo** usando título, resumo, aliases, perguntas e corpo.
- **Passo a passo:** o programa devolve os 5 melhores (~300 tokens de lista); a IA abre os 3 primeiros arquivos inteiros até achar.
- **Onde está:** só no laboratório (`Run-Doc`), usando a mesma biblioteca de busca do produto.
- **Forte:** sem depender do tamanho da lista; usa o cabeçalho.
- **Fraco:** sem glossário, não conhece vocabulário novo (estagiário: 43%); a IA lê o arquivo inteiro (~900 tokens cada).

### S5: MOC em 3 níveis (domínio, tópico, docs)

- **O que é:** como o S3 com um nível a mais, no estilo de um vault do Obsidian (hub por domínio, hub por tópico).
- **Passo a passo:** domínio (6 linhas), depois tópico (4 linhas, ex.: "Rate limiting - limite de requisições por cliente"), depois os 5 docs do tópico com resumo; abre os melhores.
- **Onde está:** nos mesmos `INDEX.md` e `_INDEX.md` (o `_INDEX.md` já agrupa por tópico). Simulação em `Run-S5`.
- **Forte:** listas pequenas a cada passo, que é onde a IA erra menos.
- **Fraco:** 3 leituras em sequência (latência), e um erro em qualquer nível derruba a resposta.

### S6: Busca por seção com cabeçalho e glossário

- **O que é:** o programa `src/DocSearch.ps1`. Divide cada doc em seções, dá nota a cada seção usando BM25, anexa a cada seção o contexto do cabeçalho (título, resumo, aliases, perguntas) e expande a pergunta com o glossário de sinônimos.
- **Passo a passo:** a pessoa (ou a IA) roda a busca; o programa devolve as 3 melhores seções, cada uma com `arquivo`, `seção` e `trecho`. A IA lê o trecho e responde. Não precisa abrir o arquivo.
- **Onde está:** produto real: `src/DocSearch.ps1`. Funciona de verdade na linha de comando.
- **Forte:** achou a resposta no fim do arquivo; custo baixo (~530 tokens); uma chamada só; sem servidor, sem embeddings.
- **Fraco:** depende de o cabeçalho e o glossário cobrirem o vocabulário de quem pergunta (estagiário 62%, suporte 75% antes do feedback).

### S7: S6 primeiro, mapas como reserva (recomendada)

- **O que é:** combinação. Tenta a busca (rápida e barata); se os trechos devolvidos não trazem a resposta, a IA navega pelos mapas (S5).
- **Passo a passo:** é o passo a passo da skill (`.claude/skills/consultar-docs/SKILL.md`): 1) rodar a busca; 2) se um trecho responde, responder citando arquivo e seção; 3) senão, ler `INDEX.md`, depois `_INDEX.md`, escolher e abrir só o doc certo; 4) se ainda assim não achar, dizer que não achou e registrar a lacuna.
- **Onde está:** não é um programa. É a combinação de `DocSearch.ps1` + os mapas + as instruções da skill. Em `Simulate.ps1` aparece como a função `Combine`.
- **Forte:** o melhor acerto e custo baixo, porque o caminho caro (mapas) só é usado quando a busca falha. A reserva compensa a fraqueza de vocabulário do S6.
- **Fraco:** depende de a IA perceber que o trecho não responde (assumi 90% de percepção).

### Variações do S6 usadas para medir cada peça (ablação)

| Variação | O que removi |
|---|---|
| S6a | O glossário de sinônimos |
| S6b | O cabeçalho enriquecido (usa os docs como o colega escreveu, sem frontmatter) |
| S4g | A divisão por seção (busca por arquivo, com glossário) |

---

## 5. Como o teste foi feito

### 5.1 O corpus inventado

Gerado por `lab/Gen-Corpus.ps1`, a partir de `lab/data/topics.txt` e `lab/data/aspects.txt`.

- **Tema:** uma plataforma de pagamentos fictícia, em 6 domínios: pagamentos, conciliação, antifraude, plataforma, observabilidade, segurança.
- **Tamanho:** 24 tópicos (ex.: Idempotência, Estorno, Chargeback, Rate limiting, Circuit breaker, Gestão de segredos) × 5 aspectos (limite, prazo, responsável, configuração, procedimento) = **120 docs**, ~570 palavras cada, ~105 mil tokens no total.
- **Estrutura de cada doc:** frontmatter + 4 seções de texto de enchimento + histórico de mudanças + uma seção final `## Anexo`.
- **A pegadinha proposital:** a resposta (um valor único por doc, ex.: "limite de 674 operações por minuto") fica **só na seção Anexo, no fim**. O enchimento menciona palavras como "prazo", "limite", "equipe responsável" em contexto irrelevante, para gerar ruído em buscas por palavra.
- **Títulos:** 50% descritivos ("Rate limiting - limite máximo"), 30% só do tópico ("Rate limiting - notas"), 20% genéricos ("Guia operacional plataforma nº37").
- **Cabeçalhos:** simulam um enriquecimento imperfeito por IA. Cada alias só entra com certa probabilidade (ex.: palavra de negócio principal 85%, segunda variante 35%, sintoma 60%/30%, palavra de aspecto 80%/50%/30%). Assim o enriquecimento **não é perfeito**.
- **Um exemplo real:** [corpus/pagamentos/idempotencia-limite.md](../corpus/pagamentos/idempotencia-limite.md).

### 5.2 As personas e as perguntas

6 personas × 120 docs = **720 perguntas**, cada uma com um doc-alvo conhecido (o gabarito). Cada tópico tem 2 formas de dizer em palavras de negócio, 2 de descrever como sintoma, e cada aspecto tem 3 formas de perguntar; cada pergunta sorteia uma.

| Persona | Como pergunta | Exemplo (tópico Idempotência, aspecto limite) |
|---|---|---|
| Sênior | Termo técnico exato | "Idempotência de requisições limite máximo" |
| Júnior | Palavras de negócio | "teto - evitar cobrança duplicada" |
| Suporte | Descreve o sintoma | "cliente foi cobrado duas vezes - quanto aguenta" |
| PO | Negócio + termo técnico | "evitar cobrança duplicada limite máximo" |
| Impaciente | 2 palavras: tópico + palavra curta | "Idempotência de requisições teto" |
| Estagiário | Variantes que nunca estão nos aliases | "garantir que o pedido não seja processado duas vezes valor máximo permitido" |

As perguntas são montadas por templates, não escritas por humanos.

### 5.3 Como cada estratégia foi executada

- **S4 e S6 (e variações) são programas reais** rodando sobre os arquivos de verdade: o mesmo `DocSearch.ps1` do produto.
- **S1, S3 e S5 envolvem a IA lendo uma lista**, que foi **simulada** por um "roteador":
  - O roteador entende sinônimos: uma linha pontua 2 se menciona o tópico (por termo técnico, termo de negócio ou sintoma) e +1 se menciona o aspecto. Ele sabe qual conceito a pergunta quer.
  - Ele **erra mais quando a lista é longa**: chance de reconhecer a linha certa de 98% (até 10 linhas), 93% (até 30), 85% (até 60), 75% (até 120), 60% (acima). É a premissa "lost in the middle".
  - Só vê o que está na linha: em S1, apenas o título (por isso título genérico dá 0%); em S3 e S5, título + resumo.
- **S2** simula o agente com grep, com a regra de segunda tentativa descrita acima.
- **S7** é calculado em cima dos resultados de S6 e S5 para as mesmas perguntas: se S6 acertou, fica com ele; se errou, em 90% dos casos o agente percebe e cai no S5 (somando os tokens dos dois).

### 5.4 O que contei

- **Sucesso top-3:** o doc certo entre os 3 candidatos. Para as estratégias que mostram seções (S6), conta se o doc certo está entre as 3 seções mostradas.
- **Acerto no 1º:** o doc certo é o primeiro candidato.
- **Tokens:**
  - Navegação (listas lidas): lista plana de títulos ~1.400; mapas ~100-500 conforme o nível; saída do grep ~30 por linha (até 40 linhas) + 80 por comando; lista de resultados do S4: 300.
  - Leitura: cada arquivo aberto custa ~900 tokens (tamanho do corpo ÷ 4), contando até o doc certo ou até os 3.
  - S6: custo do texto das 3 seções mostradas (+15 de overhead cada). Se o doc certo foi achado mas a seção mostrada **não** era a do Anexo, soma o custo de abrir o arquivo inteiro.
- **Sorteios:** cada pergunta × estratégia tem seed fixa, então o teste é reproduzível e a comparação é justa.

### 5.5 Ajustes feitos na busca durante o trabalho

- A seção exibida é a que mais casa com o **corpo** do texto; o **doc** é ranqueado usando também o cabeçalho. Sem isso a busca mostrava a primeira seção do doc em vez da que tem a resposta.
- Para escolher a seção, o BM25 usa saturação baixa de frequência (k1 = 0,3), para valorizar cobertura de termos distintos em vez de repetição do tópico.
- O texto só com o título (antes da primeira seção `##`) não é indexado como seção.
- Pesos do ranking: título ×3, resumo ×2, aliases ×2, perguntas ×2, heading ×2, corpo ×1; BM25 com k1 = 1,2 e b = 0,75.

---

## 6. Resultados completos

Seed 7. Todas as tabelas vêm de `lab/sim/resultado.md`.

### 6.1 Placar geral

| Estratégia | Acerto no 1º | Sucesso top-3 | Tokens médios | Tokens P90 |
|---|---:|---:|---:|---:|
| **S7** busca por seção + reserva em MOC | 71,8% | **97,2%** | 724 | 1.603 |
| S5 MOC 3 níveis | **95,1%** | 95,1% | 1.339 | 1.434 |
| S3 MOC 2 níveis | 91,8% | 91,8% | 1.830 | 1.923 |
| S6 busca por seção (cabeçalho + glossário) | 71,8% | 84,0% | **534** | 1.296 |
| S4g BM25 por arquivo + glossário | 70,0% | 82,8% | 1.629 | 2.880 |
| S6a S6 sem glossário | 65,1% | 76,1% | 848 | 1.518 |
| S4 BM25 por arquivo + cabeçalho | 61,1% | 74,6% | 1.775 | 2.936 |
| S6b S6 sem cabeçalho (docs legados) | 60,0% | 67,8% | 452 | 603 |
| S1 skill + glossário plano de títulos | 45,7% | 56,5% | 3.605 | 4.598 |
| S2 grep literal | 43,1% | 55,7% | 2.980 | 3.954 |
| Referência: todos os docs no contexto | n/d | n/d | ~105.140 | ~105.140 |

(Para S7, "acerto no 1º" só conta a primeira tentativa; a reserva em MOC é a segunda.)

### 6.2 Sucesso top-3 por persona

| Estratégia | Sênior | Júnior | Suporte | PO | Impaciente | Estagiário |
|---|---:|---:|---:|---:|---:|---:|
| S7 | 100 | 97 | 96 | 97 | 100 | 94 |
| S5 | 93 | 98 | 94 | 95 | 96 | 95 |
| S3 | 92 | 94 | 93 | 88 | 92 | 91 |
| S6 | 100 | 81 | 75 | 86 | 100 | 62 |
| S4g | 100 | 80 | 73 | 83 | 100 | 60 |
| S6a | 100 | 69 | 67 | 79 | 96 | 46 |
| S4 | 100 | 68 | 62 | 77 | 98 | 43 |
| S6b | 91 | 61 | 52 | 64 | 91 | 48 |
| S1 | 58 | 56 | 58 | 52 | 56 | 59 |
| S2 | 100 | 49 | 43 | 28 | 65 | 48 |

### 6.3 Sucesso top-3 por tipo de título do doc

| Estratégia | Descritivo | Só o tópico | Genérico |
|---|---:|---:|---:|
| S7 | 96 | 99 | 98 |
| S5 | 96 | 94 | 94 |
| S3 | 91 | 91 | 93 |
| S6 | 83 | 84 | 86 |
| S4g | 82 | 82 | 85 |
| S6a | 76 | 74 | 79 |
| S4 | 74 | 73 | 77 |
| S6b | 75 | 72 | **45** |
| S1 | 76 | 63 | **0** |
| S2 | 58 | 56 | 48 |

### 6.4 Ciclo de feedback do glossário

Experimento: as 115 perguntas que o S6 errou na rodada A viraram aliases no glossário (34 aliases novos, já descontadas as duplicatas). Depois testei com **720 perguntas novas** (rodada B).

| Versão | Acerto no 1º | Sucesso top-3 | Tokens médios |
|---|---:|---:|---:|
| S6 glossário inicial | 68,5% | 84,0% | 533 |
| S6 após 1 ciclo de feedback | 76,5% | 93,1% | 460 |
| **S7 após 1 ciclo de feedback** | 76,5% | **98,9%** | 544 |
| S5 (referência) | 95,1% | 95,1% | 1.339 |

O glossário inicial também foi simulado como imperfeito (cobre cada variante de frase com probabilidade entre 40% e 80%). O arquivo resultante está em `corpus/glossario.txt`.

---

## 7. O que os resultados ensinam

1. **Glossário plano de títulos (S1) tem limite estrutural.** Com título genérico = 0%; com títulos só do tópico, os 5 docs do mesmo assunto parecem iguais e sobra sorteio (teto ~60%). Não é problema de "a IA se perder na lista": a informação que decidiria não está no título.
2. **O cabeçalho enriquecido é a peça mais valiosa.** Sem ele (S6b), docs de título genérico caem para 45%. O `resumo` é a ponte para o fim do arquivo, porque quem o escreve (a IA, em lote) leu o doc inteiro.
3. **Busca por palavra (S2/S4) só serve a quem sabe o termo técnico.** O sênior acerta 100%; PO, suporte e estagiário caem para 28% a 62%.
4. **O glossário sozinho vale ~8 pontos** (S6a 76% para S6 84%), e cresce com o uso (93% após um ciclo).
5. **Indexar por seção reduz custo, não acerto:** S4g (por arquivo) 1.629 tokens vs S6 (por seção) 534 tokens, com acerto parecido.
6. **Mapas (S3/S5) são robustos ao vocabulário**, porque quem lê (a IA) entende sinônimos, e acertam 92-95%. Mas custam 2 a 3 vezes mais tokens e exigem 2-3 leituras em sequência.
7. **A combinação (S7) junta o melhor dos dois:** a busca resolve a maioria barato; os mapas pegam o resto. Resultado: 97-99% com custo médio abaixo do dos mapas isolados.
8. **Colocar tudo no contexto é inviável:** ~105 mil tokens por pergunta, com 120 docs. Com centenas, estoura o limite e a qualidade cai.

---

## 8. Limitações

Leia antes de apresentar os números a alguém.

1. **A IA foi simulada.** O roteador que "lê listas" entende sinônimos perfeitamente e erra segundo uma curva que eu defini (seção 5.3). Isso afeta S1, S3, S5 e o S7 (que usa S5 como reserva). O ranking das estratégias é mais confiável que os percentuais. Com um Claude real, S3/S5 podem ficar melhores (entende mais) ou piores (resumos reais são imperfeitos, listas reais são maiores).
2. **No corpus os resumos dos mapas são sempre corretos e completos.** Em S3/S5, o resumo de cada doc é gerado de forma determinística e menciona tópico e aspecto. Resumos reais escritos por IA terão falhas. Isso provavelmente superestima S3, S5 e S7.
3. **Corpus e perguntas sintéticos:** 1 fato por doc, perguntas por template, vocabulário limitado (2-3 variantes por conceito). Docs reais têm versões antigas, contradições, tabelas, imagens, termos ambíguos e duplicados.
4. **O ciclo de feedback é otimista:** as perguntas da rodada B reusam as mesmas poucas variantes de frase da rodada A; em produção o vocabulário é mais diverso.
5. **Latência e erros operacionais não foram medidos.** S5 exige 3 leituras em sequência; S6 é uma chamada. Também não medi o tempo de rodar a busca em milhares de docs (para 120 leva ~3 segundos por consulta no PowerShell, incluindo montar o índice a cada chamada).
6. **O custo em tokens é estimado** como caracteres ÷ 4.
7. **A busca tem radical simplificado** (6 primeiros caracteres) e lista de stopwords em português feita à mão.
8. **Dois bugs meus foram encontrados e corrigidos durante o trabalho:** um no simulador do grep (a lista de termos era embrulhada em um único elemento) e um na gravação do glossário (colisão de nomes de variável). Os resultados deste relatório são os pós-correção.

---

## 9. Arquitetura recomendada

### 9.1 Visão geral

```
                Repositório docs-compass (Git, fonte única da verdade)
   ┌──────────────────────────────────────────────────────────────────┐
   │  docs .md (cada um com frontmatter)   ← escritos/curados por humanos
   │  glossario.txt                         ← curado (sinônimos)
   │  INDEX.md, <dominio>/_INDEX.md         ← GERADOS por Gen-Index.ps1
   │  lacunas.md                            ← o que a IA não achou
   │  src/DocSearch.ps1 + Gen-Index.ps1     ← ferramentas
   │  .claude/skills/consultar-docs/SKILL.md         ← instrução para a IA
   └──────────────────────────────────────────────────────────────────┘
```

### 9.2 O caminho de uma pergunta (S7)

1. A pessoa pergunta ao agente (ex.: "erro 429, com quem falar?").
2. A descrição da skill (curta, sempre carregada) faz o agente disparar `consultar-docs`.
3. O agente roda `DocSearch.ps1 -Query "..." -Glossary corpus/glossario.txt -Top 3`.
4. A busca expande a pergunta com o glossário ("com quem falar" vira "equipe responsável"; "erro 429 na API" vira "Rate limiting"), dá nota a cada seção e devolve 3 trechos com arquivo e seção.
5. Se um trecho responde: o agente responde citando `arquivo` + `seção` e termina.
6. Se nenhum responde: lê `INDEX.md`, escolhe o domínio, lê `<dominio>/_INDEX.md`, escolhe o doc pelo resumo e abre só a seção pertinente.
7. Se ainda assim não achar: diz que não achou, **não inventa valores**, e registra a pergunta em `lacunas.md`.

### 9.3 Por que cada decisão

- **Repositório único em Git:** uma fonte da verdade, histórico, revisão por PR, e distribuição por `git pull`. Responde à dúvida "centralizado ou não": versionado e central; cada um tem uma cópia local.
- **Busca local em vez de API/servidor:** atende à restrição de custo e funciona offline; sem manutenção de infraestrutura.
- **Por seção:** é o que permite achar a resposta no fim de um arquivo longo e custar pouco.
- **Frontmatter + glossário:** é onde o conhecimento do curador entra. Substituem o que embeddings fariam (casar "teto" com "limite") por vocabulário explícito e revisável.
- **Mapas gerados, não escritos:** nunca ficam desatualizados em relação aos docs.
- **A skill como roteador:** ela não carrega o catálogo; só diz como procurar.

---

## 10. Como usar no dia a dia

O usuário **não escolhe estratégia**: pergunta, e a skill executa o S7.

### Terminal (opcional, só onde o PowerShell permitir scripts)

```bash
powershell -NoProfile -File src/DocSearch.ps1 -Query "erro 429, com quem falar?" -Glossary corpus/glossario.txt -Top 3
```

Devolve as 3 seções mais prováveis com arquivo, seção e trecho. Exemplo real: para essa pergunta, o primeiro resultado foi a seção `Anexo` do doc `rate-limit-responsavel` com "A equipe responsável por Rate limiting é a squad Nexus, canal #ratelimit-suporte...".

**Atenção:** em máquinas com a política de execução `Restricted` (padrão do Windows, e o caso da máquina de desenvolvimento) esse comando é bloqueado. Não é necessário liberar: a skill, nesse caso, usa grep nos docs e nos índices (seção 16). Liberar scripts é decisão de segurança da empresa.

### Claude Code

1. A skill já está em `.claude/skills/consultar-docs/` neste repositório. Em um repositório novo, copie a pasta.
2. Abra o Claude Code na **raiz** do repositório.
3. Pergunte normalmente; a skill dispara sozinha. O caminho que funcionou nos testes foi: grep em `corpus/` pelas palavras da pergunta (o frontmatter e o glossário ligam o jeito de falar ao doc), depois ler só a seção indicada.

### Antigravity (ou outros agentes)

Não verifiquei se ele lê o formato de skill do Claude Code; confira na documentação da ferramenta. O que funciona com qualquer agente que tenha terminal: colocar o conteúdo de `SKILL.md` no arquivo de regras/instruções do projeto que a ferramenta usa (por exemplo `AGENTS.md`). O agente roda o mesmo comando de busca.

### Observações práticas

- Os caminhos na skill (`src/DocSearch.ps1`, `corpus/...`) assumem a estrutura deste repositório. Se mudar, ajuste a skill.
- A ferramenta está em PowerShell porque a máquina de desenvolvimento não tinha Python nem Node. Para Mac/Linux, time que não usa PowerShell ou máquinas com a política `Restricted`, reescrever em Python ou Node leva cerca de 150 linhas. Isso vale também para `Gen-Index.ps1`, que gera os mapas.
- A busca remonta o índice a cada chamada (~3 s para 120 docs). Para milhares de docs, vale gravar o índice em arquivo.

---

## 11. Plano de implantação

| Fase | O que fazer | Resultado |
|---|---|---|
| 1 | Criar o repositório `docs-compass` e colocar os docs do colega em pastas por assunto (domínio). | Fonte única. |
| 2 | Enriquecer os docs em lote: o Claude lê cada doc inteiro e escreve o frontmatter (prompt na seção 6 do [CURADORIA.md](../CURADORIA.md)); um humano revisa. | Docs encontráveis. |
| 3 | Gerar os mapas (`Gen-Index.ps1`) e copiar a skill para `.claude/skills/`; `DocSearch.ps1` é opcional. Ver o risco da política de execução na seção 14. | Mapas + skill. |
| 4 | Montar 20-30 perguntas reais que o time faz ao dono do conhecimento, com a resposta esperada. Testar com agentes reais **nos docs reais** (o teste da seção 16 foi em docs inventados); preencher o `glossario.txt` com as falhas. | Números reais, glossário inicial. |
| 5 | Distribuir ao time (clonar o repo; skill em `.claude/skills/`). Ativar o registro de lacunas. | Uso real. |
| 6 | Rotina semanal de curadoria (lacunas, glossário, revisão de PRs). Escrever o lint de CI (seção 12). | Qualidade sustentada. |
| 7 (opcional) | MCP fino em volta da busca para outros agentes; índice em arquivo se o corpus crescer. | Mais alcance e escala. |

O dono atual do conhecimento passa de "atendimento" para **curador**: revisa o que o time escreve e fecha as lacunas.

---

## 12. Curadoria: manter as referências atualizadas

Um doc só é útil se for encontrável. Criar ou alterar um doc exige **atualizar a referência dele**:

| Referência | Onde | Quem atualiza |
|---|---|---|
| Frontmatter (`resumo`, `aliases`, `perguntas`) | topo do doc | autor, com ajuda do Claude |
| MOC (`INDEX.md`, `_INDEX.md`) | gerado | `Gen-Index.ps1`, a cada mudança |
| Glossário | `glossario.txt` | curador |

Regras completas, fluxos (doc novo, alterado, renomeado, obsoleto, lacuna), prompt para o Claude e checklist de PR estão em **[CURADORIA.md](../CURADORIA.md)**.

**Ainda não automatizado:** o lint de CI que falha PR com frontmatter incompleto, título genérico, `id` diferente do arquivo ou índices desatualizados; o aviso de docs com `atualizado` antigo; suporte a `status: obsoleto` na busca. Hoje isso depende de disciplina e do checklist.

---

## 13. Inventário de arquivos

### Produto (copiar para o repositório real)

| Arquivo | Necessidade |
|---|---|
| `src/DocSearch.ps1` | **Opcional.** A busca por seção (S6). Só roda onde o PowerShell permite scripts; nos testes com agentes nunca rodou e a solução funcionou mesmo assim. |
| `src/Gen-Index.ps1` | Gera `INDEX.md` e `<dominio>/_INDEX.md` lendo os cabeçalhos. Sem ele os mapas não existem nem se atualizam. Também é PowerShell (mesmo risco). |
| `.claude/skills/consultar-docs/SKILL.md` | Instrução ao agente (versão V1): regra de fontes interno/externo, grep como caminho principal, mapas como reserva, cita arquivo e seção, admite quando não achou. É o S7 na prática. |
| `COMECE-AQUI.md` | Onboarding de quem baixa o repositório. |
| `DECISOES.md` | Registro de cada decisão (contexto, alternativas, evidência, consequências) e versão em texto do fluxo. |
| `docs/diagramas/fluxo-docs-compass.drawio` | Diagrama do fluxo completo: curadoria, repositório, Obsidian e agente de IA. Abrir no app.diagrams.net. |
| `.gitignore` | Ignora `.obsidian/` (configuração local do Obsidian) e logs da simulação. |
| `corpus/glossario.txt` | Sinônimos consultados pela busca. |
| `corpus/INDEX.md`, `corpus/<dominio>/_INDEX.md` | Mapas gerados. Não editar à mão. |
| `corpus/lacunas.md` | Registro do que a IA não achou (criado quando houver a primeira lacuna). |
| `CURADORIA.md` | Regras de manutenção das referências. |
| Os docs `.md` | O conteúdo. No exemplo, `corpus/<dominio>/*.md`. |

### Laboratório (só para comparar estratégias; não vai ao repositório real)

| Arquivo | Necessidade |
|---|---|
| `lab/Gen-Corpus.ps1` | Inventa os 120 docs de teste. |
| `lab/Simulate.ps1` | Roda a competição; contém o código das estratégias S1, S2, S3, S4, S5 e as variações; gera `lab/sim/resultado.md` e `corpus/glossario.txt`. |
| `lab/data/topics.txt`, `lab/data/aspects.txt` | Vocabulário (termos técnicos, de negócio, sintomas, aspectos) para inventar docs e perguntas. |
| `lab/sim/resultado.md` | Tabelas completas do último teste. |
| `lab/sim/truth.tsv` | Gabarito: tipo de título de cada doc. |
| `RELATORIO.md` | Este documento. |
| `TESTE-AGENTES.md` | Registro detalhado do teste com agentes Claude reais (seção 16). |

Observação: o `Simulate.ps1` sobrescreve `corpus/glossario.txt` a cada execução (o glossário de exemplo vem da simulação). No repositório real, o glossário é curado à mão.

---

## 14. Riscos e decisões em aberto

| Item | Risco / decisão |
|---|---|
| Validação com IA real | Feita em parte (seção 16, 15 agentes reais, docs inventados). Falta validar com perguntas reais do time nos docs reais e testar o disparo real da skill no Claude Code (foi emulado). |
| Política de execução do PowerShell | `Restricted` bloqueia `DocSearch.ps1` e `Gen-Index.ps1`. Não liberar sem decisão da TI. A busca funciona via grep; a geração dos mapas precisa de alternativa (portar para Python/Node, ou rodar no CI, onde a política deve ser confirmada). |
| Escala do grep | Funcionou em 120 docs. Com milhares de docs ou cabeçalhos mal preenchidos pode falhar; a saída é portar a busca por seção para Python/Node. |
| Qualidade do enriquecimento | Se o `resumo` e os `aliases` forem ruins, o desempenho cai (S6b mostra o efeito). A revisão humana é necessária. |
| Disciplina de curadoria | Sem lint de CI, o frontmatter e os índices podem ficar defasados. |
| Docs obsoletos ou contraditórios | O corpus de teste não os modelou. Precisam de regra e de status (seção 12). |
| Linguagem da ferramenta | PowerShell por limitação do ambiente de desenvolvimento. Decidir se o time prefere Python ou Node. |
| Escala | Para milhares de docs, persistir o índice em arquivo. |
| Compatibilidade com Antigravity e outros | Não verificada; usar regras do projeto (por exemplo `AGENTS.md`) como caminho seguro. |
| Quem é o curador | Definir formalmente (hoje, o dono do conhecimento) e a carga de trabalho semanal. |

---

## 15. Como reproduzir os testes

Na raiz do projeto, com Windows PowerShell:

```bash
powershell -NoProfile -File lab/Gen-Corpus.ps1
powershell -NoProfile -File src/Gen-Index.ps1
powershell -NoProfile -File lab/Simulate.ps1
```

- Leva cerca de 2 minutos; gera os docs, os mapas, `lab/sim/resultado.md` e `corpus/glossario.txt`.
- `Gen-Corpus.ps1` usa seed 42 e `Simulate.ps1` usa seed 7: rodar de novo dá os mesmos números.
- A busca ignora `INDEX.md`, `_INDEX.md` e `lacunas.md` como conteúdo (o leitor de corpus exclui esses nomes); o `glossario.txt` não é lido como doc por não ser `.md`.
- **Estes scripts são PowerShell** e só rodam com a política de execução que permita (a de desenvolvimento rodou por outro mecanismo). Em máquina `Restricted` eles são bloqueados.

---

## 16. Teste com agentes Claude reais

Detalhes completos em [TESTE-AGENTES.md](TESTE-AGENTES.md). Resumo:

**Pergunta:** o agente consulta os docs ou foge para a internet e a memória? **Método:** 15 agentes Claude (Sonnet), em 3 rodadas, numa cópia limpa do repositório, com WebSearch/WebFetch liberados; telemetria autodeclarada; respostas conferidas contra o gabarito.

| Resultado | Valor |
|---|---|
| Perguntas com resposta nos docs | 12 de 12 corretas, com arquivo e seção citados |
| Perguntas sem resposta nos docs (cashback, programa de pontos) | 2 de 2: "não encontrei", sem inventar valor |
| Uso da web | 1 de 15 (limite da Stripe, rotulado como externo) |
| Estilo do prompt (simples, "na empresa", aspas, sintoma) | Sem diferença: todos acertaram |
| `DocSearch.ps1` | Nunca rodou (política de execução); os agentes não contornaram e usaram grep + mapas |

**O que isso muda no desenho:**
- O que sustentou o acerto foi o **frontmatter enriquecido + glossário + mapas**, não o ranking por seção. Isso reforça a prioridade da curadoria (CURADORIA.md).
- A skill passou a ser V1: grep como caminho principal (script opcional), regra de fontes (interno só dos docs; público/terceiros pode usar web, rotulado como "Externo"), não citar contexto geral como fato, e definição de `owner` (mantenedor do doc, não equipe operacional).
- A internet **não foi bloqueada**: nenhum agente usou a web para fato interno.

**Limites do teste:** disparo da skill emulado, corpus pequeno e inventado, busca por seção não exercitada por agentes, uma execução por pergunta e um só modelo, telemetria autodeclarada, perguntas escolhidas por mim.

**Recomendação de `CLAUDE.md`** para a raiz (testado na condição "só CLAUDE.md"): texto em [TESTE-AGENTES.md](TESTE-AGENTES.md). Ainda não foi criado no repositório.

---

## 17. Limites de escala: quando partir para RAG, arquivos grandes e links

**Aviso:** tudo o que foi **medido** vem de 120 docs inventados (~570 palavras e ~880 tokens cada, ~105 mil tokens no total, sem links entre docs). As faixas abaixo são **estimativas de engenharia**, não resultados de teste. Devem ser confirmadas com os docs reais.

### 17.1 Até onde vai a solução atual, e quando pensar em RAG com vetores

**Esclarecimento de termos:** o que construímos já é recuperação de informação para a IA (busca + leitura de trechos), a ideia central do RAG. O que não usamos é **embeddings/vetores**. Então a pergunta real é: *até onde funciona sem vetores?*

| Tamanho do acervo (estimativa) | O que esperar |
|---|---|
| Até ~300 a 500 docs | Frontmatter bem preenchido + glossário + grep + mapas. É a faixa onde temos evidência (120 docs, 12 de 12). |
| ~500 a 2.000 docs | O grep começa a devolver muito resultado e os mapas ficam longos. Precisa de busca com ranking e índice gravado em arquivo (BM25 em Python/Node, o que o `DocSearch.ps1` faz). Ainda sem vetores. |
| Acima de ~2.000 docs, ou acervo pouco estruturado | Aí embeddings passam a compensar, principalmente para casar vocabulário diferente. Exigem um modelo de embeddings (local ou API) e um índice que alguém precisa manter. |

**Sinais práticos para decidir a migração** (mais confiáveis que o número de docs):

1. O grep devolve **mais de ~50 ocorrências** para perguntas comuns, e a IA gasta contexto filtrando.
2. Em `lacunas.md`, mais de **~10 a 15%** das perguntas são casos em que o doc existe mas não foi achado.
3. O glossário cresce sem parar (centenas de entradas) e o curador não dá conta.
4. Os usuários perguntam com palavras muito diferentes das dos docs, e os aliases não acompanham.
5. Os docs não têm frontmatter e ninguém vai preenchê-lo (sem ele, a solução perde o que a sustenta: ver S6b na seção 6).
6. O `_INDEX.md` de um domínio passa de ~30 a 50 linhas (a simulação assumiu que a IA erra mais em listas longas; a premissa não foi validada com IA real).

**Colocar tudo no contexto não é alternativa:** 120 docs já são ~105 mil tokens por pergunta. Mesmo com modelos de contexto grande, o custo e a qualidade pioram.

**Para o escopo atual:** não precisa de RAG com vetores. A migração só se justifica se os sinais acima aparecerem.

### 17.2 Limitações de arquivos grandes

Nosso corpus tem docs curtos. Docs reais costumam ser maiores. Riscos:

| Limitação | Efeito | Mitigação |
|---|---|---|
| **Doc sem títulos `##`** | O indexador divide por `## `. Sem eles, o arquivo inteiro vira um bloco único e o benefício da busca por seção some | Exigir títulos; subdividir com `###` |
| **Seção gigante** | Mesmo o bloco certo pode ter milhares de tokens | Limite de tamanho por seção (sugestão: ~150 linhas) |
| **Arquivo longo lido inteiro** | O agente tem limite de leitura por chamada e gasta contexto; arquivos muito grandes são truncados ou exigem leitura em partes | Usar grep com número de linha e ler só a faixa em volta do trecho achado |
| **Muitos fatos num só arquivo** | O `resumo` (uma frase) não consegue descrever tudo; o doc passa a ser achado só por parte do conteúdo | Dividir em docs menores, um aspecto por doc (como no corpus de teste) |
| **Conteúdo que não é texto** (tabelas complexas, imagens, diagramas, PDFs) | Não é indexado nem lido como texto | Descrever em texto no doc; converter PDFs para `.md` |
| **Fato escondido no fim** | É o que o `resumo` resolve, mas só se estiver bem escrito | Regra de curadoria: o resumo cita o que há no fim |

Sugestão de regra (lint futuro): tamanho máximo por doc (ex.: 300 a 500 linhas), tamanho máximo por seção, e obrigatoriedade de títulos `##`. **Não testado:** nunca rodei a busca nem os agentes em arquivos grandes.

### 17.3 Limitações de arquivos linkados e como avaliar

No corpus de teste, os docs **não têm links entre si** (só os mapas apontam para os docs). Portanto o comportamento com links **não foi testado**.

**Limitações esperadas**

| Limitação | Efeito |
|---|---|
| **O agente não segue links sozinho** | Só abre o doc linkado se decidir; cada salto custa uma chamada e tokens |
| **Resposta partida entre docs** | O agente pode responder com a metade encontrada e parecer completo |
| **Link quebrado** (após renomear ou mover) | Leva a lugar nenhum; a regra 4.3 da curadoria existe por isso |
| **Link para fora do repositório** (Confluence, SharePoint, URL interna) | O agente pode não ter acesso; o conteúdo pode estar desatualizado |
| **Anexos** (PDF, imagem) | Não são pesquisados |
| **Cadeias longas de links** | Custo alto e risco de se perder |
| **O grafo de links não alimenta a busca** | A nossa busca não usa links nem backlinks; o grafo do Obsidian serve a humanos |

**Como avaliar (três camadas)**

1. **Estática (barata, pode ser feita por grep ou um script):** contar links quebrados (`[[x]]` ou `](x.md)` cujo alvo não existe), docs órfãos (sem nenhum link de entrada e fora dos mapas), docs com muitos links de saída e profundidade das cadeias.
2. **Comportamental (teste com agentes, como o da seção 16):** montar perguntas cuja resposta **precisa de 2 ou mais docs ligados** (ex.: "responsável e prazo do chargeback", quando estão em docs diferentes). Medir: taxa de respostas **completas**, número de saltos, tokens, e se o agente declara o que deixou de ler. A métrica crítica é a **resposta parcial apresentada como completa**.
3. **Política de desenho:** fato que responde a uma pergunta comum **não deve ficar atrás de um link**; links são para "saiba mais". Quando a resposta depende de outro doc, o `resumo` deve dizer isso ("para X, ver [[doc]]"). Sugestão (não implementada): campo `relacionados:` no frontmatter com os `id` dos docs vizinhos.

### 17.4 O que testar a seguir (resumo)

1. Rodar o mesmo teste da seção 16 nos **docs reais**, com 20 a 30 perguntas reais.
2. Incluir nesse teste: **um doc grande** (500+ linhas) e **perguntas multi-doc** com links.
3. Medir os sinais da seção 17.1 (ocorrências do grep, falhas em `lacunas.md`) por algumas semanas de uso, para decidir a migração com dados.

## 18. Reteste (2026-11-13): perguntas escritas às cegas

**Por que:** uma revisão crítica apontou que os aliases do corpus e as perguntas da simulação saem do mesmo gerador, então o resultado era circular. Este teste tira essa circularidade na parte da busca.

**Como:**
1. A simulação original (`lab/Simulate.ps1`) foi rodada de novo numa cópia do repositório.
2. Um agente que nunca viu o repositório leu só o **corpo** de 20 docs (1 a cada 6, a partir do 3º, em ordem de caminho), sem frontmatter, glossário, índices ou código, e escreveu uma pergunta por doc com as próprias palavras.
3. Cada pergunta foi passada em `src/DocSearch.ps1 -Top 3`, com e sem `corpus/glossario.txt`. Contou-se em que posição o doc certo apareceu. Dados em `lab/blind/questions.tsv` e `lab/blind/results.csv`.

**Resultados**

| Medida | Simulação (S6, mesma estratégia) | Teste cego (20 perguntas) |
|---|---:|---:|
| Doc certo em 1º, com glossário | 71,9% | **45% (9/20)** |
| Doc certo no top-3, com glossário | 84,3% | **80% (16/20)** |
| Doc certo em 1º, sem glossário | 65,6% | 40% (8/20) |
| Doc certo no top-3, sem glossário | 76,2% | 75% (15/20) |

- **Simulação reproduzida:** S7 com 97,2% no top-3 e 742 tokens médios, idêntico ao `lab/sim/resultado.md` já versionado. Isso confirma que o código é determinístico, não que o número vale no mundo real.
- **Top-3 próximo, top-1 pior:** o top-3 (80%) fica perto do simulado, mas o top-1 (45%) está bem abaixo (71,9%). Na prática o agente precisa olhar mais de um candidato.
- **Glossário:** ajudou em 1 pergunta de 20. Com n tão pequeno, não dá para afirmar efeito.
- **Falhas (com glossário):** `observabilidade/alertas-oncall-config`, `pagamentos/estorno-procedimento`, `plataforma/feature-flag-prazo` e `plataforma/rate-limit-procedimento`.

**Limites deste reteste (leia antes de citar os números)**
- **n = 20.** O intervalo de confiança de 95% (Wilson) é de cerca de 58% a 92% para o top-3 e de 26% a 66% para o top-1.
- **O corpus continua inventado.** Segundo o agente autor, quase todo o corpo dos docs é texto de enchimento e o fato específico fica na seção "Anexo". Isso facilita a busca por palavras e não representa docs reais.
- **Só mediu o S6** (busca por seção). O **S7 não foi retestado**: o 97,2% depende de o agente cair nos mapas (MOC) quando a busca falha, e a taxa de 90% de "o agente percebe" continua **assumida**, não medida.
- **Política de execução:** nesta sessão os scripts rodaram porque o processo do agente estava com a política em `Bypass`. Em um shell comum a política da máquina é `Restricted` (`LocalMachine`). O teste não prova que o `DocSearch.ps1` rode no seu terminal.
- **Não é teste com agente de IA.** A busca foi chamada direto pelo script; o desempenho do agente lendo o grep e os mapas segue medido só pelos 15 testes da seção 16 (1 execução por pergunta, 1 modelo).

**Conclusão:** a simulação não deve ser citada como taxa de acerto esperada. O número mais honesto hoje para a busca por seção em corpus inventado é **cerca de 80% no top-3 e cerca de 45% no 1º**, com margem grande. Falta rodar com docs reais e perguntas de quem as usa (seção 17.4).

### 18.1 Três conjuntos de perguntas: o número depende de quem pergunta

Para tentar chegar a 90%, foram escritos mais dois conjuntos cegos, por agentes diferentes e sobre docs diferentes (B e C, 20 perguntas cada). Em B, 3 docs coincidem com A. Em C, nenhum.

| Conjunto | Estilo das perguntas | Top-1 | Top-3 |
|---|---|---:|---:|
| A | paráfrase coloquial | 9/20 (45%) | 16/20 (80%) |
| B | paráfrase coloquial | 7/20 (35%) | 13/20 (65%) |
| C | usa as palavras dos docs ("valor de configuração", "limite por minuto", "SLA") | 18/20 (90%) | 19/20 (95%) |
| **Agrupado (60)** | | **34/60 (57%)** | **48/60 (80%)** |

O intervalo de confiança de 95% do top-3 agrupado é de cerca de 68% a 88%, e o do top-1 de cerca de 44% a 68%. **A meta de 90% foi atingida só no conjunto C**, que reflete quem já conhece o vocabulário do doc. Para quem pergunta com as próprias palavras, o resultado fica entre 65% e 80% no top-3.

**Tentativas de melhorar a busca** (feitas numa cópia; nada foi alterado em `src/` nem em `corpus/`):

| Variante | Top-1 (60) | Top-3 (60) |
|---|---:|---:|
| Original | 34 | 48 |
| Alias do glossário por conjunto de raízes (em vez de frase contígua) + 30 formas gerais de perguntar cada aspecto | 32 | 49 |
| Mesma + normalização leve de terminações (falar, falo, fala) | 36 | 48 |

Todas ficaram dentro do ruído (±2 perguntas). **Conclusão: o gargalo não é o algoritmo.** A maior parte das falhas acha o tópico certo e erra o aspecto (responsável, limite, prazo, procedimento, configuração), por diferença de vocabulário entre a pergunta e o doc.

**Atalho não tomado, de propósito:** dar peso extra ao sufixo do nome do arquivo (`-responsavel`, `-limite`) subiria o número, mas só funciona neste corpus inventado, onde todo doc tem cinco aspectos de nome fixo. Não funcionaria com docs reais.

**O que provavelmente move o número com docs reais:** curar `aliases` e `perguntas` no frontmatter com as palavras que o time realmente usa (o ciclo de lacunas da seção 12), e medir com perguntas reais. Os dados e o runner estão em `lab/blind/`.
