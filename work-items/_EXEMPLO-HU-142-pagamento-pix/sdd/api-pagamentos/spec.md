# SDD (standard) — HU-142 pagamento-pix · api-pagamentos

- **Origem:** história HU-142 · refinamento de negócio em `../../refinamento/refinamento.md`
- **Repo alvo:** ver [repo.md](repo.md)
- **Tier:** standard · **Estado:** planejado
- Leitura: `spec.md` (este) → `plan.md` → `tasks.md`

## Objetivo
Permitir criar uma cobrança PIX para um pedido, receber a confirmação do banco e marcar o pedido como pago.

## Regras de negócio relevantes (cópia do refinamento)
- **RN-1** O cliente pode escolher PIX e recebe um QR Code e um código copia-e-cola.
- **RN-2** O QR Code vale por 15 minutos (contados da geração; *respondida*).
- **RN-3** Se expirar sem pagamento, o pedido continua aberto e o cliente pode gerar um novo QR Code.
- **RN-4** O pedido só é marcado como pago depois da confirmação do banco.
- **RN-5** Valor mínimo de R$ 1,00. **Bloqueante:** o que fazer abaixo do mínimo não foi definido; esta RN fica **sem AC e sem task**.
- **RN-7** O suporte encontra o pagamento pelo número do pedido.

## Context pack (leia só isto, dentro do repo alvo)
| Arquivo | Por quê |
|---|---|
| `src/pedidos/pedido.ts` | modelo e estados do pedido |
| `src/pagamentos/` | onde entram cobrança e confirmação |
| `src/http/rotas.ts` | registro das rotas |
| `test/pagamentos/` | padrão dos testes existentes |

## Delta
- **ADDED:** criação de cobrança PIX (`POST /v1/pagamentos/pix`); endpoint de confirmação do banco; consulta por número do pedido; estado `aguardando_pix` no pedido.
- **MODIFIED:** `pedido.ts` (novo estado e transição para `pago`).
- **REMOVED:** nada.
- **NÃO muda:** fluxo de cartão; contratos já publicados; envio de e-mail (fica no `worker-notificacoes`).

## Aceite
- **AC-1** (RN-1) Dado um pedido aberto, quando o cliente escolhe PIX, então recebe QR Code e código copia-e-cola.
- **AC-2** (RN-2) Dado um QR Code gerado há mais de 15 minutos, quando o banco confirma o pagamento, então o pedido **não** é marcado como pago.
- **AC-3** (RN-3) Dado um QR Code expirado, quando o cliente pede outro, então um novo QR Code é gerado e o pedido segue aberto.
- **AC-4** (RN-4) Dado um pedido com PIX gerado, quando não há confirmação do banco, então o pedido não passa a pago.
- **AC-7** (RN-7) Dado um número de pedido, quando o suporte consulta, então vê o pagamento PIX e seu estado.

## Constitution check
- `testing`: unitário para as regras de expiração e de estado; integração para o endpoint de confirmação.
- `quality`: lint e cobertura mínima conforme a constitution (o repo precisa ter ambos).
- `security`: valor e identificadores de pagamento não vão para log; confirmação do banco com assinatura validada.
- `observability`: log estruturado com `requestId` e métrica de confirmações.

## Dúvidas técnicas
- Provedor/banco do PIX e formato exato da confirmação: **a definir**.
- Persistência: o repo ainda tem tabela de pagamentos? (verificar no context pack).
