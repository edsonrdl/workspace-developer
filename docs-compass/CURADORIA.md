# Especificação de curadoria do docs-compass

**Princípio:** um doc só existe para o time se for encontrável. Escrever o conteúdo é metade do trabalho; a outra metade é a **referência** do doc: cabeçalho (frontmatter), índice (MOC) e glossário. Todo doc novo ou alterado passa pelo checklist deste documento.

## 1. As 3 referências que mantêm um doc encontrável

| Referência | Onde fica | Quem atualiza | Para que serve |
|---|---|---|---|
| **Frontmatter** | topo do próprio `.md` | autor do doc (com ajuda do Claude) | A busca usa título, resumo, aliases e perguntas para achar o doc, mesmo que a resposta esteja no fim |
| **MOC (índices)** | `corpus/INDEX.md` e `<dominio>/_INDEX.md` | **gerado**, nunca editar à mão | A IA navega por eles quando a busca falha |
| **Glossário** | `corpus/glossario.txt` | curador | Ensina sinônimos ("teto" = "limite máximo") |

## 2. Frontmatter obrigatório

```yaml
---
id: rate-limit-limite
title: Rate limiting - limite máximo
dominio: plataforma
topico: rate-limit
resumo: Contém o limite máximo de Rate limiting (limite de requisições por cliente).
aliases: limite de requisições por cliente | erro 429 na API | teto
perguntas: Qual o limite máximo de Rate limiting? | teto de requisições por parceiro?
confidence: high
owner: squad-plataforma
atualizado: 2026-11-07
---
```

Regras (a busca lê linha a linha, então o formato importa):

- **Cada campo em uma única linha.** Sem listas YAML, sem quebra de linha. Itens de `aliases` e `perguntas` separados por ` | `.
- `id`: igual ao nome do arquivo, sem `.md`. Único no repositório e nunca reutilizado.
- `title`: formato `Tópico - Aspecto` (ex.: `Rate limiting - limite máximo`). O índice usa o texto antes de ` - ` como nome do tópico. **Proibido título genérico** ("Notas", "Guia nº37"): doc com título genérico foi o que mais falhou nos testes.
- `dominio`: nome da pasta onde o arquivo está.
- `topico`: identificador do assunto, igual em todos os docs do mesmo assunto.
- `resumo`: 1 frase dizendo **o que o doc responde**, incluindo a informação que está no **fim** do arquivo. É a parte mais importante. Resumo que só repete o título não serve.
- `aliases`: como as pessoas falam isso, sem usar o termo técnico: palavras de negócio, sintomas ("cliente cobrado duas vezes"), mensagens de erro, siglas antigas, nomes de sistemas legados.
- `perguntas`: 2 a 5 perguntas reais que o doc responde.
- `confidence`: o quanto o conteúdo é confiável. Valores: `stated` (declarado por quem é dono do assunto), `high` (conferido na fonte ou em produção), `medium` (provável, não conferido), `speculation` (hipótese). O agente avisa o usuário quando o doc for `medium` ou `speculation`.- `owner`: quem **mantém o doc** (revisa e atualiza). **Não é** necessariamente a equipe que opera o sistema. A equipe operacional, o canal e o plantão devem estar **escritos no texto do doc** (testes com agentes mostraram confusão quando só o `owner` existia).
- `atualizado`: data da última revisão de conteúdo.

## 3. Estrutura do corpo do doc

- **Primeira seção, logo após o título: `## For future agent`**, com 2 a 3 frases dizendo **do que o doc trata e quando ele serve** (e, se for o caso, para onde ir quando não serve). Exemplo: *"Este doc trata do limite máximo de Rate limiting. Use quando precisar do teto de requisições; para prazo, responsável ou procedimento, veja os docs vizinhos."* Ela é lida pelo agente ao abrir o doc e entra na busca como contexto do doc (não como trecho candidato a resposta). Não repita nela os valores: os fatos ficam nas seções próprias.
- Uma seção `##` por assunto. A busca indexa por seção, então cada seção deve ser compreensível sozinha.
- Valores que as pessoas procuram (limites, prazos, responsáveis, parâmetros, passos de procedimento) ficam em seção própria com título claro. Não esconder em parágrafo longo.
- Um doc trata de um aspecto de um tópico. Se crescer demais, dividir em dois docs com o mesmo `topico`.

### 3.1 Armadilhas de formato (checklist de erros comuns)

Erros comuns que fazem o arquivo perder os metadados sem nenhum aviso:

