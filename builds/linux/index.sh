#!/bin/sh
printf '\033c\033]0;%s\a' Barrel Masher!
base_path="$(dirname "$(realpath "$0")")"
"$base_path/index.x86_64" "$@"
