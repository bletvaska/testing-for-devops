#!/usr/bin/env bats

load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"


log(){
    echo ">> ${1}" >> /tmp/report
}

setup() {
    log 'setup()'
}

teardown() {
    log 'teardown()'
}

setup_file() {
    log 'setup_file()'
}

teardown_file() {
    log 'teardown_file()'
}


@test "addition using bc" {
  result="$(echo 2+2 | bc)"
  assert [[ $result == 5 ]]
}

@test "addition using dc" {
  result="$(echo 2 2+p | dc)"
  assert [[ $result == 4 ]]
}

@test "if then " {
}

