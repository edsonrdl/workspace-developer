# Resultado da competição (gerado por lab/Simulate.ps1, seed 7)

Corpus: 120 docs, ~111666 tokens no total. Consultas: 720 (6 personas x 120 docs). Sucesso = doc certo entre os 3 candidatos que o agente chega a abrir/ver.

## Placar geral

| Estratégia | Acerto no 1º (%) | Sucesso top-3 (%) | Tokens médios/pergunta | Tokens P90 |
|---|---:|---:|---:|---:|
| S7 HIBRIDO + fallback MOC (S6 -> S5) | 71.9 | 97.2 | 742 | 1653 |
| S5 MOC 3 niveis (dominio>topico>docs) | 95.1 | 95.1 | 1399 | 1490 |
| S3 MOC 2 niveis (dominio > docs) | 91.8 | 91.8 | 1894 | 1985 |
| S6 HIBRIDO secoes+frontmatter+glossario | 71.9 | 84.3 | 546 | 1361 |
| S4g BM25 por arquivo + glossario (sem secoes) | 70.3 | 82.9 | 1709 | 3043 |
| S6a hibrido SEM glossario | 65.6 | 76.2 | 874 | 1573 |
| S4 BM25 por arquivo + frontmatter | 61.9 | 75 | 1850 | 3076 |
| S6b hibrido SEM frontmatter (docs legados) | 60 | 67.8 | 456 | 603 |
| S1 Skill + glossario plano de titulos | 45.7 | 56.5 | 3715 | 4763 |
| S2 Agente com grep literal | 43.1 | 55.7 | 3092 | 4119 |
| (ref) Colocar TODOS os docs no contexto | - | n/d | 111666 | 111666 |

## Sucesso top-3 por persona (%)

| Estratégia | senior | junior | suporte | po | impaciente | estagiario |
|---|---:|---:|---:|---:|---:|---:|
| S7 HIBRIDO + fallback MOC (S6 -> S5) | 100 | 97 | 96 | 97 | 100 | 94 |
| S5 MOC 3 niveis (dominio>topico>docs) | 93 | 98 | 94 | 95 | 96 | 95 |
| S3 MOC 2 niveis (dominio > docs) | 92 | 94 | 93 | 88 | 92 | 91 |
| S6 HIBRIDO secoes+frontmatter+glossario | 100 | 82 | 76 | 86 | 100 | 62 |
| S4g BM25 por arquivo + glossario (sem secoes) | 100 | 81 | 74 | 83 | 100 | 59 |
| S6a hibrido SEM glossario | 100 | 69 | 68 | 79 | 95 | 47 |
| S4 BM25 por arquivo + frontmatter | 100 | 68 | 63 | 77 | 98 | 44 |
| S6b hibrido SEM frontmatter (docs legados) | 91 | 61 | 52 | 64 | 91 | 48 |
| S1 Skill + glossario plano de titulos | 58 | 56 | 58 | 52 | 56 | 59 |
| S2 Agente com grep literal | 100 | 49 | 43 | 28 | 65 | 48 |

## Sucesso top-3 por tipo de título do doc (%)

| Estratégia | descritivo | topico (sem o aspecto) | genérico |
|---|---:|---:|---:|
| S7 HIBRIDO + fallback MOC (S6 -> S5) | 96 | 99 | 98 |
| S5 MOC 3 niveis (dominio>topico>docs) | 96 | 94 | 94 |
| S3 MOC 2 niveis (dominio > docs) | 91 | 91 | 93 |
| S6 HIBRIDO secoes+frontmatter+glossario | 84 | 84 | 86 |
| S4g BM25 por arquivo + glossario (sem secoes) | 83 | 82 | 85 |
| S6a hibrido SEM glossario | 76 | 74 | 79 |
| S4 BM25 por arquivo + frontmatter | 75 | 73 | 78 |
| S6b hibrido SEM frontmatter (docs legados) | 75 | 72 | 45 |
| S1 Skill + glossario plano de titulos | 76 | 63 | 0 |
| S2 Agente com grep literal | 58 | 56 | 48 |

## Ciclo de feedback do glossário (consultas NOVAS, rodada B)

Cada consulta que falhou na rodada A virou alias no glossário (113 falhas, 33 aliases adicionados; os aliases que o time escreveria em 1 sprint de uso).

| Versão | Acerto no 1º (%) | Sucesso top-3 (%) | Tokens médios |
|---|---:|---:|---:|
| S5 MOC 3 niveis (ref) | 95.1 | 95.1 | 1398 |
| S6 glossario apos 1 ciclo de feedback | 76.8 | 93.3 | 465 |
| S6 glossario inicial | 68.9 | 84.4 | 543 |
| S7 hibrido + fallback MOC, apos feedback | 76.8 | 98.9 | 549 |
