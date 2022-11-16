#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'
source "${LIBS}/http.bash"


function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"
}


# ak nezadam ziadny token, tak http status kod je 401 a error message
@test "when no token is provided then expect error message" {
    # act
    run http --pretty=none --body --json "${URL}"

    # assert
    assert [[ "${output}" == '{"error":"unauthorized"}' ]]
}


@test "when no token is provided then expect http status code 401" {
    # act
    run http --pretty=none --headers --json "${URL}"

    # extract http status code from first line
    http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 401
}


# ak zadam len app id, tak http status kod je 403 a error message
@test "when only ID application is provided then expect http status code 403" {
    # act
    run http --pretty=none --headers --json "${URL}" \
        X-Parse-Application-Id:"${APPLICATION_ID}"

    # extract http status code from first line
    http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 403
}


# ak zadam len rest api key, tak http status kod je 401 a error message
@test "when only rest api is provided then expect http status code 401" {
    # act
    run http --pretty=none --headers --json "${URL}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"

    # extract http status code from first line
    http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 401
}

# ak zadam oba kluce ale zle, tak http staus kod 401 a error message
@test "when rest api and application id are provided but wrong then expect http status code 401" {
    # act
    run http --pretty=none --headers --json "${URL}" \
        X-Parse-Application-Id:"${REST_API_KEY}" \
        X-Parse-REST-API-Key:"${APPLICATION_ID}"

    # extract http status code from first line
    http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 401
}


# ak zadam validne oba kluce, tak http status kod 200 a dostanem film
@test "when rest api and application id are provided then expect http status code 200" {
    # act
    run http --pretty=none --headers --json "${URL}" \
        X-Parse-Application-Id:"${APPLICATION_ID}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"

    # extract http status code from first line
    http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 200
}




# ak zadam len app id, tak http status kod je 403 a error message

# ak zadam len rest api key, tak http status kod je 401 a error message
# ak zadam oba kluce ale zle, tak http staus kod 401 a error message
# ak zadam validne oba kluce, tak http status kod 200 a dostanem film
