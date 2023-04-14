#!/usr/bin/env bats

load libs/bats-support/load.bash
load libs/bats-assert/load.bash

@test "when invoked with name of directory then the directory should be created" {
    # arrange
    folder=$(mktemp --dry-run)

    # act
    run mkdir "${folder}"

    # assert
    assert [ -d "${folder}" ]
    rmdir "${folder}"
}


@test "when invoked with name of directory then exit status should be 0" {
    # arrange
    folder=$(mktemp --dry-run)
    expected=0

    # act
    run mkdir "${folder}"

    # assert
    assert [ $status == $expected ]
    rmdir "${folder}"
}
