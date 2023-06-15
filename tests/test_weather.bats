#!/usr/bin/env bats

# globals
source local.env
readonly IMAGE_NAME=bletvaska/weather
readonly CONTAINER_NAME=weather

# bats libraries
load "${LIBS}/bats-assert/load.bash"
load "${LIBS}/bats-support/load.bash"


function setup_file() {
    docker container run --rm --name "${CONTAINER_NAME}" --detach "${IMAGE_NAME}"
}

function teardown_file() {
    docker container stop "${CONTAINER_NAME}"
}

@test "when run, then first process will be python weather (PID 1)" {
    run docker container exec "${CONTAINER_NAME}" pgrep weather
    assert_output 1
}

# @test "when run, then weather package version is 2023.3" {
#     run docker container exec "${CONTAINER_NAME}" bash -c 'pip list | grep weather | egrep  -o "([0-9.]+)$" 2> /dev/null' 
#     assert_output 2023.3
# }

@test "when run, then python is of version 3.11.1" {
    # act
    run docker container exec "${CONTAINER_NAME}" python3 --version

    # assert
    assert_output "Python 3.11.1"
}


@test "when run, then user should be mrilko" {
    run docker container exec "${CONTAINER_NAME}" whoami
    assert_output "mrilko"
}

@test "when run, then working directory should be /app" {
    run docker container exec "${CONTAINER_NAME}" pwd
    assert_output "/app"
}
