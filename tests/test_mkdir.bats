#!/usr/bin/env bats

set -o nounset

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

@test "when no directory name is provided then show error message" {
    run mkdir
    # assert [ "${lines[0]}" = "mkdir: missing operand" ]
    printf "mkdir: missing operand\nTry 'mkdir --help' for more information." | assert_output
}

@test "when name is '' then show error message" {
   # act
   run mkdir ""

   # assert
#    assert_output 'mkdir: cannot create directory ‘’: No such file or directory'
   assert [ "${output}" == 'mkdir: cannot create directory ‘’: No such file or directory' ]
}

@test "when no directory name is provided then exit status should be 1" {
   # act
   run mkdir ""

   # assert
   assert_failure
}

