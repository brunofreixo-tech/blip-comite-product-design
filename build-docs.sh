#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="/Users/voceqpad/Projects/missao-da-semana/docs/sprints"
DEST_DIR="/tmp/blip-comite-pages"
TEMPLATE="$DEST_DIR/doc-template.html"

DOCS=(
  "fluxo_onboarding_atual"
  "spec_onboarding_revisado"
  "narrativa_onboarding_comite"
  "loop_semanal_atual"
  "spec_microinteracoes_conclusao"
  "spec_childhome_perfis"
  "narrativa_sistema_flexivel_comite"
  "spec_resumo_semanal_pai"
  "identidade_blip_comite"
  "antipadroes_comite"
  "metricas_ux_comite"
  "indice_apresentacao_comite"
  "gaps_abertos"
)

for doc in "${DOCS[@]}"; do
  TITLE=$(head -1 "$SOURCE_DIR/${doc}.md" | sed 's/^# //')
  echo "Converting: $doc → $TITLE"
  pandoc \
    --from=markdown+pipe_tables \
    --to=html5 \
    --template="$TEMPLATE" \
    --metadata title="$TITLE" \
    --output="$DEST_DIR/${doc}.html" \
    "$SOURCE_DIR/${doc}.md"
done

echo ""
echo "Done — ${#DOCS[@]} files converted."
