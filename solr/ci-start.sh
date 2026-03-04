#!/usr/bin/env bash
set -euo pipefail

SOLR_PORT="${SOLR_PORT:-8983}"
ZK_HOST="${ZK_HOST:-localhost:9983}"
SOLR_DIR="${SOLR_DIR:-/opt/solr}"

cd "$SOLR_DIR"

# Start SolrCloud in background
bin/solr start -cloud -noprompt -p "$SOLR_PORT" -z "$ZK_HOST"

# Wait for Solr to respond
for i in {1..60}; do
  if curl -fsS "http://localhost:${SOLR_PORT}/solr/admin/info/system" >/dev/null; then
    break
  fi
  sleep 1
done

# Push security.json into ZK
server/scripts/cloud-scripts/zkcli.sh -zkhost "$ZK_HOST" \
  -cmd putfile /security.json /opt/solr/security.json

# Keep container alive
tail -f /dev/null
