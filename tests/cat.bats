#!/usr/bin/env bats

# load modules
load 'libs/bats-support/load.bash'
load 'libs/bats-assert/load.bash'

# globals
readonly CMD=/usr/bin/cat

@test "If there are insufficient permissions for file then show error message." {
    run "${CMD}" /etc/shadow
    assert_output "${CMD}: /etc/shadow: Permission denied"
}


@test "If there are insufficient permissions for file then exit status is 1." {
    run "${CMD}" /etc/shadow
    assert_failure
}


@test "If invalid option is provided then exit status is 1." {
    run "${CMD}" --invalid-option
    assert_failure
}


@test "If invalid option is provided then show error message." {
    local option='--invalid-option'
    run "${CMD}" "${option}"
    assert_line --index 0 "${CMD}: unrecognized option '${option}'"
}