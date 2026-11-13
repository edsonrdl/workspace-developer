# Testing — Estratégia de testes

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.
> O *como implementar* (frameworks, configuração por arquitetura) fica nos `playbooks/`.
> O *o que é obrigatório em todo projeto* está aqui.

---

## Pirâmide de testes

```
        /\
       /e2e\          ← poucos, lentos, caros — validam fluxos críticos ponta a ponta
      /------\
     /integração\     ← médios — validam a colaboração entre camadas reais
    /------------\
   /   unitários  \   ← muitos, rápidos, baratos — validam lógica isolada
  /________________\
```

**Regra universal:** a base da pirâmide é sempre maior. Projetos com mais testes e2e do que unitários têm estratégia invertida — isso é dívida técnica.

---

## O que cada camada testa

**Unitários** — lógica de negócio pura, isolada de infraestrutura:
- Use cases e domain logic com dependências mockadas
- Cobrem todos os caminhos: fluxo feliz + cada caso de borda
- Devem rodar em milissegundos — sem I/O, sem rede, sem banco

**Integração** — colaboração entre camadas com implementações reais ou próximas do real:
- Controller + use case + repository com banco em memória ou container
- Integrações externas com mock do servidor (não mock da lib)
- Validam que o contrato de [[contracts]] é respeitado de ponta a ponta

**E2E** — fluxos críticos de negócio com ambiente próximo de produção:
- Apenas os caminhos que, se quebrados, param o negócio
- Rodam em CI antes do deploy, não a cada commit
- Usam ambiente de staging ou mocks de infraestrutura

---

## Cobertura mínima

- Global: **80%** (ver [[quality]])
- Cobertura é medida em: branches + functions + lines + statements
- 100% de cobertura não é o objetivo — cobertura de comportamentos críticos sim
- Um projeto pode elevar o threshold no `sdd/requirements.md` — nunca abaixar

---

## Estratégia de mock

**Mockar:** dependências de infraestrutura nos testes unitários (banco, fila, gateway, logger)

**Não mockar:** a lógica de negócio que está sendo testada — testar o comportamento real

**Regra de ouro:** se o mock ficou mais complexo que o que ele substitui, o design precisa ser revisto — não o teste.

---

## O que vai no `sdd/` do projeto

| Arquivo | O que especifica |
|---|---|
| `sdd/requirements.md` | NFR de cobertura específica, SLOs que os testes devem validar |
| `sdd/acceptance.md` | Critérios de aceite em formato Given/When/Then — viram testes |
| `sdd/plan.md` | Framework de teste escolhido, estratégia de mock específica do projeto |
| `sdd/tasks.md` | Task específica de testes se a cobertura for complexa |
