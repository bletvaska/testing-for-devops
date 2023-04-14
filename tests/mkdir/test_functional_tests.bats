#!/usr/bin/env bats

# set -o nounset

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"


function setup() {
    folder=$(mktemp --dry-run)
}

function teardown() {
    rmdir "${folder}"
}

@test "WIP: when invoked with name of directory then the directory should be created" {
    # act
    run mkdir "${folder}"

    # assert
    assert [ -d "${folder}" ]
}


@test "when invoked with name of directory then exit status should be 0" {
    # act
    run mkdir "${folder}"

    # assert
    assert_success
}


@test "when folder is created, then it shoud have correct permissions" {
    # arrange
    expected="775"

    # act
    run mkdir "${folder}"
    actual=$(stat --format '%a' "${folder}")

    # assert
    assert_equal "${actual}" "${expected}"
}

