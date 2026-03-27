#!/bin/sh
set -eu

READY_FILE=${BOOTSTRAP_READY_FILE:-/tmp/temporal-bootstrap-ready}

rm -f "$READY_FILE"

while true; do
  if /scripts/setup-postgres-es.sh; then
    touch "$READY_FILE"
    echo "Temporal bootstrap completed, keeping container alive for dependency health checks"
    exec tail -f /dev/null
  fi

  echo 'Temporal bootstrap failed, retrying in 5 seconds...'
  sleep 5
done
