#!/usr/bin/env bash
probar() {
  if kubectl -n agrosugar exec "$1" -- nc -z -w 3 "$2" "$3" >/dev/null 2>&1; then
    echo "$1 -> $2:$3  PERMITIDO"
  else
    echo "$1 -> $2:$3  BLOQUEADO"
  fi
}

probar sensor-hidratacion-01 mqtt-broker 1883
probar sensor-hidratacion-01 db-transaccional 5432
probar intruso mqtt-broker 1883
probar intruso db-transaccional 5432
