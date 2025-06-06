#!/bin/bash

set -euo pipefail

echo "Selecting all rows from iceberg table default.test_table via DuckDB" >&2

script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "${script_directory}/.."

docker exec -it duckdb /tmp/query_in_time.sh

echo "Logs printed successfully" >&2
