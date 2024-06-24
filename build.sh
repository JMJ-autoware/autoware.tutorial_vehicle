#!/usr/bin/env bash

set -e
exec 3>&1

build_target() {
  local regex='Failed +<+ +(\w+)'
  local target=$1
  local options=( "${@:2}" )

  while true; do
    if [ -n "$target" ]; then
      echo "<| build $target |>"
      local err=$(colcon build --packages-up-to "$target" "${options[@]}" 2>&1 1>&3 | tee /dev/stderr)
    else
      echo '<| build all |>'
      local err=$(colcon build "${options[@]}" 2>&1 1>&3 | tee /dev/stderr)
    fi

    if [[ $err =~ $regex ]]; then
      build_target "${BASH_REMATCH[1]}" "${options[@]}"
    else
      break
    fi
  done

}

main() {
  if [[ $1 == -* ]]; then
    build_target "" "$@"
  else
    build_target "$@"
  fi
}

main "$@"
