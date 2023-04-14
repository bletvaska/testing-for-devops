#!/usr/bin/env bats

# set -o nounset

load ../libs/bats-support/load.bash
load ../libs/bats-assert/load.bash


@test "when no directory name is provided then show error message" {
    # act
    run mkdir

    # assert
    printf "mkdir: missing operand\nTry 'mkdir --help' for more information." | assert_output
}

@test "when no directory name is provided then exit status should be 1" {
    # act
    run mkdir

    # assert
    assert_failure
}


@test "when name is '' then show error message" {
   # act
   run mkdir ""

   # assert
   assert_output 'mkdir: cannot create directory ‘’: No such file or directory'
}


@test "when directory name is empty then exit status should be 1" {
   # act
   run mkdir ""

   # assert
   assert_failure
}

@test "when dir already exists then error message should appear" {
    # act
    run mkdir .

    # assert
    assert_output "mkdir: cannot create directory ‘.’: File exists"
}