#!/usr/bin/env bash
# Extrai texto de um .docx (Linux/macOS/Git Bash). Só precisa de: unzip + perl (já vêm na maioria das distros).
# Não instala nada. Rode com `bash extract-docx.sh ...` (funciona mesmo sem permissão de execução ou em /tmp noexec).
# Uso: bash extract-docx.sh <arquivo.docx> [saida.md]
set -eu
f="${1:-}"; out="${2:-}"
[ -n "$f" ] && [ -f "$f" ] || { echo "Arquivo não encontrado: ${f:-<vazio>}" >&2; exit 1; }
for c in unzip perl; do
  command -v "$c" >/dev/null 2>&1 || { echo "Falta '$c'. Alternativa sem ferramentas: salve o documento como PDF ou .md." >&2; exit 2; }
done
unzip -l "$f" 2>/dev/null | grep -q 'word/document.xml' || { echo "Não parece um .docx (sem word/document.xml)" >&2; exit 1; }

images=$(unzip -l "$f" | grep -c 'word/media/' || true)
comments=$(unzip -l "$f" | grep -c 'word/comments.xml' || true)
xml=$(unzip -p "$f" word/document.xml)
deletions=$(printf '%s' "$xml" | grep -o '<w:del ' | wc -l | tr -d ' ')
footnotes=$(unzip -p "$f" word/footnotes.xml 2>/dev/null | grep -c '<w:t[ >]' || true)

text=$(printf '%s' "$xml" | perl -0777 -pe '
  s{<w:del\b[^>]*>.*?</w:del>}{}gs;
  s{<mc:Fallback>.*?</mc:Fallback>}{}gs;
  s{<w:instrText\b[^>]*>.*?</w:instrText>}{}gs;
  s{<wp:(?:posOffset|align)>.*?</wp:(?:posOffset|align)>}{}gs;
  s{<w:p\b(?:(?!</w:p>).)*?<w:pStyle w:val="(?:Heading|Ttulo|Titulo|Titre|berschrift)(\d)"[^>]*/>}{"<w:p><w:t>".("#" x $1)." </w:t>"}gse;
  s{<w:numPr>\s*<w:ilvl w:val="(\d+)"\s*/>.*?</w:numPr>}{"<w:t>".("  " x $1)."- </w:t>"}gse;
  s{<w:numPr>.*?</w:numPr>}{<w:t>- </w:t>}gs;
  s{</w:p>(?=\s*</w:tc>)}{}g;
  s{</w:p>}{\n}g; s{<w:br\s*/>}{\n}g; s{<w:tab\s*/>}{\t}g;
  s{</w:tc>}{ | }g; s{</w:tr>}{\n}g;
  s{<[^>]+>}{}g;
  s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&apos;/\x27/g; s/&amp;/&/g;
  s/(?:[ \t]|\xC2\xA0|\xE2\x80[\x80-\x8A\xAF]|\xE3\x80\x80)+\n/\n/g; s/\n{3,}/\n\n/g; s/^\s+|\s+$//g;')

banner=""
[ "$images" -gt 0 ]    && banner="${banner}> AVISO: $images imagem(ns)/diagrama(s) NÃO lidos (word/media). Peça ao usuário para descrevê-los ou exporte-os.
"
[ "$comments" -gt 0 ]  && banner="${banner}> AVISO: O documento tem comentários que NÃO foram extraídos.
"
[ "$deletions" -gt 0 ] && banner="${banner}> AVISO: $deletions trecho(s) excluído(s) em controle de alterações foram ignorados.
"
[ "$footnotes" -gt 0 ] && banner="${banner}> AVISO: O documento tem notas de rodapé que NÃO foram extraídas.
"
[ -z "$text" ] && banner="${banner}> AVISO: Nenhum texto no corpo do documento (só cabeçalho/rodapé, imagens ou campos). Peça o conteúdo ao usuário.
"
[ -n "$banner" ] && { printf '%s' "$banner" | sed 's/^> AVISO: /AVISO: /' >&2; text="${banner}
${text}"; }

if [ -n "$out" ]; then
  mkdir -p "$(dirname "$out")"
  printf '%s\n' "$text" > "$out"
  echo "OK -> $out (imagens: $images; comentários: $comments; excluídos: $deletions)"
else
  printf '%s\n' "$text"
fi