| Erro | Efeito | Como evitar |
|---|---|---|
| Linha em branco ou cerca de código (` ``` `) **antes** do primeiro `---` | O frontmatter não é reconhecido | O arquivo **começa** com `---` na linha 1 |
| Escapes de Markdown (`\---`, `\#`, `\*`) vindos de copiar e colar | Cabeçalho e títulos viram texto literal | Colar como texto puro e conferir a linha 1 |
| Lista YAML no frontmatter (`- item`, `* item`) | A busca lê cada campo em **uma linha**; `*` em YAML é alias e invalida a lista | Itens separados por ` \| ` na mesma linha |
| Chave repetida (dois `aliases:`) | A segunda ignora a primeira, sem aviso | Uma só ocorrência por campo |
| `id` diferente do nome do arquivo | O mapa e os links apontam para o lugar errado | `id` = nome do arquivo sem `.md` |
| Título genérico ("Notas", "Guia nº37") | O doc só é achado pelo corpo (foi o pior caso nos testes) | `Tópico - Aspecto` |
| Arquivo fora de UTF-8 | Acentos quebrados na busca e no índice | Salvar em UTF-8 |

## 4. Fluxos

### 4.1 Doc novo
1. Criar o arquivo na pasta do domínio, com título `Tópico - Aspecto`.
2. Preencher o frontmatter (use o prompt da seção 6).
3. Rodar `powershell -File src/Gen-Index.ps1`.
4. Testar: fazer 2 ou 3 perguntas ao doc com `DocSearch.ps1`, usando palavras que **não** estão no título. Se ele não aparecer no top 3, melhorar `resumo`/`aliases`.
5. Abrir PR com o doc **e** os `INDEX.md` gerados.

### 4.2 Doc alterado
1. Se o conteúdo mudou o que o doc responde, atualizar `resumo`, `aliases` e `perguntas`.
2. Atualizar `atualizado`.
3. Rodar `Gen-Index.ps1` (o resumo aparece no índice).

### 4.3 Doc renomeado ou movido
1. Manter o `id` (ele é a identidade do doc). Atualizar `dominio` se mudou de pasta.
2. Procurar no repositório por `[[id-antigo]]` e links para o caminho antigo e corrigir.
3. Rodar `Gen-Index.ps1`.

### 4.4 Doc obsoleto
1. Não deixar convivendo com o novo sem aviso. Se foi substituído, **apagar** o antigo, ou incluir no topo do corpo: `> OBSOLETO: substituído por [[id-novo]]`, e remover o `resumo` e os `aliases` dele para não competir na busca.
2. Mover os `aliases` úteis para o doc novo.
3. Rodar `Gen-Index.ps1`.

### 4.5 Lacuna reportada
Quando o agente não achou resposta, ele **propõe** ao usuário a linha de lacuna (a pergunta e as palavras usadas) e, **com a confirmação do usuário**, a registra em `corpus/lacunas.md`. Não grava sozinho em arquivo compartilhado. O curador, toda semana:
1. Doc existe, mas não foi achado: adicionar o termo que a pessoa usou em `aliases` do doc **ou** em `glossario.txt` (use o glossário se o termo vale para vários docs).
2. Doc não existe: criar (fluxo 4.1) ou repassar ao owner do domínio.
3. Apagar a linha de `lacunas.md` depois de resolvida.

## 5. Glossário (`glossario.txt`)

Formato, uma linha por conceito: `termo técnico = alias 1 | alias 2 | alias 3`

```
limite máximo = teto | quanto aguenta | valor máximo permitido
Rate limiting = limite de requisições por cliente | erro 429 na API
```

- À esquerda, o termo como aparece nos docs. À direita, como o time pergunta.
- Alias vale para todo o repositório. Se só vale para um doc, ponha no `aliases` do doc.
- Não repetir o mesmo alias em conceitos diferentes.

## 6. Prompt para o Claude preencher o frontmatter

```
Leia o documento inteiro, inclusive o final. Escreva só o bloco frontmatter:
- id: nome do arquivo sem .md
- title: "Tópico - Aspecto" (nunca genérico; se o atual for genérico, proponha um e avise)
- dominio: nome da pasta
- topico: identificador curto do assunto, em minúsculas e hífens
- resumo: UMA frase dizendo o que o doc responde, mencionando os valores/dados que estão no fim
- aliases: 5 a 8 jeitos de uma pessoa não técnica, ou de suporte, perguntar isso (negócio, sintomas, erros, nomes antigos), separados por " | "
- perguntas: 3 perguntas reais, separadas por " | "
- confidence: stated | high | medium | speculation (se não souber, use medium e avise)
- owner: ... ; atualizado: <data de hoje>
Depois do título do doc, proponha também a seção "## For future agent": 2 a 3 frases dizendo do que o doc trata e quando ele serve (sem repetir os valores).
O arquivo deve COMEÇAR com --- na linha 1 (sem linha em branco nem cerca de código antes). Cada campo em UMA linha. Não invente valores que não estejam no doc.
```

O humano revisa: o Claude pode errar o `resumo` ou inventar alias fora do vocabulário do time.

## 7. Checklist do PR

- [ ] Frontmatter completo (inclui `confidence`), começando na linha 1, cada campo em uma linha
- [ ] Seção `## For future agent` logo após o título (2 a 3 frases)
- [ ] Nenhuma das armadilhas da seção 3.1
- [ ] Título no formato `Tópico - Aspecto`
- [ ] `resumo` menciona a informação do fim do doc
- [ ] `aliases` com palavras de quem não conhece o termo técnico
- [ ] `Gen-Index.ps1` rodado e `INDEX.md`/`_INDEX.md` commitados
- [ ] Teste de busca feito com uma pergunta fora do título
- [ ] Se substituiu outro doc: o antigo foi apagado ou marcado como obsoleto

## 8. Papéis e ritmo

- **Autor do doc:** fluxos 4.1 a 4.4 e o checklist.
- **Curador** (hoje, o dono do conhecimento): glossário, `lacunas.md` semanal, revisão dos PRs de docs.
- **Owner do domínio:** responde pelo conteúdo e pela data `atualizado`. Doc sem revisão há mais de 6 meses entra na pauta de revisão.

## 9. O que ainda não está automatizado (próximos passos)

Hoje, o checklist depende de disciplina. Para não depender, falta:

1. Um **lint no CI** que falha o PR se faltar campo no frontmatter, se o `id` não bater com o arquivo, se o título for genérico ou se os `INDEX.md` estiverem desatualizados. Ainda não foi escrito.
2. Um aviso para docs com `atualizado` antigo.
3. Suporte a um campo `status: obsoleto` na busca (hoje a regra 4.4 é manual).
4. **`Gen-Index.ps1` é PowerShell** e é bloqueado onde a política de execução é `Restricted`. Onde isso ocorrer, não libere scripts por conta própria: peça à TI, ou gere os índices por outro meio (por exemplo, portar o script para Python/Node ou rodá-lo no CI).
