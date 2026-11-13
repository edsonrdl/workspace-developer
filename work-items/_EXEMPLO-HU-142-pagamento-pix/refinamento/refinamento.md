# HU-142 — Pagamento via PIX no checkout

- **Original recebido:** `original.md` (nesta pasta) · recebido em 2026-11-13
- **Status:** refinada
- **Solicitante/stakeholders:** não informado

> Refinamento de **negócio**. Sem código, sem nome de classe ou tabela.

## Problema
Hoje só há pagamento com cartão. Clientes sem cartão ou que preferem PIX (principalmente no celular) abandonam a compra.

## Valor esperado
Recuperar vendas perdidas por falta de PIX. Métrica: não informado.

## Regras de negócio
- **RN-1** O cliente pode escolher PIX na tela de pagamento e recebe um QR Code e um código copia-e-cola.
- **RN-2** O QR Code vale por 15 minutos.
- **RN-3** Se o QR Code expirar sem pagamento, o pedido continua aberto e o cliente pode gerar um novo QR Code.
- **RN-4** O pedido só é marcado como pago depois da confirmação do banco, nunca pela palavra do cliente.
- **RN-5** Valor mínimo de R$ 1,00.
- **RN-6** Depois de pago, o cliente recebe um e-mail de confirmação.
- **RN-7** O suporte encontra o pagamento pelo número do pedido.

## Critérios de aceite do negócio
- Um cliente consegue pagar um pedido com PIX do início ao fim e recebe o e-mail.
- Um QR Code vencido não confirma pedido nenhum.

## Fora de escopo
- não informado

## Dúvidas abertas
- [NEEDS CLARIFICATION — respondida: contam a partir da geração do QR Code] Os 15 minutos contam a partir de quê?
- [NEEDS CLARIFICATION — assumida: a confirmação duplicada do banco é ignorada, sem segundo e-mail] O que acontece se o banco avisar duas vezes?
- [NEEDS CLARIFICATION — aberta (perguntado no Gate 1, sem resposta)] A imagem do fluxo anexada não foi lida: há alguma regra nela?
- [NEEDS CLARIFICATION — bloqueante] Abaixo de R$ 1,00, o PIX some das opções ou aparece e recusa?
