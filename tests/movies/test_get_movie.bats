#!/usr/bin/env bats

load "${LIBS}/bats-support/load"
load "${LIBS}/bats-assert/load"
source "${LIBS}/http.bash"


function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"

    # create a new entry
    # FIXME where is post?
    local response=$(http --pretty=none --print=hb "${URL}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}" \
        title="Indiana Jones 5" \
        year:=2023 \
        genres:='["Adventure", "Action"]'
    )

    # get created objectId
    local body=$(get_body "${response}")
    export object_id=$(jq --raw-output .objectId <<< "${body}")

    # get movie by objectId
    response=$(http --pretty=none --print=hb "${URL}/${object_id}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
    )

    # extract http status code from first line
    export http_status=$(get_http_status "${response}")

    # extract headers
    export response_headers=$(get_headers "${response}")
    export response_headers_as_json=$(get_headers_as_json "${response}" )

    # extract body
    export response_body=$(get_body "${response}")
}


function teardown_file() {
    # remove created movie
    http delete "${URL}${object_id}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}


@test "if movie was retrieved successfully, then http status code should be 200" {
    assert_equal "${http_status}" 200
}


@test "WIP: if movie was retrieved, then it should contain specific keys in json" {
    run jq --exit-status 'has("createdAt") and has("objectId") and has("title")' <<< "${response_body}"
    assert_equal "${status}" 0
}


@test "testing" {
#     printf "${http_status}\n"
#     printf "${object_id}\n"
#     printf "${response_headers}\n"
#     printf "${response_headers_as_json}\n"
    printf "${response_body}\n"

    assert false
}
