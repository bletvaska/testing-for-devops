#!/usr/bin/env bats

load "/tools/libs/bats-support/load"
load "/tools/libs/bats-assert/load"


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
