#!/bin/bash

set -euo pipefail

echo "stop script" >&2

script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "${script_directory}/.."

docker compose down
rm -rf ${HOME}/minio/data

echo "containers are deleted and minio directory cleared" >&2
