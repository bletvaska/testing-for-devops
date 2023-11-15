#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load


# fixtures
function setup(){
    folder=$(mktemp --directory --dry-run)
}


function teardown(){
    if [ -d "${folder}" ]; then
        rmdir "${folder}"
    fi
}


# tests
@test "if the mkdir is invoked with valid name then exit status is 0" {
    # arrange
    # local folder=$(mktemp --directory --dry-run)

    # act
    run mkdir "${folder}"

    # assert
    assert_success

    # cleanup
    # rmdir "${folder}"
}

@test "if the mkdir is invoked with valid name then the directory exists" {
    # arrange
    # local folder=$(mktemp --directory --dry-run)

    # act
    run mkdir "${folder}"

    # assert
    assert [ -d "${folder}" ]

    # cleanup
    # rmdir "${folder}"
}

@test "if the directory already exists then exit status is 1" {
    run mkdir $(pwd)
    assert_failure
}

@test "if the directory already exists then show error message" {
    run mkdir .
    assert_output "mkdir: cannot create directory ‘.’: File exists"
}

@test "if we have not permissions to create the dir then exit status is X" {
    run mkdir /usr/bin/my_dir
    assert_failure
}


@test "if we have not permissions to create the dir then error message will be shown" {
    run mkdir /usr/bin/my_dir
    assert_output "mkdir: cannot create directory ‘/usr/bin/my_dir’: Permission denied"
}


@test "if the mkdir is invoked without the name of the directory then exit status is 1" {
    run mkdir
    assert_failure
}


@test "if the mkdir is invoked with the unknown option then exit status is 1" {
    run mkdir --the-unknown-option /tmp/foo
    assert_failure
}

@test "if the mkdir is invoked without the name of the directory then" {
   run mkdir
   assert_output "mkdir: missing operand
Try 'mkdir --help' for more information."
}
