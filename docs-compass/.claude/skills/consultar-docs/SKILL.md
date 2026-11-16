---
name: consultar-docs
description: Fonte oficial para fatos INTERNOS da empresa AcmePay: sistemas, processos, erros e códigos, limites, prazos/SLA, responsáveis/squads/plantão, configurações, runbooks e sintomas de clientes (pagamentos, conciliação, antifraude, plataforma, observabilidade, segurança). Use SEMPRE que a pergunta for sobre "nosso/nossa", "aqui na empresa", um processo, um sistema, um erro ou um cliente afetado, mesmo que pareça genérica (ex.: "erro 429, com quem falar?"), e ANTES de responder de memória ou da internet.
---

# Consultar docs do docs-compass

Esta skill é um **roteador**. Não leia o glossário inteiro nem abra vários docs "para ver se é esse".

## Regra de fontes (leia primeiro)

- **Fatos internos** (valores, prazos, responsáveis, plantão, procedimentos, nomes de sistemas): **só dos docs deste repositório**. Nunca de memória.
- **Conceitos públicos ou de terceiros** (ex.: o que é o HTTP 429, o limite da API da Stripe): pode usar conhecimento geral ou a web, mas **rotule como "Fonte externa"** e mantenha separado do que é interno.
- Se a pergunta mistura os dois, responda em duas partes: **Interno (docs)** e **Externo**.
- **Não grave nada no repositório por conta própria.** Esta skill só lê.

## Passo 1 - achar o doc (sem depender de um programa específico)

Use a primeira opção que funcionar. Busque com **pelo menos dois termos diferentes** antes de concluir que não existe (termo técnico, sintoma, palavra de negócio, código de erro).

**A. Busca por seção (se o PowerShell permitir):**
```bash
powershell -NoProfile -File src/DocSearch.ps1 -Query "<pergunta nas palavras do usuário>" -Root corpus -Glossary corpus/glossario.txt -Top 3
```
Se falhar por política de execução de scripts, **não tente contornar**: vá para B.

**B. Grep em `corpus/`** pelas palavras da pergunta e por variações. O frontmatter (`aliases:`, `perguntas:`, `resumo:`) e o `corpus/glossario.txt` ligam o jeito de as pessoas falarem ao doc certo. Exemplo: `grep 429` encontra o glossário e os aliases do tópico Rate limiting. Se o grep devolver centenas de linhas, restrinja (`-l` para listar arquivos, ou termo mais específico) em vez de ler tudo.

**C. Mapas:** `corpus/INDEX.md` (o nome é em maiúsculas) → `corpus/<dominio>/_INDEX.md` → o doc.

## Passo 2 - ler só o necessário

- Abra o doc e leia o frontmatter e a seção **`## For future agent`** (2 a 3 frases: do que o doc trata e quando serve). Se ele não for o doc certo, volte ao Passo 1 em vez de ler o resto.
- Depois leia **só a seção que o `resumo` indica** (nos docs de exemplo, a seção `## Anexo`, no fim).
- Os demais parágrafos costumam ser contexto geral. **Não cite contexto geral como fato** sobre a pergunta.
- Um tópico tem docs vizinhos (limite, prazo, responsável, configuração, procedimento): abra o que responde ao que foi perguntado e ofereça os outros.

## Passo 3 - responder

- Cite **arquivo + seção + data `atualizado`**.
- Se `confidence` do doc for `medium` ou `speculation`, **avise** que o conteúdo não está confirmado.
- `owner` no frontmatter é quem **mantém o doc**, não necessariamente a equipe operacional. A equipe responsável é a que o texto do doc citar. Se os dois diferirem, diga qual você usou.
- Se dois docs divergem, priorize o de `atualizado` mais recente e avise.

## Passo 4 - não achou

- Diga que **não encontrou nos docs**. Não invente valores.
- Sugira o tópico mais próximo que existe no `INDEX.md`.
- **Proponha** ao usuário uma linha de lacuna (a pergunta e as palavras usadas) para `corpus/lacunas.md` e só grave se ele confirmar. O curador usa isso para adicionar um alias ao glossário ou escrever o doc que falta.
