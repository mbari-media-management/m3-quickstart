#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$( cd "$( dirname "${MY_DIR}/../.." )" && pwd )"

cd "$BASE_DIR"
source "${BASE_DIR}/bin/docker-env.sh"
docker compose build