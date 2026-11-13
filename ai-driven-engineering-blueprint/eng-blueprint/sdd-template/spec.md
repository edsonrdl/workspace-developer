# spec.md — [Nome do Projeto ou Feature]

> **Instrução ao agente:** leia este arquivo completamente e siga a ordem de leitura obrigatória antes de qualquer ação.
> **Instrução ao autor:** este é o ponto de entrada. Responda às perguntas abaixo de forma direta. Se uma seção não se aplica, escreva "N/A" — nunca deixe em branco.

---

## Problema que resolve

<!--
Descreva o problema de negócio ou técnico que motivou esta especificação.
Responda: qual dor existe hoje? O que acontece se não resolvermos isso?
Seja concreto — evite abstrações como "melhorar a experiência".

Exemplo ruim:  "Melhorar o processo de pagamento."
Exemplo bom:   "O processamento de pagamento está acoplado ao serviço de pedidos.
                Qualquer falha no gateway derruba o fluxo inteiro e não há
                rastreabilidade de tentativas falhas."
-->

[Descreva o problema aqui]

---

## Visão geral

<!--
Uma frase sobre o que será construído e para quê.
Não descreva como — isso vai para plan.md.
-->

[Descreva a solução em 1-3 frases]

**Nome do projeto/serviço:** `[nome-kebab-case]`

---

## Consumidores / Stakeholders

<!--
Quem usa ou depende do que será construído?
Para serviços: outros serviços, frontends, times.
Para bibliotecas: aplicações consumidoras.
Para CLIs: desenvolvedores, pipelines CI/CD.
-->

| Consumidor | Como consome | O que consome |
|---|---|---|
| `[nome]` | HTTP / Evento / CLI / Import | [o quê] |

---

## Escopo

<!--
Liste explicitamente o que está DENTRO e o que está FORA.
Non-Goals são tão importantes quanto Goals — eles evitam scope creep e
impedem que o agente over-engineer a solução.
-->

**Dentro do escopo:**
- [funcionalidade 1]
- [funcionalidade 2]

**Fora do escopo (Non-Goals):**
- [o que não será feito aqui — e por quê, se necessário]
- [funcionalidade que parece relacionada mas vai para outro projeto/sprint]

---

## Contexto e decisões anteriores

<!--
O que já existe? Quais decisões já foram tomadas antes desta spec?
Isso evita que o agente "descubra" o contexto por inferência.

Exemplos:
- "O banco de dados PostgreSQL já está provisionado via Terraform."
- "O frontend já tokeniza o cartão via SDK do gateway — este serviço recebe apenas o token."
- "A fila SQS já existe — este serviço apenas publica."
-->

- [contexto relevante 1]
- [contexto relevante 2]

---

## Ordem de leitura obrigatória

<!--
Liste os arquivos que o agente DEVE ler antes de qualquer ação.
A ordem importa — não altere sem entender as dependências.
Use [[links]] do Obsidian para que o agente possa seguir a cadeia.

Adapte a lista conforme os patterns do seu vault:
- Se for microserviço: inclua [[microservice]] e [[rest-api]]
- Se for monólito modular: inclua [[modular-monolith]]
- Se for frontend: inclua [[frontend]] (se existir)
- Se não houver pattern aplicável: remova a linha
-->

O agente deve ler nesta sequência antes de qualquer ação:

1. [[constitution]]          — regras universais inegociáveis
2. [[microservice]]          — estrutura, comunicação, resiliência *(remova se não aplicável)*
3. [[rest-api]]              — contratos HTTP, envelope, autenticação *(remova se não aplicável)*
4. [[requirements]]          — o que precisa ser construído
5. [[contracts]]             — o que vai ser produzido
6. [[acceptance]]            — como validar
7. [[plan]]                  — como construir
8. [[tasks]]                 — implementar nesta ordem
