#!/usr/bin/env bash

LIGHTGREEN="\e[92m"
RESET="\e[0m"

code="
from pathlib import Path
from ruamel.yaml import YAML

compose = YAML().load(Path('docker-compose.yml'))

images = []

for name, service in compose['services'].items():
    images.append(service['image'])

print(*images)
"

if [ ! -f "docker-compose.yml" ]; then
    echo "docker-compose.yml is not present."
    exit 1
fi

operation=$1

function latest() {
    # shellcheck disable=SC2207
    images=($(python -c "$code"))
    for image in "${images[@]}"; do
        echo -e "Pulling image $LIGHTGREEN$image$RESET"
        docker image pull "$image"
    done
}

function reload() {
    docker compose down
    docker compose up -d
}

function update() {
    docker compose down
    latest
    docker compose build --no-cache
    docker compose up -d
}

if [ "$operation" == "latest" ]; then
    latest
elif [ "$operation" == "reload" ]; then
    reload
elif [ "$operation" == "update" ]; then
    update
fi
