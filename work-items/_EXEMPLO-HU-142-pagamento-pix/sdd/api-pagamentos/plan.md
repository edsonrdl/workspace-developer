# Plano técnico — HU-142 · api-pagamentos

> Playbooks aplicáveis: `microservice`, `rest-api` (envelope `{ data, meta }`, códigos HTTP, idempotência). Não repetir o que já está neles.

## Decisões
| # | Decisão | Por quê | Alternativa descartada |
|---|---|---|---|
| D1 | Expiração por **data de validade guardada** (`expira_em`), checada na confirmação | Sem job; a regra vale mesmo se o banco confirmar atrasado | Job que expira QR Codes: mais peças e estados |
| D2 | Confirmação do banco **idempotente** pela referência da cobrança | O banco pode avisar mais de uma vez (assumido: ignorar a repetida) | Processar toda notificação: risco de pagar duas vezes |
| D3 | Pedido só vai a `pago` pela confirmação, nunca por chamada do cliente | RN-4 | Confiar na tela de sucesso do cliente |
| D4 | Consulta por número do pedido reaproveita a rota de pagamentos existente | RN-7, menor superfície | Rota nova só para suporte |

## Ordem das operações
1. Criar cobrança → guardar `expira_em` e a referência → pedido `aguardando_pix`.
2. Receber confirmação → validar assinatura → checar `expira_em` → marcar `pago` → publicar `pagamento.confirmado`.

## Fora do plano (não fazer)
- Não alterar o fluxo de cartão. Não enviar e-mail daqui.
