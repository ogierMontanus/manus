#!/usr/bin/env sh
# Build and deploy the manus app and the manus-data documents into the
# eXist-db instance running inside this dev container (admin / blank password).
set -e

# Wait for eXist-db to accept requests.
sleep 10

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATA_DIR="/workspaces/manus-data"

deploy_xars() {
    dir="$1"
    [ -d "$dir" ] || { echo "Skipping $dir (not mounted)"; return 0; }
    echo "Building $dir ..."
    ( cd "$dir" && ant )
    for XAR in "$dir"/build/*.xar; do
        [ -f "$XAR" ] || continue
        echo "Installing $XAR"
        curl --upload-file "$XAR" -u 'admin:' http://localhost:8080/exist/rest/db/system/repo/init.xar
        curl -u 'admin:' 'http://localhost:8080/exist/rest/db?_xpath=repo:install-and-deploy-from-db("/db/system/repo/init.xar")'
    done
}

# Deploy the application first (provides collection config / data collection),
# then the manus-data documents.
deploy_xars "$APP_DIR"
deploy_xars "$DATA_DIR"
