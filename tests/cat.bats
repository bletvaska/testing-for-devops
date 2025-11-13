#!/usr/bin/env bats


# load modules/libraries
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

# globals
readonly CMD=/usr/bin/cat

# if the command will be executed with non existent file, then exit code will be 1
@test "first test" {
    run cat file.doesnt.exist
    assert [ "${status}" -eq 1 ]
}
