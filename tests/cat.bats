#!/usr/bin/env bats


# load modules/libraries
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

# globals
readonly CMD=/usr/bin/cat


@test "if file doesn't exist then exit status is 1" {
    # arrange
    local file
    file=$(mktemp --dry-run)

    # act
    run "${CMD}" "${file}"

    # assert
    assert_failure
}


@test "if file doesn't exist then show error message" {
    # arrange
    local file
    file=$(mktemp --dry-run)

    # act
    run "${CMD}" "${file}"

    # assert
    assert_output "${CMD}: ${file}: No such file or directory"
}

