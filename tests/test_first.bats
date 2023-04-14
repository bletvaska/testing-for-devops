#!/usr/bin/env bats

load libs/bats-support/load.bash
load libs/bats-assert/load.bash

function setup_file(){
    printf "Setup file...\n" >> /tmp/process
}

function teardown_file(){
    printf "Teardown file...\n" >> /tmp/process
}

function setup(){
    printf "Setup...\n" >> /tmp/process
}

function teardown(){
    printf "Teardown...\n" >> /tmp/process
}

# setup()
@test "when input is 2+3 then output is 5" {
    result=$(echo "2+3" | bc)
    assert [ "${result}" == 6 ]
}
# teardown()

# setup()
@test "when cat is invoked with missing file then error message should apper" {
    run cat invalid_file
    assert_output 'cat: invalid_file: No such file or directory'
}
# teardown()

# setup()
@test "when cat is invoked with missing file then exit status is 1" {
    run cat invalid_file
    assert [ "${status}" == 1 ]
}
# teardown()
