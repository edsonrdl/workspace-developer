> (Simula o texto de um Word recebido do time de negócio.)

# Pagamento via PIX no checkout

Hoje o cliente só consegue pagar com cartão. A gente perde venda de quem não tem cartão
ou prefere PIX, principalmente no celular. Queremos oferecer PIX na tela de pagamento.

O cliente escolhe PIX, o sistema mostra um QR Code e um código copia-e-cola. O QR Code
vale por 15 minutos. Se não pagar nesse tempo, o pedido continua aberto e ele pode
gerar um novo QR Code.

O pedido só deve ser marcado como pago depois que o banco avisar que recebeu. Não vale
confiar só em o cliente dizer que pagou. Valor mínimo de R$ 1,00. Depois de pago, o
cliente deve receber um e-mail de confirmação.

Veja o fluxo desenhado na imagem em anexo. O time de suporte vai precisar achar o
pagamento pelo número do pedido.
