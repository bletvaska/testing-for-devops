#!/usr/bin/env bats

@test "WIP: addition using bc" {
  run bc <<< "2+2"
  [[ ${output} == 4 ]]
}

@test "addition using dc" {
  result=$(dc <<< "2 2+p")
  [[ $result == 4 ]]
}

