#!/bin/bash

set -euo pipefail


function trace() {
    {
        local tracing
        [[ "$-" = *"x"* ]] && tracing=true || tracing=false
        set +x
    } 2>/dev/null
    if [ "$tracing" != true ]; then
        # Bash's own trace mode is off, so explicitely write the message.
        echo "$@" >&2
    else
        # Restore trace
        set -x
    fi
}


function contains () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}


# Parse arguments.
operations=()
subcommand_opts=()
while true; do
    case "${1:-}" in
    delete)
        operations+=( delete )
        shift
        ;;
    start)
            operations+=( start )
            shift
            ;;
    stop)
        operations+=( stop )
        shift
        ;;
    --)
        shift
        break
        ;;
    -h|--help)
        operations+=( usage )
        shift
        ;;
    *)
        break
        ;;
    esac
done
if [ "${#operations[@]}" -eq 0 ]; then
    operations=( usage )
fi
if [ "$#" -gt 0 ]; then
    subcommand_opts=( "$@" )
fi


function usage() {
    trace "$0 <command> [--] [options ...]"
    trace "Commands:"
    trace "    delete       Stop the data platform, delete containers and iceberg data from host"
    trace "    start       Run the data platform"
    trace "    stop      Stop the data platform, retain containers and iceberg data from host"
    trace "Options are passed through to the sub-command."
}


function delete() {
    trace "Deleting containers and iceberg data"
    ./scripts/delete.sh "${subcommand_opts[@]:+${subcommand_opts[@]}}"
}

function start() {
    trace "Starting app"
    ./scripts/start.sh "${subcommand_opts[@]:+${subcommand_opts[@]}}"
}

function stop() {
    trace "Stopping app"
    ./scripts/stop.sh "${subcommand_opts[@]:+${subcommand_opts[@]}}"
}


script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "${script_directory}/"


if contains usage "${operations[@]}"; then
    usage
    exit 1
fi
if contains delete "${operations[@]}"; then
    delete
fi
if contains start "${operations[@]}"; then
    start
fi
if contains stop "${operations[@]}"; then
    stop
fi


trace "Exited cleanly."
