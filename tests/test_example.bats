#!/usr/bin/env bats

@test "addition using bc" {
    result=$(bc <<<"2+2")
    [[ $result == 4 ]]
}

@test "addition using dc" {
    result=$(dc <<<"2 2+p")
    [[ $result == 4 ]]
}
