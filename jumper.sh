#!/usr/bin/env bash
AUTOWARE_ROOT_DIRECTORY="$PWD/$(dirname "${BASH_SOURCE[0]}")"

toroot() { cd "$AUTOWARE_ROOT_DIRECTORY"; }
tosrc() { cd "$AUTOWARE_ROOT_DIRECTORY/src"; }
