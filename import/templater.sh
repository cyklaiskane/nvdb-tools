#!/bin/bash

[ $# -lt 1 ] && echo "Usage: $(basename $0) template [key=value ...]" >&2 && exit 1

[ ! -r "$1" ] && echo "Error: Could not read template file '${1}'" >&2 && exit 2

output=$(<${1})

shift

for kv in "$@"; do
  set -- ${kv/=/ }
  k=${1}; shift
  v=$*
  output="${output//\{\{${k}\}\}/${v}}"
done

echo "${output}"
