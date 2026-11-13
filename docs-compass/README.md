# docs-compass

Uma bússola para achar a resposta certa na documentação de uma equipe, usando um agente de IA. Sem embeddings, sem servidor, sem API e sem banco de dados: só arquivos Markdown bem referenciados, um glossário, mapas de navegação e uma skill que diz ao agente como procurar.

> Os docs em `corpus/` são **exemplos inventados** (uma plataforma de pagamentos fictícia, a "AcmePay"). Substitua-os pelos docs reais da sua equipe.

## O que ele faz

- **Responde dúvidas a partir dos docs.** O agente procura no repositório, lê só a seção necessária e responde citando **arquivo, seção e data**. Quando não acha, diz que não achou em vez de inventar.
- **Resolve "a resposta está no fim do arquivo".** Cada doc tem um cabeçalho (resumo, apelidos, perguntas) que descreve o conteúdo inteiro, então a busca encontra o doc mesmo que o título não diga o assunto.
- **Entende o jeito de a equipe falar.** Um glossário liga palavras de negócio e sintomas ("cliente cobrado duas vezes") aos termos técnicos dos docs.
- **Navega por mapas quando a busca falha.** Índices por domínio e tópico, gerados a partir dos cabeçalhos.
- **Separa o que é interno do que é público.** Fato da empresa vem só dos docs; conceito público ou de terceiros pode vir de conhecimento geral ou da web, rotulado como "Externo". A internet não é bloqueada.
- **Dá um processo de curadoria.** Regras para criar, alterar, renomear e aposentar docs sem perder a referência de cada um, e um ciclo para transformar perguntas sem resposta em melhorias.

## Como funciona

1. Um doc novo ou alterado recebe o cabeçalho (o Claude propõe, uma pessoa revisa), os mapas são atualizados e tudo entra por pull request.
2. Alguém pergunta ao agente (Claude Code) dentro do repositório.
3. A skill [`consultar-docs`](.claude/skills/consultar-docs/SKILL.md) dispara, busca por palavras no cabeçalho e no glossário, abre o doc certo e lê só a seção indicada. Se não achar, navega pelos mapas (`corpus/INDEX.md`).
4. O agente responde citando a fonte, ou diz que não encontrou e propõe registrar a lacuna para o curador.

