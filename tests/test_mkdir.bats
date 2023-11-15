#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load

# tests
@test "if the mkdir is invoked with valid name then exit status is 0" {
    run mkdir new_folder
    assert_success
    rmdir new_folder
}

@test "if the creating directory already exists then exit status will be 1" {
    run mkdir $(pwd)
    assert_failure
}

@test "if the creating directory already exists then expect error message" {
    run mkdir .
    assert_output "mkdir: cannot create directory ‘.’: File exists"
}
