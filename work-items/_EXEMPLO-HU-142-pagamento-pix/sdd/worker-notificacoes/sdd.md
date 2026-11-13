# SDD — HU-142 pagamento-pix · worker-notificacoes

- **Origem:** história HU-142 · refinamento de negócio em `../../refinamento/refinamento.md`
- **Repo alvo:** ver [repo.md](repo.md)
- **Tier:** lite · **Estado:** planejado
- **Depende de:** o evento `pagamento.confirmado` publicado pela `api-pagamentos` (SDD ao lado).

## Objetivo (1–2 linhas)
Enviar o e-mail de confirmação quando um pagamento PIX for confirmado.

## Regras de negócio relevantes (cópia do refinamento)
- **RN-6** Depois de pago, o cliente recebe um e-mail de confirmação.
- *Assumida:* a confirmação duplicada do banco não gera segundo e-mail.

## Context pack (leia só isto)
| Arquivo | Por quê |
|---|---|
| `src/consumidores/` | onde entram os consumidores de evento |
| `src/email/` | envio de e-mail e templates |

## Delta
- **ADDED:** consumidor de `pagamento.confirmado` e template do e-mail.
- **MODIFIED:** registro de consumidores.
- **REMOVED:** nada.
- **NÃO muda:** os e-mails já existentes.

## Aceite
- **AC-6** (RN-6) Dado um evento `pagamento.confirmado`, quando o worker o processa, então envia um e-mail ao cliente do pedido.
- **AC-6b** (assumida) Dado o mesmo evento recebido duas vezes, quando o worker o processa, então envia **um** e-mail.

## Constitution check
- `testing`: unitário do consumidor e da idempotência. `quality`: lint e cobertura. `observability`: log por evento processado.

## Tasks
- [ ] T1 — Consumidor de `pagamento.confirmado` com template do e-mail. (AC-6)
- [ ] T2 — Idempotência por identificador do evento. (AC-6b)

## Dúvidas técnicas
- [NEEDS CLARIFICATION] Formato exato do evento (campos): depende da `api-pagamentos` (T5).
