#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"

# global variables
readonly image_name='bletvaska/weather'
readonly container_name='weather'


function setup_file() {
    docker container run --rm \
        --name "${container_name}" \
        --detach \
        "${image_name}"
}


function teardown_file() {
    docker container rm -f "${container_name}"
}


@test "when running then python version should be 3.11.1" {
    local expected="Python 3.11.1"
    run docker container exec "${container_name}" python --version

    assert_equal "${output}" "${expected}"
}


@test "when running then user should be mrilko" {
    local expected="mrilko"
    run docker container exec "${container_name}" whoami

    assert_equal "${output}" "${expected}"
}


@test "when running then architecture is x86_64" {
    local expected="x86_64"
    run docker container exec "${container_name}" uname --machine

    assert_equal "${output}" "${expected}"
}