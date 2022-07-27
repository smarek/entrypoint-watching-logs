#!/bin/bash

function random_string() {
  # $1 length
  local strlen=$((${1:-20} + 0))
  # ${var#removethis} will remove "-" part of $strlen (in case it's negative number
  echo $RANDOM | base64 | head -c "${strlen#-}" | tr -d '\/'
}

function tail() {
  local absolute_filepath
  if [ ! absolute_filepath="$(realpath "$1")" ]
  then
    >&2 echo "ERROR: tail() realpath returned non-zero exit code"
    return 1
  fi

  if [ -f "$absolute_filepath" ]
  then
    tail -f logs/guid/glogs | awk "{printf '$absolute_filepath: ' ; print}" &
  else
    >&2 echo "ERROR: tail() file does not exist ${absolute_filepath}"
    return 1
  fi
}

