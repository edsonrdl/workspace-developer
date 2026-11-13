# Security — Segurança inegociável

> Seção da [[constitution]]. Autoridade máxima — não pode ser sobrescrita por patterns ou specs.

---

## Segredos e credenciais

- Nenhum segredo, chave, token ou credencial no código ou no repositório — nunca
- Segredos injetados via **AWS Parameter Store** (configuração) ou **AWS Secrets Manager** (credenciais rotacionadas)
- Variáveis de ambiente validadas no boot do serviço — falha explícita se ausentes
- `.env` nunca commitado — apenas `.env.example` com nomes e descrições, sem valores

---

## Comunicação

- Toda comunicação externa via **HTTPS** — sem exceção
- Certificados validados — sem `rejectUnauthorized: false` em produção
- Tokens de autenticação com expiração máxima definida pelo pattern [[rest-api]]

---

## Dados sensíveis

Nunca armazenar nem logar:

| Categoria | Exemplos |
|---|---|
| Documentos pessoais | CPF, RG, passaporte |
| Autenticação | Senhas, tokens, API keys, private keys |
| Financeiro | Número de cartão, CVV, dados bancários completos |
| Saúde | Diagnósticos, prontuários |

Quando o dado sensível for necessário para o fluxo: usar apenas o **token/referência** retornado por um sistema externo especializado (ex: gateway de pagamento tokeniza o cartão — este serviço recebe apenas o token).

---

## Dependências

- `npm audit` obrigatório antes de qualquer merge em produção
- Vulnerabilidades críticas ou altas bloqueiam o merge — sem exceções
- Dependências desatualizadas com CVE conhecido são consideradas dívida técnica crítica
