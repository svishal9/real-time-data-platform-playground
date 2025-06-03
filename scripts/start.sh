#!/bin/bash

set -euo pipefail

script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "${script_directory}/.."

docker compose up -d --build

echo "containers are up" >&2
