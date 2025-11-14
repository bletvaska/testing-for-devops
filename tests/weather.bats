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


# test fixtures
function setup_file() {
    # docker image pull "${IMAGE}"
    docker container run --rm -it \
        --detach \
        --name "${CONTAINER_NAME}" \
        "${IMAGE}"
}

function teardown_file() {
    docker container stop "${CONTAINER_NAME}"
    # docker image rm "${IMAGE}"
}

function docker_exec() {
    docker container exec "${CONTAINER_NAME}" "${@}"
}

# tests
@test "when started, then username is mrilko" {
    # arrange
    local expected="mrilko"
    local cmd="whoami"

    # act and assert
    run docker_exec "${cmd}"
    assert_output "${expected}"
}


@test "when started, then Python version is 3.11" {
    run docker_exec python --version
    assert_output --partial "Python 3.11." 
}


@test "when started, then current working directory is /app" {
    run docker_exec pwd
    assert_output "/app" 
}


@test "when the image was scanned/created, then it should have no high or above vulnerabilities" {    
    run grype --fail-on critical --sort-by "severity" "${IMAGE}"
    assert_success
}

