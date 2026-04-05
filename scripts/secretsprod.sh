#!/bin/bash
set -e
SRC_DIR=tofu/secrets/prod/plain
DST_DIR=tofu/secrets/prod/sealed
CERT=tofu/secrets/prod/mycert.pem

mkdir -p $DST_DIR

for file in $SRC_DIR/*; do
  name=$(basename "$file" .env)
  kubectl create secret generic "$name" \
    --dry-run=client \
    --from-env-file="$file" \
    -o yaml | kubeseal --cert "$CERT" > "$DST_DIR/$name-sealed.yaml" -n sumcrowds
  kubectl apply -f "$DST_DIR/$name-sealed.yaml"
done
