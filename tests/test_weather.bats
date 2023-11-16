#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load

# globals
readonly IMAGE_NAME='bletvaska/weather'
readonly CONTAINER_NAME='weather'


function setup_file() {
    docker container run --rm -it \
        --name "${CONTAINER_NAME}" \
        --detach \
        "${IMAGE_NAME}"
}

function teardown_file() {
    docker container stop "${CONTAINER_NAME}"
}

@test "when executed then working directory should be /app" {
    run docker container exec "${CONTAINER_NAME}" pwd
    assert_output "/app"
}

@test "when executed then user is mrilko" {
    run docker container exec "${CONTAINER_NAME}" whoami
    assert_output "mrilko"
}

@test "when executed then python version should be 3.11" {
    run docker container exec "${CONTAINER_NAME}" python --version
    assert_output "Python 3.11.1"
}

# @test "when executed then python package weather will be installed with version 1.2.0" {
#     run docker container exec "${CONTAINER_NAME}" python --version
#     assert_output "Python 3.11.1"
# }
