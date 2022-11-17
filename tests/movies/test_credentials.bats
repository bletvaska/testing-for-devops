#!/usr/bin/env bats

set -o errexit
set -o pipefail
set -o nounset

# load modules
load "${LIBS}/bats-support/load"
load "${LIBS}/bats-assert/load"
source "${LIBS}/http.bash"

readonly url="${BASE_URL}/classes/movies/"


@test "WIP failure" {
    echo "${BASH_SOURCE}"
    assert false
}

@test "when no token is provided then expect error message" {
    # act
    run http --pretty=none --body --json "${url}"

    # assert
    assert [[ "${output}" == '{"error":"unauthorized"}' ]]
}


@test "when no token is provided then expect http status code 401" {
    # act
    run http --pretty=none --headers --json "${url}"

    # extract http status code from first line
    local http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 401
}


@test "when only ID application is provided then expect http status code 403" {
    # act
    run http --pretty=none --headers --json "${url}" \
        X-Parse-Application-Id:"${APPLICATION_ID}"

    # extract http status code from first line
    local http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 403
}


@test "when only rest api is provided then expect http status code 401" {
    # act
    run http --pretty=none --headers --json "${url}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"

    # extract http status code from first line
    local http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 401
}


@test "when rest api and application id are provided but wrong then expect http status code 401" {
    # act
    run http --pretty=none --headers --json "${url}" \
        X-Parse-Application-Id:"${REST_API_KEY}" \
        X-Parse-REST-API-Key:"${APPLICATION_ID}"

    # extract http status code from first line
    local http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 401
}


@test "when rest api and application id are provided then expect http status code 200" {
    # act
    run http --pretty=none --headers --json "${url}" \
        X-Parse-Application-Id:"${APPLICATION_ID}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"

    # extract http status code from first line
    local http_status=$(get_http_status "${output}")

    # assert
    assert_equal "${http_status}" 200
}




# ak zadam len app id, tak http status kod je 403 a error message

# ak zadam len rest api key, tak http status kod je 401 a error message
# ak zadam oba kluce ale zle, tak http staus kod 401 a error message
# ak zadam validne oba kluce, tak http status kod 200 a dostanem film