Diagrama completo (curadoria, repositório, Obsidian e agente): [docs/diagramas/fluxo-docs-compass.drawio](docs/diagramas/fluxo-docs-compass.drawio). Abra no [app.diagrams.net](https://app.diagrams.net). Há uma versão em texto em [docs/DECISOES.md](docs/DECISOES.md).

## Estrutura

```
.claude/skills/consultar-docs/   a skill que o Claude Code carrega
corpus/                          os docs (exemplos), INDEX.md, glossario.txt
  <dominio>/*.md                 um doc por aspecto de um tópico, com frontmatter
  <dominio>/_INDEX.md            mapas gerados (não editar à mão)
src/
  DocSearch.ps1                  busca por seção (opcional, PowerShell)
  Gen-Index.ps1                  gera os INDEX.md a partir dos cabeçalhos
docs/                            relatório, registro de decisões, teste com agentes, diagrama
lab/                             laboratório: gerador de docs de teste e simulação (opcional)
CURADORIA.md                     regras para manter os docs e suas referências
COMECE-AQUI.md                   passo a passo para quem acabou de baixar o repositório
```

## Ferramentas e dependências

| Ferramenta | Necessária? | Para quê | Observações |
|---|---|---|---|
| **Git** | Sim | Baixar, versionar e atualizar (`git pull`) | |
| **Claude Code** | Sim, para perguntar com IA | Carrega a skill e responde | Outro agente serve se tiver busca e leitura de arquivos; **não verificado** (por exemplo, o formato de skill pode não ser lido) |
| **Windows PowerShell 5.1** | Não | Roda `src/DocSearch.ps1`, `src/Gen-Index.ps1` e o `lab/` | Já vem no Windows, sem módulos extras. A política de execução `Restricted` (padrão do Windows) bloqueia os scripts. A skill **funciona sem eles**, só com grep e leitura de arquivos |
| **Obsidian** | Não | Ler e navegar pelos docs (abrir `corpus/` como cofre, mapas, grafo) | Não é conectado ao agente: os dois leem a mesma pasta. Plugins da comunidade (Claude Sidebar, Shell commands) são opcionais, **não foram testados** e executam código com as suas permissões |
| **draw.io** | Não | Ver o diagrama de fluxo | app.diagrams.net ou a extensão do VS Code |

**Não precisa de:** Python, Node, servidores MCP, chave de API, banco de dados, embeddings nem serviço rodando.

## Como usar

```bash
git clone <url-deste-repositorio>
cd docs-compass
claude            # abra o Claude Code na raiz do repositório
```

Pergunte com as suas palavras, por exemplo: `erro 429, com quem falar?` ou `o dinheiro da venda não caiu ainda, o que eu falo pro lojista?`. Resposta sem arquivo e seção citados deve ser tratada como suspeita.

Busca sem IA (opcional, onde o PowerShell permitir scripts):

```bash
powershell -NoProfile -File src/DocSearch.ps1 -Query "teto de requisições por parceiro" -Glossary corpus/glossario.txt -Top 3
```

Mais detalhes para quem está começando: [COMECE-AQUI.md](COMECE-AQUI.md).

## Para usar com os seus docs

1. Coloque os `.md` em `corpus/<assunto>/`.
2. Peça ao Claude para preencher o cabeçalho de cada doc (prompt pronto em [CURADORIA.md](CURADORIA.md)) e revise.
3. Atualize os mapas (`src/Gen-Index.ps1`, ou peça ao Claude para atualizar os `INDEX.md` seguindo o formato dos existentes, se o PowerShell estiver bloqueado).
4. Ajuste o nome e a descrição da skill ao seu contexto.
5. Teste com perguntas reais do time e preencha o `corpus/glossario.txt` com o que falhar.

## Estado de validação

- **Simulação** (120 docs inventados, 720 perguntas): a estratégia adotada (busca por seção com cabeçalho e glossário, mapas como reserva) acertou o doc em 97,2% dos casos. O número é **otimista**: o vocabulário das perguntas e o dos docs vêm da mesma origem, e a IA que lê listas foi simulada.
- **Agentes Claude reais** (15 execuções, mesmos docs inventados): 12 de 12 perguntas com resposta corretas, 2 de 2 sem resposta tratadas com "não encontrei", e a web usada 1 vez, no caso certo. É amostra pequena (uma execução por pergunta, um modelo).
- **Não validado:** docs reais, arquivos grandes, docs ligados por links, milhares de docs, e o disparo real da skill no Claude Code (foi emulado).

Detalhes, números e limitações em [docs/RELATORIO.md](docs/RELATORIO.md) e [docs/TESTE-AGENTES.md](docs/TESTE-AGENTES.md). O porquê de cada escolha está em [docs/DECISOES.md](docs/DECISOES.md), e o caminho percorrido (personas, testes em paralelo e o RAG sem vetores) em [docs/PROCESSO.md](docs/PROCESSO.md).

## Limitações conhecidas

- Não há lint de CI: o cabeçalho e os mapas dependem da disciplina descrita em [CURADORIA.md](CURADORIA.md).
- As ferramentas estão em PowerShell, que pode estar bloqueado e não roda em Mac/Linux. Portar para Python ou Node está em aberto.
- Sem embeddings, a escala tem um limite: a análise em [docs/RELATORIO.md](docs/RELATORIO.md) (seção 17) estima até algumas centenas de docs com esta abordagem e lista os sinais de que é hora de mudar. São estimativas, não medições.
- A web não é bloqueada: a contenção depende do comportamento do modelo e da regra de citar a fonte.

## Reproduzir os testes (laboratório)

```bash
powershell -NoProfile -File lab/Gen-Corpus.ps1   # gera os 120 docs de exemplo
powershell -NoProfile -File src/Gen-Index.ps1    # gera os mapas
powershell -NoProfile -File lab/Simulate.ps1     # roda a simulação (cerca de 4 minutos)
```

O resultado vai para `lab/sim/resultado.md`. Atenção: a simulação reescreve `corpus/glossario.txt`.

## Licença

Ainda não definida. Escolha uma antes de abrir o repositório publicamente.
