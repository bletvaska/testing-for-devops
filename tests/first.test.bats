#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load


# tests
@test "if cat was invoked with nonexistent file then exit status should be 1" {
    run cat some_file_which_doesnt_exist
    assert_failure
}

@test "if cat was invoked with nonexistent file then expect error message" {
    run cat some_file_which_doesnt_exist
    assert_output "cat: some_file_which_doesnt_exist: No such file or directory"
}
