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

if [ "$operation" == "update" ]; then
    # shellcheck disable=SC2207
    images=($(python -c "$code"))
    for image in "${images[@]}"; do
        echo -e "Pulling image $LIGHTGREEN$image$RESET"
        docker image pull "$image"
    done
elif [ "$operation" == "reload" ]; then
    docker compose down
    docker compose up -d
fi
