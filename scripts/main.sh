#!/usr/bin/env bash

# shellcheck source=/dev/null
source helper.sh

function main() {
    hello
}

# call the func only if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
