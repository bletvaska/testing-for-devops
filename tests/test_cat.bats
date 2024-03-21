#!/usr/bin/env bats

load libs/bats-support/load
load libs/bats-assert/load

# global variable
readonly CMD=/usr/bin/cat

@test "if file doesn't exist then show error message" {
    local file=$(mktemp --dry-run)
    run "${CMD}" "${file}"
    assert_output "${CMD}: ${file}: No such file or directory"
}


@test "if file doesn't exist then exit status will be 1" {
    local file=$(mktemp --dry-run)
    run "${CMD}" /asdf
    assert_failure
}


@test "if there are insufficient permissions then show error message" {
    local file="/root$(mktemp --dry-run)"
    run "${CMD}" "${file}"
    assert_output "${CMD}: ${file}: Permission denied"
}


@test "if there are insufficient permissions then exit status will be 1" {
    local file="/root$(mktemp --dry-run)"
    run "${CMD}" "${file}"
    assert_failure
}


@test "if invalid option provided then exit status will be 1" {
    local option="--invalid-option"
    run "${CMD}" "${option}"
    assert_failure
}


@test "if invalid option provided then show error message" {
    local option="--invalid-option"
    run "${CMD}" "${option}"
    assert_output --partial "${CMD}: unrecognized option '${option}'"
}


# 1. write independet tests
# 2. one test should test one thing only
# 3. in one test use one assert
