#!/usr/bin/env bats

@test "addition using bc" {
  result=$(echo 2+2 | bc)
  [[ $result == 4 ]]
}


@test "WIP: addition using dc" {
  result=$(echo 2 2+p | dc)
  [[ $result == 4 ]]
}


@test "if cat is invoked with a nonexistent file then expect an error message" {
    run cat xfile
    [[ ${output} == "cat: xfile: No such file or directory" ]]
}

