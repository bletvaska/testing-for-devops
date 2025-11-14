#!/usr/bin/env bats

if [[ -f "${BATS_TEST_DIRNAME}/weather.env" ]]; then
   source "${BATS_TEST_DIRNAME}/weather.env"
fi

# load modules/libraries
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

# globals
readonly IMAGE="bletvaska/weather:latest"
readonly CONTAINER_NAME="weather"

