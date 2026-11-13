# Quality — Qualidade de código

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.
> Um projeto pode definir thresholds mais altos no seu `sdd/requirements.md` — nunca mais baixos.

---

## Linting

- ESLint obrigatório com configuração do repositório de padrões da empresa
- `npm run lint` sem erros é pré-requisito para merge
- Sem `any` explícito em TypeScript sem comentário de justificativa no código
- Sem `console.log` em produção — usar logger estruturado (ver [[observability]])

---

## Cobertura de testes

- Cobertura mínima global: **80%**
- Medida por: branches + functions + lines + statements
- Projetos podem definir threshold mais alto no `sdd/requirements.md` — nunca abaixo de 80%
- Estratégia de testes detalhada em [[testing]]

---

## Padrões de código

- Toda função com mais de 20 linhas deve ter comentário de propósito
- Nomes em inglês para código — português apenas em comentários e documentação
- Sem código comentado em produção — usar controle de versão para histórico
- Dead code removido antes do merge — não deixar para "depois"

---

## Code review

- Todo merge requer ao menos uma aprovação
- Aprovação automática de bot não substitui revisão humana em mudanças de lógica
- Mudanças em `sdd/` e `docs/adr/` revisadas com o mesmo rigor que o código
