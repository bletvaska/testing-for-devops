#!/usr/bin/env bats

load '../libs/bats-assert/load.bash'
load '../libs/bats-support/load.bash'


readonly CONTAINER_NAME=weather

function setup_file(){
    docker container run --rm -it \
    --name "${CONTAINER_NAME}" \
    --detach \
    bletvaska/weather
}


function teardown_file(){
     docker container stop "${CONTAINER_NAME}"
}


@test "when started then user is mrilko" {
    # arrange
    local expected="mrilko"
    local cmd="whoami"

    # act
    run docker container exec "${CONTAINER_NAME}" "${cmd}"

    # assert
    assert_equal "${output}" "${expected}"
}


@test "when started, then process with pid=1 is python weather" {
    # arrange
    local cmd="ps --pid 1 --no-headers -o cmd"
    local expected="/usr/local/bin/python /usr/local/bin/weather"

    # act
    run docker container exec "${CONTAINER_NAME}" ps --pid 1 --no-headers -o cmd

    # assert
    assert_equal "${output}" "${expected}"
}


@test "when started, then verson of python is 3.10.5" {
    # arrange
    local cmd="python --version"
    local expected="Python 3.10.5"

    # act
    run docker container exec "${CONTAINER_NAME}" python --version

    # assert
    assert_equal "${output}" "${expected}"
}

