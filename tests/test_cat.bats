#!/usr/bin/env bats

load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"


@test "if cat is invoked with a nonexistent file then prints an error" {
  run cat xfile
  [[ ${output} == "cat: can't open 'xfile': No such file or directory" ]]
}


@test "if cat is invoked with a nonexistent file then exit status will be 1" {
    run cat xfile
    [[ $status == 1 ]]
}


# if cat is invoked correctly the exit status will be 0

