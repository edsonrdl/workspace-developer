# Documentation — Documentação obrigatória

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.

---

## Por repositório

Todo repositório deve conter na raiz:

| Arquivo/Pasta | Conteúdo obrigatório |
|---|---|
| `README.md` | Propósito do projeto, como rodar localmente, variáveis de ambiente necessárias |
| `CHANGELOG.md` | Atualizado a cada release no formato Keep a Changelog |
| `docs/adr/` | Decisões arquiteturais em formato ADR |
| `sdd/` | Especificações do projeto — ver [[governance]] para quando é obrigatório |

---

## README mínimo

Todo `README.md` deve responder:

1. **O que é** — propósito em 1-2 frases
2. **Como rodar localmente** — comandos exatos, sem pressupor conhecimento
3. **Variáveis de ambiente** — lista com nome, descrição e exemplo (sem valores reais)
4. **Como rodar os testes** — comando exato
5. **Como fazer deploy** — ou link para o pipeline

---

## CHANGELOG

Formato [Keep a Changelog](https://keepachangelog.com):

```markdown
## [1.2.0] - 2026-06-01
### Added
- Nova funcionalidade X

### Fixed
- Correção do bug Y

### Changed
- Comportamento Z alterado
```

---

## ADR — Architecture Decision Record

Toda decisão arquitetural relevante registrada em `docs/adr/NNN-titulo.md`:

```markdown
# NNN — Título da decisão

## Status
Aceito | Proposto | Depreciado | Substituído por [[NNN-novo]]

## Contexto
[Por que esta decisão precisou ser tomada?]

## Decisão
[O que foi decidido?]

## Consequências
[Trade-offs, limitações, o que muda com esta decisão]

## Alternativas consideradas
[O que foi avaliado e descartado — com justificativa]
```

Processo de aprovação de ADRs em [[governance]].
