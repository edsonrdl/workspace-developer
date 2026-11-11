# Como se chegou a este resultado

Registro do caminho percorrido: o problema, a iniciativa de testar várias soluções em paralelo com usuários simulados, as personas, os testes com agentes reais e o RAG sem vetores que resultou. Os números e as ressalvas completos estão em [RELATORIO.md](RELATORIO.md) e [TESTE-AGENTES.md](TESTE-AGENTES.md); o porquê de cada escolha está em [DECISOES.md](DECISOES.md).

## 1. O ponto de partida

Uma pessoa de outra equipe escreveu centenas de documentos `.md` sobre um sistema e é a única que sabe onde está cada resposta. A coordenação pediu uma forma de democratizar esse conhecimento para o time parar de perguntar a ela, usando Claude Code ou outro agente de IA.

**Restrições definidas por quem conduziu o trabalho:**

- Sem embeddings/vetorização como base. Subir API ou servidor seria custoso.
- A IA precisa saber do que cada doc trata sem ler tudo, mesmo quando a resposta está no fim do arquivo.
- Ficar centralizado ou distribuído? Repositório versionado, ou algo que cada pessoa baixa.
- Um glossário com 100 títulos lido pela skill não resolve; era preciso analisar a arquitetura de skill e uma estratégia melhor.

## 2. A iniciativa: soluções diferentes competindo, com usuários simulados

Em vez de escolher uma solução por opinião, a decisão foi **deixar várias soluções com comportamentos diferentes competirem**, testadas por **vários usuários simulados**, na linha de uma simulação multiagente (a referência citada foi o MiroFish; essa ferramenta **não** foi usada, só a ideia). Também se pediu que fossem **inventados docs** para os testes, já que não havia o acervo real.

### 2.1 O material de teste

- **120 docs inventados** de uma plataforma de pagamentos fictícia: 6 domínios, 24 tópicos, 5 aspectos por tópico (limite, prazo, responsável, configuração, procedimento).
- A resposta de cada doc fica **só na última seção**, justamente o caso que preocupava. 20% dos docs têm título genérico ("Guia operacional nº37") e 30% têm só o tópico, sem o aspecto.
- O texto de enchimento repete palavras como "prazo" e "limite" em contextos irrelevantes, para gerar ruído em buscas por palavra.

### 2.2 As personagens (usuários simulados)

Seis personas, 120 perguntas cada, **720 perguntas** no total, cada uma com um doc-alvo conhecido:

| Persona | Como pergunta | Fraqueza que expõe |
|---|---|---|
| Sênior | Termo técnico exato | Quase nenhuma: serve de controle |
| Júnior | Palavras de negócio ("teto", "evitar cobrança duplicada") | Vocabulário diferente do dos docs |
| Suporte | Descreve o sintoma ("cliente foi cobrado duas vezes") | Pergunta sem o termo técnico |
| PO | Negócio misturado com termo técnico | Vocabulário misto |
| Impaciente | Duas palavras | Pouca informação |
| Estagiário | Variantes que ninguém previu nos aliases | Vocabulário fora de qualquer lista |

### 2.3 As soluções que competiram (cada uma com um comportamento)

| | Comportamento |
|---|---|
| S1 | Skill com glossário plano de títulos: a IA lê os 120 títulos e abre 3 arquivos |
| S2 | Agente com grep literal nos docs originais |
| S3 | Mapa em 2 níveis (domínio, docs com resumo) |
| S4 | Ranking BM25 por arquivo, usando o cabeçalho |
| S5 | Mapa em 3 níveis (domínio, tópico, docs), estilo vault do Obsidian |
| S6 | Busca por **seção** com cabeçalho e glossário de sinônimos |
| S7 | S6 primeiro; se não achar, navega pelos mapas (S5) |

Mais três variações de S6/S4 para medir o valor de cada peça: sem glossário, sem cabeçalho (docs "legados") e por arquivo em vez de por seção.

### 2.4 O teste em paralelo para escolher a configuração

As **9 configurações executadas (mais a combinação S7, calculada sobre S6 e S5) rodaram sobre as mesmas 720 perguntas**, com sorteios de semente fixa (comparação justa e reproduzível), medindo acerto no doc certo (top-3) e tokens gastos. Isso é o que permitiu escolher por evidência:

- S1 e S2, as abordagens mais comuns, ficaram em torno de **56%**, com título genérico em **0%** (S1).
- Os mapas (S3/S5) acertaram 92 a 95%, mas gastam 2 a 3 vezes mais tokens.
- A busca por seção (S6) é a mais barata, mas falha com vocabulário novo (84%).
- **S7** juntou os dois: **97,2% de acerto com a menor média de tokens entre as de alto acerto**.
- As variações mostraram o valor de cada peça: o cabeçalho evita o 0% em título genérico, o glossário vale cerca de 8 pontos, e indexar por seção reduz o custo de ~1.700 para ~550 tokens por pergunta.
- Um ciclo de feedback (transformar as perguntas que falharam em aliases do glossário) subiu a busca de 84% para 93%.

