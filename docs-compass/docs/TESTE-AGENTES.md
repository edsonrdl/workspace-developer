# Teste com agentes Claude reais: a IA consulta os docs ou foge para a internet/memória?

Segundo teste do projeto. O primeiro (ver [RELATORIO.md](RELATORIO.md)) foi uma simulação em código. Este usa **agentes Claude de verdade** (modelo Sonnet), com acesso liberado à internet, para responder à dúvida: *"como o agente sabe que deve procurar nos docs e não fora?"*

## O que foi testado

15 execuções, em 3 rodadas, cada uma com um agente novo, numa **cópia limpa** do repositório (só `corpus/`, `src/DocSearch.ps1` e a skill; sem relatório nem gabarito). Cada agente recebia uma pergunta, tinha WebSearch/WebFetch disponíveis e terminava com um bloco de telemetria listando as ferramentas usadas e a origem de cada informação. Eu conferi as respostas contra o gabarito (os valores reais dos docs).

| Rodada | Skill | Perguntas |
|---|---|---|
| 1 (5 agentes) | V0 (original) | `erro 429, com quem falar?` · `Quem cuida de estorno?` · `Qual o limite do circuit breaker?` · `Cliente foi cobrado duas vezes, o que eu faço?` · `Qual o prazo de SLA do cashback?` (**não existe nos docs**) |
| 2 (6 agentes) | V0, e 2 casos sem skill | `O que significa erro 429?` (conceito público) · `Como funciona o processo de chargeback aqui na empresa? Preciso saber o prazo.` · `Segundo a documentação interna, quem é o responsável por "break-glass"?` (aspas) · `Qual o limite do rate limiting do Stripe e qual o nosso?` (externo + interno) · `erro 429, com quem falar?` **sem skill e sem CLAUDE.md** · o mesmo **só com regras de CLAUDE.md** |
| 3 (4 agentes) | **V1 (ajustada)** | `o dinheiro da venda não caiu ainda, o que eu falo pro lojista?` · `preciso de acesso ao banco prod agora, tô com incidente` · `Qual é o nosso processo pra trocar chave de criptografia?` · `Qual o prazo de SLA do programa de pontos?` (**não existe**) |

## Resultados

| Pergunta | Resultado |
|---|---|
| Respostas que existem nos docs (12; a pergunta conceitual tem linha própria abaixo, e 12 + 2 + 1 = 15 execuções) | **12 de 12 corretas**, todas com arquivo e seção citados |
| Respostas que NÃO existem nos docs (2: cashback, programa de pontos) | **2 de 2**: disseram "não encontrei", sugeriram tópicos próximos e **não inventaram valor** |
| Uso da internet | **1 de 15**, e foi o caso certo: o limite da Stripe, rotulado como fonte externa e com aviso para conferir a fonte oficial. O limite interno veio dos docs |
| Pergunta conceitual ("o que significa 429") | Respondeu o conceito do conhecimento geral, **declarou isso** e ligou ao tópico Rate limiting dos docs |
| Sem skill e sem CLAUDE.md (dentro do repositório) | Foi direto ao grep nos docs e acertou |
| Só com regras de CLAUDE.md | Acertou e rotulou o que era conhecimento público |
| Estilo do prompt (simples, "na empresa", com aspas, só sintoma) | **Nenhuma diferença medida**: todos acertaram |

**Conclusão sobre a sua dúvida:** nos 15 testes nenhum agente respondeu um fato interno de memória ou da web. Não precisou bloquear a internet. O que conteve o comportamento foi: estar dentro do repositório, a descrição da skill, e a regra de citar arquivo e seção.

## Achados que mudaram a solução

1. **O script de busca (`DocSearch.ps1`) nunca rodou.** Em todas as 8 tentativas ele falhou: a política de execução do PowerShell desta máquina é `Restricted` (padrão do Windows). Os agentes **não** contornaram (corretamente) e seguiram pelo grep e pelos mapas, que funcionaram. Ou seja, o que sustentou os 15 acertos foi o **frontmatter enriquecido + glossário + mapas**, não o ranking BM25.
   - Ajuste feito: a skill V1 não depende do script; o caminho principal é o grep, e o script é opcional.
