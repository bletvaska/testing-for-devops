#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'

function setup_file() {
    # load env file
    # set -a
    # source local.env
    # set +a

    # set local test variables
    export URL="${BASE_URL}/classess/movies/"
}


#function teardown_file() {
    # unset URL
#}


# ak nezadam ziadny token, tak http status kod je 401 a error message
@test "when no token is provided then expect error message" {
    # act
    run http --pretty=none --body "${URL}"

    # assert
    assert [[ "${output}" == '{"error":"unauthorized"}' ]]
}


@test "when no token is provided then expect http status code 401" {
    # act
    run http --pretty=none --headers "${URL}"
    # status=$( echo "${lines[0]}" | cut -f2 -d" " )
    line=(${lines[0]})
    status="${line[1]}"

    # assert
    # assert [[ "${status}" == 401 ]]
    assert_equal "${status}" 401
    # assert_equal "${lines[0]}" "HTTP/1.1 401 Unauthorized"
}


# ak zadam len app id, tak http status kod je 403 a error message
# ak zadam len rest api key, tak http status kod je 401 a error message
# ak zadam oba kluce ale zle, tak http staus kod 401 a error message
# ak zadam validne oba kluce, tak http status kod 200 a dostanem film
