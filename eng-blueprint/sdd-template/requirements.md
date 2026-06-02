# requirements.md — [Nome do Projeto ou Feature]

---

## Referências

<!--
Liste apenas o que este arquivo referencia — sem repetir o conteúdo.
NFRs universais (cobertura, segurança, logs) estão em [[constitution]] — não repita aqui.
-->

- [[constitution]] — NFRs universais: cobertura mínima, segurança, logs sem dados sensíveis
- [[spec]] — problema e escopo que estes requisitos atendem

---

## Como escrever requisitos neste arquivo

<!--
Use a sintaxe EARS (Easy Approach to Requirements Syntax):
  "Quando <trigger>, o <sistema> deve <resposta do sistema>."
  "Enquanto <pré-condição>, o <sistema> deve <resposta do sistema>."
  "O <sistema> deve <resposta do sistema>."  ← para requisitos sem condição

EARS garante que cada requisito seja:
  ✅ Testável — tem uma resposta verificável
  ✅ Não ambíguo — sem palavras como "rápido", "adequado", "fácil"
  ✅ Atômico — uma única responsabilidade por ID

Exemplos:
  ❌ "O sistema deve processar pagamentos rapidamente."
  ✅ "FR-003 — O sistema deve processar o pagamento via gateway em no máximo 3s (p99) no caminho nominal."

  ❌ "O sistema deve validar os dados."
  ✅ "FR-002 — Quando o método de pagamento não for CREDIT_CARD, PIX ou BOLETO, o sistema deve rejeitar a requisição com status 400."
-->

---

## Requisitos funcionais

<!--
Um ID por requisito. Formato: FR-001, FR-002, ...
Se um requisito depende de outro, anote: "(depende de FR-xxx)"
-->

**FR-001** — [Quando/Enquanto/O sistema] [descrição do comportamento esperado].

**FR-002** — [Quando/Enquanto/O sistema] [descrição do comportamento esperado].

**FR-003** — [Quando/Enquanto/O sistema] [descrição do comportamento esperado].

<!-- Adicione quantos forem necessários. Não agrupe — um comportamento por ID. -->

---

## Requisitos não funcionais específicos desta feature

<!--
Coloque aqui APENAS os NFRs únicos deste projeto/feature.
NFRs gerais (80% cobertura, sem segredos, logs sem dados sensíveis) estão em [[constitution]].

Bons NFRs são mensuráveis:
  ❌ "O sistema deve ser rápido."
  ✅ "NFR-001 — Tempo de resposta p99 abaixo de 500ms para leituras."

  ❌ "O sistema deve ser seguro."
  ✅ "NFR-002 — Nenhum dado de cartão deve ser armazenado — apenas tokens retornados pelo gateway."
-->

**NFR-001** — [Métricas de performance, latência, throughput específicos desta feature].

**NFR-002** — [Restrições de segurança específicas desta feature — ex: dados que não podem ser armazenados].

**NFR-003** — [Restrições de consistência, idempotência, ordenação específicas desta feature].

<!-- Adicione quantos forem necessários. Remova os que não se aplicam. -->

---

## Restrições

<!--
Restrições são fatos que limitam as escolhas de implementação.
Diferente de NFRs (que definem qualidade), restrições definem o que NÃO pode ser feito.

Exemplos:
- "Deve funcionar sem acesso à internet (ambiente air-gapped)."
- "Não pode usar bibliotecas com licença GPL."
- "Deve ser compatível com Node.js 18 LTS — sem features do Node 20."
- "O banco de dados é legado e não pode receber migrações automatizadas."
-->

- [restrição 1]
- [restrição 2]

<!-- Se não houver restrições específicas além das da [[constitution]], remova esta seção. -->

---

## Dependências externas

<!--
O que este projeto/feature precisa que já existe ou deve existir antes da implementação?
Isso evita que o agente tente criar infraestrutura que já existe ou que está fora do escopo.

Exemplos:
- "Fila SQS já provisionada — este serviço apenas publica."
- "Banco PostgreSQL já existente — migração incremental."
- "Auth via JWT gerenciado pelo api-gateway — este serviço apenas valida o token."
-->

- [dependência 1 — o que é e qual o contrato esperado]
- [dependência 2]
