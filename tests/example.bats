#!/usr/bin/env bats

@test "addition using bc" {
  result="$(echo 2+2 | bc)"
  [[ $result == 4 ]]
}

@test "addition using dc" {
  result="$(echo 2 2+p | dc)"
  [[ $result == 4 ]]
}

