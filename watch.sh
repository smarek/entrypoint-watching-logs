#!/bin/bash

# relative import
source "${0%/*}/functions.sh"

function display_usage() {
  echo "usage: $(basename $0) [-h] WATCHED_DIR WATCHED_DIR ..."
}

# each watched (tailed) file
_WATCHES=()
_DIRS=()

# not enough arguments
if [ $# -le 0 ]; then
  echo "missing arguments"
  display_usage
  exit 1
fi

options=$(getopt -l "help" -o "h" -a -- "$@")
eval set -- "$options"

while true
do
  case $1 in
  -h|--help)
    display_usage >&2
    exit 0
    ;;
  ?)
    display_usage >&2
    exit 1
    ;;
  --)
    shift
    break;;
  esac
  shift
done

