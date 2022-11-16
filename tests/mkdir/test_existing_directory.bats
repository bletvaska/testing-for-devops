#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'

@test 'mkdir exists' {
    run which mkdir
    assert [[ ${status} == 0 ]]
    # assert_equal "${status}" 1
}



@test "when new folder with existing name is going to be created, the error message is shown" {
    run mkdir "${PWD}"
    assert [[ "${output}" == "mkdir: can't create directory '${PWD}': File exists" ]]
}


@test "when new folder with existing name is going to be created, the exit status should be 1" {
    # arrange

    # act
    run mkdir "${PWD}"

    # assert
    assert [[ "${status}" == 1 ]]
}

