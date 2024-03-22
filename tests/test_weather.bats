#!/usr/bin/env bats

# load modules
load libs/bats-support/load
load libs/bats-assert/load


@test "when started then working directory is set to /app" {
    run docker container run --rm bletvaska/weather pwd
    assert_output "/app"
}
