#!/usr/bin/env bash
# Uso: ./emitir-bus.sh 102 105
set -euo pipefail

cd "$(dirname "$0")/../pki"
for n in $(seq "$1" "$2"); do
  id="bus-${n}"
  openssl genrsa -out "${id}.key" 2048 2>/dev/null
  openssl req -new -key "${id}.key" -subj "/C=CO/O=MetroMIO/OU=Flota/CN=${id}" -out "${id}.csr"
  openssl x509 -req -in "${id}.csr" -CA ca.crt -CAkey ca.key -CAcreateserial \
    -out "${id}.crt" -days 30 -sha256 -extfile client.ext 2>/dev/null
  echo "Emitido ${id} (vence: $(openssl x509 -in "${id}.crt" -noout -enddate | cut -d= -f2))"
done
