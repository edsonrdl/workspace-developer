# Constitution

> Este é o documento raiz do vault `eng-blueprint`. Contém apenas o que é universal — regras que se aplicam a qualquer projeto, independente de arquitetura ou tecnologia escolhida. Cada arquitetura estende este documento com suas próprias políticas. Nenhuma regra aqui pode ser sobrescrita por documentos filhos.

---

## Autoridade deste documento

Este arquivo tem prioridade sobre qualquer outro documento do vault. Em caso de conflito entre este arquivo e um pattern ou workspace, este prevalece. Nenhuma regra aqui pode ser sobrescrita por documentos filhos.

---

## Linguagem e stack aprovados

- **Linguagem principal:** TypeScript
- **Runtime:** Node.js (versão LTS vigente)
- **Cloud:** AWS (único provedor aprovado)
- **Infraestrutura como código:** Terraform ou AWS CDK
- **Controle de versão:** Git — nomenclatura de branches segue convenção `tipo/descricao-curta`

Qualquer adição de linguagem ou provedor fora desta lista requer aprovação do arquiteto e registro de ADR antes de qualquer implementação.

---

## Segurança — inegociável

- Nenhum segredo, chave, token ou credencial no código ou no repositório
- Segredos via AWS Secrets Manager ou Parameter Store
- Toda comunicação externa via HTTPS
- Dados sensíveis nunca em logs — sem CPF, senha, token, número de cartão
- Dependências auditadas antes de qualquer merge em produção (`npm audit`)

---

## Qualidade de código

- Cobertura mínima de testes: **80%**
- Linting obrigatório: ESLint com configuração do repositório de padrões da empresa
- Sem `any` explícito em TypeScript sem justificativa documentada no código
- Toda função com mais de 20 linhas deve ter comentário de propósito
- Nenhum `console.log` em produção — usar logger estruturado aprovado

---

## Documentação obrigatória por repositório

Todo repositório deve conter na raiz:

- `README.md` — propósito, como rodar localmente, variáveis de ambiente necessárias
- `CHANGELOG.md` — atualizado a cada release
- `docs/adr/` — decisões arquiteturais registradas em ADR

---

## Processo de aprovação de novos padrões

1. Proposta escrita em formato ADR no repositório de padrões
2. Revisão pelo arquiteto responsável
3. Se aprovado, documentado nos arquivos de `patterns/` deste vault
4. Implementações anteriores à aprovação são consideradas experimentais

---

## Controle de versão deste documento

|Versão|Data|Mudança|
|---|---|---|
|1.0|2025-05|Versão inicial|