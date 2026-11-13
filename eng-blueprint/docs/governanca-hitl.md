# Governança de IA — HITL, HOTL, HIC e Phase Gates

> Material de contexto — leia sob demanda.

> 📊 **Visualização:** abra `vibe-code-vs-sdd-governance.canvas` no Obsidian para ver o diagrama completo desta seção — Vibe Code vs Engenharia com Governança, com os Phase Gates e o fluxo de implementação.

São três modelos de **quanto controle humano** existe sobre decisões de um sistema de IA. A escolha do modelo depende do nível de risco da operação — não da preferência pessoal.

---

### HITL — Human In The Loop
**Humano dentro do ciclo, aprovando cada ação.**

O humano revisa e aprova *cada decisão* antes de executar. A IA não age sozinha.

> *Exemplo neste sistema:* IA gera a TASK-001 → desenvolvedor revisa os arquivos criados → aprova e autoriza avançar para TASK-002.

Usado quando o **risco é alto** ou o custo de reverter um erro é grande: migrações de banco de dados, alterações em contratos de API públicos, decisões arquiteturais com impacto em outros times.

```
# Como usar no eng-blueprint:
"Leia sdd/spec.md, implemente apenas TASK-001 e aguarde minha revisão antes de avançar."
```

---

### HOTL — Human On The Loop
**Humano monitorando, podendo intervir.**

A IA age automaticamente, mas um humano observa em tempo real e pode *interromper* se algo sair errado.

> *Exemplo neste sistema:* agente implementa todas as tasks sequencialmente → engenheiro acompanha o output task por task → pode interromper se detectar desvio da spec.

Usado quando **velocidade importa**, mas supervisão ainda é necessária: features novas em sistemas não críticos, refatorações com boa cobertura de testes.

```
# Como usar no eng-blueprint:
"Leia sdd/spec.md e implemente todas as tasks. Vou revisar o resultado."
```

---

### HIC — Human In Command
**Humano no controle estratégico, não operacional.**

A IA opera de forma autônoma no dia a dia. O humano define regras, limites e objetivos — mas não acompanha cada ação.

> *Exemplo neste sistema:* `constitution.md` e `playbooks/` são as regras pré-definidas. CI/CD roda o agente automaticamente quando uma nova spec é adicionada. O agente segue as regras sem aprovação por ação.

Usado quando o sistema já é **maduro e confiável**: automações internas, geração de boilerplate, atualizações de dependências dentro das políticas da constitution.

```
# Como usar no eng-blueprint:
Pipeline que executa "leia sdd/spec.md" automaticamente ao detectar tasks.md com [ ].
```

---

### Phase Gates por nível de risco

| Risco | Modelo | Quando usar | O que acontece |
|---|---|---|---|
| 🔴 Alto | HITL | Schema migration, contrato de API público, decisão arquitetural | Aprovação manual obrigatória antes de avançar de fase |
| 🟡 Médio | HOTL | Nova feature, novo endpoint, nova integração | Avanço automático, humano pode vetar em tempo real |
| 🟢 Baixo | HIC | Boilerplate, ajuste de validação, atualização interna | Avanço totalmente automatizado dentro das regras |

---

### Spec-anchored — o que mantém tudo junto

**Spec-anchored** significa que toda decisão da IA é *ancorada* em uma especificação formal antes de executar. Não é uma sugestão — é a condição para o agente agir.

No eng-blueprint isso se manifesta em dois níveis:

**Nível 1 — Constitution como âncora universal:**
A `constitution.md` define restrições que *nenhum agente pode violar*, independente do modelo de supervisão escolhido. Mesmo com HIC (total autonomia), o agente não pode armazenar dados de cartão, usar `console.log` em produção ou adicionar dependências não auditadas.

**Nível 2 — SDD como âncora do projeto:**
A pasta `sdd/` define o contrato específico de cada projeto. O agente lê a cadeia completa (`spec → requirements → contracts → acceptance → plan → tasks`) antes de escrever qualquer linha de código. O que não está na spec, não é implementado.

Isso garante:
- **Trilha de auditoria nativa** — cada arquivo gerado é rastreável contra a spec que o originou
- **Restrições constitucionais aplicadas mesmo em HIC** — autonomia máxima, mas dentro dos limites definidos
- **Sem alucinação arquitetural** — o agente não decide sozinho como estruturar o serviço, qual banco usar, como fazer retry — tudo está na spec


## Benefícios para cada papel

### Para gestores e arquitetos

- **Rastreabilidade completa:** cada decisão técnica está documentada em `sdd/plan.md` com o *porquê*, não apenas o *como*
- **Auditoria nativa:** o histórico Git da `sdd/` é o histórico das decisões de negócio — cada PR carrega a spec que originou a mudança
- **Governança sem burocracia:** as regras estão no código, não em documentos Word esquecidos em drives
- **Controle proporcional ao risco:** HITL para decisões críticas, HOTL para features, HIC para automações maduras
- **Onboarding acelerado:** novo membro lê `constitution.md` + `sdd/spec.md` do projeto e tem contexto completo em minutos
- **Redução de custo com IA:** spec bem escrita reduz drasticamente o número de tokens consumidos por feature — veja a seção "Economia de tokens"

### Para desenvolvedores e tech leads

- **O agente nunca chuta:** ele lê a spec completa antes de escrever uma linha de código
- **Sem "qual versão está vigente?":** a `sdd/` vive no mesmo repositório que o código, com o mesmo controle de versão
- **Code review com contexto completo:** o PR inclui `sdd/` + código — o revisor vê o que foi decidido, o que foi construído e como valida, tudo no mesmo diff
- **Retomada automática:** `sdd/tasks.md` com estado `[x]`/`[ ]` permite parar e continuar sessões sem perder contexto
- **Sem reinvenção de padrões:** `playbooks/` são a resposta para "como devemos fazer isso aqui?"
- **Documentação que não fica no limbo:** spec e código evoluem juntos no mesmo commit
