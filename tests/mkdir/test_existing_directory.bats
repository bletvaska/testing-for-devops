#!/usr/bin/env bats

set -o errexit
set -o pipefail
set -o nounset

# load modules
load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'

@test 'mkdir exists' {
    run which mkdir
    assert_equal "${status}" 0
}


@test "when new folder with existing name is going to be created, the error message is shown" {
    run mkdir "${PWD}"
    assert [[ "${output}" == "mkdir: can't create directory '${PWD}': File exists" ]]
}


@test "when new folder with existing name is going to be created, the exit status should be 1" {
    # act
    run mkdir "${PWD}"

    # assert
    assert [[ "${status}" == 1 ]]
}
