#!/usr/bin/env bash

set -o errexit   # stop when error occurs
set -o pipefail  # if not, expressions like `error here | true`
                 # will always succeed
set -o nounset   # detects uninitialised variables
set -o xtrace    # prints every expression
                 # before executing it (debugging)

printf "Get ready for some magic!\n"
folder = "tmp/cache"
rm --recursive --force "${HOME}/${folder}"
printf "Enjoy ;)\n"
