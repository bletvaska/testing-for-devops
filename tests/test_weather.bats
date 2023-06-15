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
