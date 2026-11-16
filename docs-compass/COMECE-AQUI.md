# Comece aqui: onboarding do docs-compass

Este repositório reúne a documentação do sistema em arquivos `.md` e uma forma de **perguntar a ela com IA** em vez de perguntar a uma pessoa. Leva uns 10 minutos para começar.

## O que você vai poder fazer

- **Perguntar** em linguagem normal ("erro 429, com quem falar?") e receber a resposta com o arquivo e a seção de onde veio.
- **Navegar** pelos docs como num mapa (Obsidian, opcional).
- **Ajudar a melhorar:** registrar o que não achou e corrigir ou criar docs.

## 1. O que instalar

| Ferramenta | Obrigatório? | Para quê |
|---|---|---|
| Git | Sim | Baixar e atualizar o repositório |
| Claude Code (ou o agente de IA que o time usa) | Sim, para perguntar com IA | Fazer as perguntas |
| Windows PowerShell | Sim (já vem no Windows) | Roda a busca (`src/DocSearch.ps1`) |
| [Obsidian](https://obsidian.md) | Não | Só para ler e navegar com links e grafo |

## 2. Baixar o repositório

```bash
git clone <URL-DO-REPOSITORIO-docs-compass>
```

Entre na pasta do repositório. Para receber docs novos depois, no dia a dia:

```bash
git pull
```

## 3. Perguntar com IA (o uso principal)

1. Abra um terminal **na pasta raiz** do repositório.
2. Inicie o Claude Code (comando `claude`).
3. Confirme que a skill existe: a pasta `.claude/skills/consultar-docs/` deve estar no repositório. Se não estiver, copie `.claude/skills/consultar-docs/` para `.claude/skills/consultar-docs/`.
4. Pergunte normalmente. Exemplos:
   - `Qual o limite de requisições por parceiro?`
   - `Cliente foi cobrado duas vezes, com quem eu falo?`
   - `Como resolvo quando a fila de mensagens falha?`

**O que acontece por trás:** a skill roda a busca, lê os trechos, e responde citando o arquivo e a seção. Se a busca não achar, ela navega pelos mapas (`corpus/INDEX.md`). Se mesmo assim não achar, ela diz que não achou e registra a pergunta em `corpus/lacunas.md`. Ela **não deve inventar** valores.

**Dica:** pergunte do seu jeito, com as suas palavras. A busca foi feita para entender sinônimos ("teto" = "limite máximo"). Quando ela falhar, isso é informação útil para a curadoria (passo 6).

### Usando a IA que não é o Claude Code (ex.: Antigravity)

Não verifiquei se ele lê o formato de skill do Claude Code. Alternativa que funciona com qualquer agente que tenha terminal: peça ao agente para seguir as instruções do arquivo `.claude/skills/consultar-docs/SKILL.md`, ou copie o conteúdo dele para o arquivo de regras do projeto que a ferramenta usa (por exemplo `AGENTS.md`).

## 4. Buscar sem IA (só o terminal)

```bash
powershell -NoProfile -File src/DocSearch.ps1 -Query "erro 429, com quem falar?" -Glossary corpus/glossario.txt -Top 3
```

Devolve as 3 seções mais prováveis, com `arquivo`, `seção` e `trecho`. Abra o arquivo indicado para ver o contexto.

## 5. Navegar com o Obsidian (opcional)

1. Instale o Obsidian.
2. Menu "Abrir pasta como cofre" → escolha a pasta **`corpus/`** do repositório.
3. Abra `INDEX.md`: é o mapa. Clique no domínio e depois no doc.
4. `Ctrl+G` mostra o grafo.

O Obsidian e o Claude Code **não precisam estar conectados**: os dois leem a mesma pasta. Deixe o Obsidian aberto para ler e o terminal ao lado para perguntar.

Observações:
- O Obsidian cria uma pasta `.obsidian/` dentro do cofre. Ela já está no `.gitignore`; não a envie ao repositório.
- Existem plugins da comunidade que colocam o terminal do Claude Code dentro do Obsidian (por exemplo Claude Sidebar e Sidebar Terminal) e outros que rodam comandos (Shell commands). **São opcionais**, não são necessários para usar o docs-compass. Plugins executam código com as suas permissões: instale só de fonte confiável e, de preferência, depois de avisar o time de segurança.

## 6. Como ajudar (a curadoria)

Este conhecimento só funciona se for mantido. Você ajuda assim:

| Situação | O que fazer |
|---|---|
| A IA disse que não achou, mas você sabe que o doc existe | Anote em `corpus/lacunas.md`: a pergunta e as **palavras que você usou**. O curador vai adicionar o sinônimo ao glossário |
| A resposta estava errada ou desatualizada | Corrija o doc e abra um PR |
| Falta um doc | Crie seguindo [CURADORIA.md](CURADORIA.md) (seção 4.1) |

**Regra de ouro:** criar ou alterar um doc **não termina** no texto. Ele precisa da referência: o frontmatter preenchido e os índices regenerados (`powershell -File src/Gen-Index.ps1`). Sem isso, ninguém o encontra. O passo a passo e o checklist de PR estão em [CURADORIA.md](CURADORIA.md).

## 7. Se algo der errado

| Sintoma | O que tentar |
|---|---|
| O PowerShell diz que a execução de scripts está desabilitada (é o padrão do Windows) | Não precisa fazer nada: a skill, nesse caso, procura com grep nos docs e nos índices. Só use `-ExecutionPolicy Bypass` se a política da empresa permitir; caso contrário, peça ajuda à TI |
| A busca devolve trechos que não têm nada a ver | Reescreva a pergunta com outras palavras e registre em `lacunas.md` |
| Os acentos aparecem estranhos no terminal | Abra o arquivo diretamente no editor; o conteúdo está correto (UTF-8) |
| A skill não dispara no Claude Code | Confirme que você abriu o Claude Code na **raiz** do repositório e que `.claude/skills/consultar-docs/SKILL.md` existe |

## 8. Mapa rápido do repositório

```
corpus/                 ← os docs (por pasta de assunto) + INDEX.md + glossario.txt
src/DocSearch.ps1       ← a busca
src/Gen-Index.ps1       ← gera os índices
.claude/skills/consultar-docs/SKILL.md  ← instruções para a IA
CURADORIA.md            ← como manter os docs e suas referências
README.md               ← visão geral, ferramentas e dependências
docs/                   ← relatório, decisões, teste com agentes e diagrama (para quem quiser entender)
```

A pasta `lab/` é o laboratório usado para comparar as estratégias. Você não precisa dela.

## 9. Resumo de uma linha por papel

- **Quer só uma resposta:** terminal na raiz → `claude` → pergunte.
- **Quer ler com calma:** Obsidian → abrir `corpus/` como cofre → `INDEX.md`.
- **Quer melhorar:** `lacunas.md` para o que faltou; [CURADORIA.md](CURADORIA.md) para criar ou corrigir docs.
