#!/bin/bash

set -euo pipefail

echo "stop script" >&2

script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "${script_directory}/.."

docker compose stop

echo "containers are stopped" >&2
