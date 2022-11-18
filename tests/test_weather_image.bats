#!/usr/bin/env bats

set -o errexit
set -o pipefail
set -o nounset

# load modules
load "/tools/libs/bats-support/load"
load "/tools/libs/bats-assert/load"

# global variables
readonly container_name="weather"
readonly image_name="bletvaska/weather"


function setup_file() {
    docker container run --rm \
        --name "${container_name}" \
        --detach \
        "${image_name}"
}


function teardown_file() {
    docker container rm -f "${container_name}"
    [[ "${ENVIRONMENT:-dev}" == "prod" ]] && docker image rm "${image_name}"
}


@test "when statrted, then workdir should be /" {
    run docker container exec "${container_name}" pwd
    assert_equal "${output}" "/"
}


@test "when started, then user should be mrilko" {
    run docker container exec "${container_name}" whoami
    assert_equal "${output}" "mrilko"
}


@test "when started, then python version should be 3.10.5" {
    run docker container exec "${container_name}" python3 --version
    assert_equal "${output}" "Python 3.10.8"
}


@test "when started, then running command should be weather" {
    run docker image inspect -f '{{.Config.Cmd}}' "${image_name}"
    assert_equal "${output}" "[weather]"
}


@test "when started, then weather has pid 1" {
    run docker container exec "${container_name}" pgrep weather
    assert_equal "${output}" 1
}

