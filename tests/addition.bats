#!/usr/bin/env bats

load "/home/ubuntu/libs/bats-support/load.bash"
load "/home/ubuntu/libs/bats-assert/load.bash"

function setup(){
    printf ">> setup()\n" >> /tmp/log
}

function teardown(){
    printf ">> teardown()\n" >> /tmp/log
}

function setup_file(){
    printf ">> setup_file()\n" >> /tmp/log
}

function teardown_file(){
    printf ">> teardown_file()\n" >> /tmp/log
}

@test "WIP: addition using bc" {
    printf ">> test bc\n" >> /tmp/log
  result="$(echo 2+2 | bc)"
  assert_equal "${result}" 5
}

@test "addition using dc" {
    printf ">> test dc\n" >> /tmp/log
  result="$(echo 2 2+p | dc)"
  [[ $result == 4 ]]
}
