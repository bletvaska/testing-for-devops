#!/usr/bin/env bash

set -o errexit      # stop when error occurs
set -o pipefail     # if not, expressions like `error here | true`
                    # will always succeed
set -o nounset      # detects uninitialised variables
set -o xtrace       # prints every expression
                    # before executing it (debugging)


function hello() {
    printf "Get ready for some magic!\n"
}

function main() {
    printf "lets start\n"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
