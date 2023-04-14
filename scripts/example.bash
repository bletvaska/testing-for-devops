#!/usr/bin/env bash

# set -o errexit   # stop when error occurs
# set -o pipefail  # if not, expressions like `error here | true`
#                  # will always succeed
# set -o nounset   # detects uninitialised variables
# set -o xtrace    # prints every expression
#                  # before executing it (debugging)

# printf "Get ready for some magic!\n"
# folder = "tmp/cache"
# rm --recursive --force "${HOME}/${folder}"
# printf "Enjoy ;)\n"


function greeting(){
  local name=$1
  printf "Hello %s!\n" "${name}"
}

function hello(){
    printf "Hello world\n"
}

function main(){
    hello
    greeting "mirek"

}

# call the func only if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  printf "Current environment is: %s\n" "${ENVIRONMENT:-dev}"
  main "$@"
fi
