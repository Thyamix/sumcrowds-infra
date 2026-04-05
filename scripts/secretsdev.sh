#!/bin/bash
set -e
SRC_DIR=tofu/secrets/dev/plain
DST_DIR=tofu/secrets/dev/sealed
CERT=tofu/secrets/dev/mycert.pem

mkdir -p $DST_DIR

for file in $SRC_DIR/*; do
  name=$(basename "$file" .env)
  kubectl create secret generic "$name" \
    --dry-run=client \
    --from-env-file="$file" \
    -o yaml | kubeseal --cert "$CERT" > "$DST_DIR/$name-sealed.yaml" -n dev
  kubectl apply -f "$DST_DIR/$name-sealed.yaml"
done
