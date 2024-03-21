#!/usr/bin/env bats

load libs/bats-support/load
load libs/bats-assert/load

function setup(){
    echo "setup(${BATS_TEST_NAME})" >> /tmp/test.log
}

function teardown(){
    echo "teardown(${BATS_TEST_NAME})" >> /tmp/test.log
}


function setup_file(){
    rm /tmp/test.log
    echo "setup_file(${BATS_TEST_FILENAME})" >> /tmp/test.log
}


function teardown_file(){
    echo "teardown_file(${BATS_TEST_FILENAME})" >> /tmp/test.log
}

# setup()
@test "if executed without name of folder then error message should appear" {
    run mkdir
    assert_output --partial "mkdir: missing operand"
}
# teardown()

# setup()
@test "if executed without name of folder then exit status is 1" {
    run mkdir
    assert_failure
}
# teardown()

# setup()
@test "if user can't create directory in root folder then exit status is 1" {
    run mkdir /test
    assert_failure
}
# teardown()

# setup()
@test "if user can't create directory in root folder then error message should appear" {
    run mkdir /test
    assert_output "mkdir: cannot create directory ‘/test’: Permission denied"
}
# teardown()
