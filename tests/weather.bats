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


@test "when started, then username is mrilko" {
    run docker container run bletvaska/weather:latest whoami
    assert_output "mrilko"
}


@test "when started, then Python version is 3.11" {
    run docker container run bletvaska/weather:latest python --version
    assert_output --partial "Python 3.11." 
}


@test "when started, then current working directory is /app" {
    run docker container run bletvaska/weather:latest pwd
    assert_output "/app" 
}
