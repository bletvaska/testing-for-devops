#!/usr/bin/env bats

load "/home/ubuntu/libs/bats-support/load.bash"
load "/home/ubuntu/libs/bats-assert/load.bash"

function setup(){
    readonly TEST_FOLDER=$(mktemp --dry-run --directory)
    mkdir "${TEST_FOLDER}"
    readonly EXIT_STATUS=$?
}

function teardown(){
    rmdir "${TEST_FOLDER}"
}

@test "when invoked with folder name then folder exists" {
    assert [ -d "${TEST_FOLDER}" ]
}

@test "when invoked with folder name then exit status is 0" {
    assert_equal "${EXIT_STATUS}" 0
}

@test "when trying to create directory which exists, then status is 1" {
    run mkdir "${TEST_FOLDER}"  # $PWD
    assert_failure
}

@test "when trying to create directory which exists, then error message is shown" {
    run mkdir "${TEST_FOLDER}"  # $PWD
    assert_output "mkdir: cannot create directory ‘${TEST_FOLDER}’: File exists"
}

