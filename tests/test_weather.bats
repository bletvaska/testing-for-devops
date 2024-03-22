#!/usr/bin/env bats

# load modules
load libs/bats-support/load
load libs/bats-assert/load

# globals
readonly CONTAINER_NAME='weather'
readonly IMAGE_NAME='bletvaska/weather'


function setup_file() {
    docker container run --rm -it \
        --name "${CONTAINER_NAME}" \
        --detach \
        "${IMAGE_NAME}"
}

function teardown_file() {
    docker container stop "${CONTAINER_NAME}"
}

@test "when started then working directory is set to /app" {
    run docker container exec "${CONTAINER_NAME}" pwd
    assert_output "/app"
}

@test "when started then the user is mrilko" {
    run docker container exec "${CONTAINER_NAME}" whoami
    assert_output "mrilko"
}

@test "when started then Python interpreter is of version 3.11" {
    run docker container exec -it "${CONTAINER_NAME}" python --version
    assert_output --partial "3.11."
}

@test "when started then Python package weather is installed in version 2023.3" {
    run docker container exec -it "${CONTAINER_NAME}" pip show weather
    assert_output --partial "Version: 2023.3"
}

@test "when started, then first process, which will be executed, is python weather" {
    # arrange
    local expected="/usr/local/bin/python /usr/local/bin/weather"
    local cmd="ps --pid 1 -o cmd"

    # act
    run docker container exec -it "${CONTAINER_NAME}" "${cmd}"

    # assert
    assert_output "${expected}"
}

@test "vulnerability testing" {
    run grype "${IMAGE_NAME}" --fail-on high --quiet
    assert_success
}

# @test "goss testing" {
#     dgoss run 
# }
