#!/usr/bin/env bats

load "/tools/libs/bats-support/load"
load "/tools/libs/bats-assert/load"

readonly container_name="weather"
readonly image_name="bletvaska/weather"


function setup_file() {
    docker container run --rm \
        --name "${container_name}" \
        --detach \
        "${image_name}"
}


function teardown_file() {
    printf "working on"
    docker container rm -f "${container_name}"
    # [[ "${ENVIRONMENT:-dev~}" == "prod" ]] && docker image rm "${image_name}"
}


@test "when statrted, then workdir should be /" {
    run docker container run --rm bletvaska/weather pwd
    assert_equal "${output}" "/"
}


@test "when started, then user should be mrilko" {
    run docker container run --rm bletvaska/weather whoami
    assert_equal "${output}" "mrilko"
}


@test "when started, then python version should be 3.10.5" {
    run docker container run --rm bletvaska/weather python3 --version
    assert_equal "${output}" "Python 3.10.5"
}


@test "when started, then running command should be weather" {
    run docker image inspect -f '{{.Config.Cmd}}' bletvaska/weather
    assert_equal "${output}" "[weather]"
}