## 3. O segundo nível de teste: agentes Claude reais, também em paralelo

A simulação usa uma IA modelada. Para ver o comportamento real, foram lançados **15 agentes Claude reais** em 3 rodadas, **vários ao mesmo tempo em cada rodada**, numa cópia limpa do repositório e com a internet liberada:

- **Rodada 1:** 5 agentes, perguntas simples, skill original.
- **Rodada 2:** 6 agentes, perguntas difíceis (conceito público, "processo da empresa", aspas, mistura de externo e interno) e duas condições sem a skill (só a pasta, e só com regras de `CLAUDE.md`).
- **Rodada 3:** 4 agentes com a **skill ajustada** (V1), perguntas sem termo técnico, sintoma de cliente, "nosso processo" e uma pergunta sem resposta nos docs.

Comparar a skill original com a ajustada, e as condições com e sem skill, foi a **seleção da configuração ideal** na prática. O que saiu disso:

- 12 de 12 perguntas com resposta nos docs foram respondidas corretamente, com arquivo e seção citados.
- As 2 perguntas sem resposta nos docs ("cashback", "programa de pontos") terminaram em "não encontrei", sem inventar.
- A web foi usada 1 vez em 15, no caso certo (um limite de terceiro), rotulado como externo. **Não foi preciso bloquear a internet**, o que foi uma decisão de quem conduziu.
- O script de busca em PowerShell foi bloqueado pela política `Restricted` em todas as tentativas. Os agentes não contornaram e mesmo assim acertaram, usando grep e os mapas. **Isso reorientou o desenho:** a skill passou a ter o grep como caminho principal e o script como opcional, e a política não foi liberada.
- Os agentes revelaram uma ambiguidade (`owner` do doc contra a equipe operacional) e a skill passou a tratar disso.

Uma revisão crítica independente, também feita por agentes, levou a adotar a seção `For future agent` e o campo `confidence` e a fazer a skill só propor (não gravar) lacunas (decisão D15).

## 4. O RAG sem vetorização

RAG (geração aumentada por recuperação) tem três partes: **recuperar** trechos relevantes, **aumentar** o contexto do modelo com eles e **gerar** a resposta. Aqui, as três existem sem nenhum vetor:

| Parte | Como é feita, sem embeddings |
|---|---|
| **Recuperar** | (1) Cabeçalho de cada doc com `resumo`, `aliases` e `perguntas`, escritos uma vez por IA e revisados por uma pessoa; (2) glossário de sinônimos que liga o jeito de a equipe falar aos termos dos docs; (3) busca por palavras (grep, ou BM25 por **seção**) sobre esse texto; (4) mapas hierárquicos (`INDEX.md`, `_INDEX.md`) gerados a partir dos cabeçalhos, para quando a busca falha |
| **Aumentar** | O agente lê só a **seção** indicada, não o arquivo inteiro: cerca de 500 tokens em vez de ~1.000 ou mais por doc |
| **Gerar** | A skill manda responder citando **arquivo, seção e data**, separar interno de externo e dizer "não encontrei" em vez de inventar |

**O que substitui o vetor:** o que o vetor faz (aproximar "teto" de "limite máximo") é feito por vocabulário **explícito**, que uma pessoa pode ler, revisar e corrigir. A semântica passa para a curadoria (aliases e glossário) e para o próprio agente, que entende sinônimos ao escolher o doc em um mapa curto.

**Custo e limite:** não há servidor, API, banco nem índice para manter, e o custo por pergunta é pequeno. Em troca, a qualidade depende de **curadoria contínua** e há um limite de escala, estimado (não medido) em algumas centenas de docs com esta abordagem. Os sinais para reavaliar estão na seção 17 do relatório.

## 5. O que é medido e o que não é

- **Medido:** a comparação entre as 9 configurações na simulação; o comportamento dos 15 agentes reais; o efeito das variações (cabeçalho, glossário, seção).
- **Não medido ou frágil:** a IA da simulação foi modelada, e docs e perguntas vêm do mesmo vocabulário, então os 97,2% são **otimistas**. Os agentes foram uma execução por pergunta, em um modelo, com telemetria autodeclarada. O disparo real da skill no Claude Code foi emulado. Docs reais, arquivos grandes, docs ligados por links e milhares de docs não foram testados.
- **Próximo passo de maior valor:** 20 a 30 perguntas reais do time, com a resposta esperada, rodadas nos docs reais.
