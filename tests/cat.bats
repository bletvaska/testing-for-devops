#!/usr/bin/env bats


# load modules/libraries
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

# globals
readonly CMD=/usr/bin/cat


@test "if file doesn't exist then exit status is 1" {
    # arrange
    local file
    file=$(mktemp --dry-run)

    # act
    run "${CMD}" "${file}"

    # assert
    assert_failure
}


@test "if file doesn't exist then show error message" {
    # arrange
    local file
    file=$(mktemp --dry-run)

    # act
    run "${CMD}" "${file}"

    # assert
    assert_output "${CMD}: ${file}: No such file or directory"
}


@test "if invalid option is used then show error message" {
    # arrange
    local file
    file=$(mktemp --dry-run)
    local option="--invalid-option"

    # act
    run "${CMD}" "${option}" "${file}"

    # assert
    assert_line --index 0 "${CMD}: unrecognized option '${option}'"
}


@test "if invalid option is used then exit status is 1" {
    # arrange
    local file
    file=$(mktemp --dry-run)
    local option="--invalid-option"

    # act
    run "${CMD}" "${option}" "${file}"

    # assert
    assert_failure
}


@test "if file exists but insufficient permissions then show error message" {
    # arrange
    local file
    file=$(mktemp)
    chmod 000 "${file}"  # remove all permissions

    # act
    run "${CMD}" "${file}"

    # assert
    assert_output "${CMD}: ${file}: Permission denied"
}


@test "if file exists but insufficient permissions then status code is 1" {
    # arrange
    local file
    file=$(mktemp)
    chmod 000 "${file}"  # remove all permissions

    # act
    run "${CMD}" "${file}"

    # assert
    assert_failure
}