2. **`owner` confundiu.** Vários agentes notaram divergência entre `owner: squad-plataforma` (frontmatter) e "squad Nexus" (texto). Era ambiguidade nossa: o `owner` é quem mantém o doc, não quem opera o sistema.
   - Ajuste feito: a skill V1 e o [CURADORIA.md](../CURADORIA.md) definem isso.
3. **Agentes citaram texto de enchimento como fato** (ex.: "revisão por duas pessoas"). Isso é artefato do meu corpus inventado, mas vale como regra.
   - Ajuste feito: a skill V1 manda não citar contexto geral como fato sobre a pergunta.
4. **Rótulo interno/externo.** Quando o agente mistura fontes, o usuário precisa saber qual é qual.
   - Ajuste feito: a skill V1 exige "Interno (docs)" e "Externo" separados.
5. **Descrição da skill** reforçada com os gatilhos reais ("nosso/nossa", "aqui na empresa", processo, erro, cliente afetado, "mesmo que pareça genérica").

## Qual prompt usar

O teste não encontrou um "prompt mágico": perguntas simples funcionaram. As práticas que ajudam, sem custo:

- **Diga o que você precisa saber** (prazo, responsável, limite, procedimento). Isso escolhe o doc certo entre os 5 do mesmo tópico.
- **Use as suas palavras e o sintoma** ("o dinheiro da venda não caiu ainda"). A busca foi montada para isso.
- **Se quiser garantir**, comece com: `Consulte os docs do repositório: <pergunta>`. Não foi necessário nos testes.
- **Desconfie de resposta sem arquivo e seção citados.** Essa é a sua verificação.

## Regras para o CLAUDE.md da raiz (recomendado)

A skill V1 já cobre isso, mas um `CLAUDE.md` vale em toda sessão, mesmo se a skill não disparar. Texto sugerido (testado na Rodada 2, condição A6):

```
# Regras deste repositório
Este repositório é a documentação oficial da plataforma AcmePay. Perguntas sobre sistemas, processos, erros, limites, prazos, responsáveis ou procedimentos da empresa devem ser respondidas SOMENTE com base nos docs deste repositório. Procure em corpus/ (comece por corpus/INDEX.md, ou use src/DocSearch.ps1). Sempre cite arquivo e seção. Se não achar, diga que não achou; não responda de memória nem da internet sobre fatos internos. A internet só serve para conceitos públicos (ex.: o que um código HTTP significa) e deve ser sinalizada como fonte externa.
```

Este arquivo ainda **não foi criado** no repositório.

## Limitações deste teste (leia antes de apresentar)

- **A descoberta da skill foi emulada.** Os agentes receberam o nome e a descrição da skill no prompt, como o Claude Code faria, mas não testei o mecanismo real de disparo no Claude Code. Nas condições sem skill o resultado foi bom, mas isso é indício, não prova.
- **Corpus pequeno e inventado**: 120 docs, 24 tópicos. O sucesso do grep e dos mapas pode não se repetir com milhares de docs ou vocabulário mais bagunçado.
- **O script de busca por seção não foi exercitado** por nenhum agente, então o benefício dele com IA real continua só simulado.
- **Uma execução por pergunta**, um só modelo (Sonnet), sem repetição. Resultado de um agente não é estatística.
- **A telemetria é autodeclarada** pelo agente. Só pude verificar o script de busca de forma objetiva (o log estava vazio). Os agentes também sabiam que estavam num teste.
- **Perguntas escolhidas por mim**; não vieram de usuários reais.

## Decisão em aberto

O script de busca precisa rodar nas máquinas do time. Opções:

| Opção | Comentário |
|---|---|
| Manter só grep + mapas (V1) | Funcionou em 15 de 15 neste tamanho. Sem dependência. Pode não escalar |
| Reescrever a busca em Python ou Node | Resolve a política do PowerShell e é mais comum entre times. Não testei aqui, pois a máquina não tem esses runtimes |
| Liberar scripts no PowerShell (`RemoteSigned` ou `-ExecutionPolicy Bypass` por processo) | Decisão de segurança da empresa/TI, não minha. Os agentes se recusam a contornar |

Recomendação: seguir com o grep + mapas agora, e portar a busca para a linguagem que o time já usa quando o corpus passar de algumas centenas de docs.
