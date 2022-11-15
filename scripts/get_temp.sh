#!/usr/bin/env bash

set -o errexit   # stop when error occurs
set -o pipefail  # if not, expressions like `error here | true`
                 # will always succeed
set -o nounset   # detects uninitialised variables
set -o xtrace    # prints every expression
                 # before executing it (debugging)


# import external modules
source "lib.bash"


# main function
function main(){
    local query="${1:?Error: No city name given, which is required.}"
    local units="${2:-metric}"

    get_temperature "${query}" "${units}"
}


# call the func only if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
