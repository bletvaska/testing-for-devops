#!/usr/bin/env bats

load '/tools/libs/bats-support/load'
load '/tools/libs/bats-assert/load'
source "${LIBS}/http.bash"


function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"

    # create a new entry
    local response=$(http --pretty=none --print=hb "${URL}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}" \
        title="Indiana Jones 5" \
        year:=2023 \
        genres:='["Adventure", "Action"]'
    )

    # extract http status code from first line
    export http_status=$(get_http_status "${response}")

    # extract header
    export response_headers=$(get_headers_as_json "${response}")

    # extract body
    export response_body=$(get_body "${response}")

    export response_headers_as_json=$(get_headers_as_json "${response}" )
}


function teardown_file() {
    # get object_id of movie to delete
    local object_id=$(jq --raw-output .objectId <<< "${response_body}")

    # remove created movie
    http delete "${URL}${object_id}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}


@test "if movie was created, then http status code is 201" {
    assert_equal "${http_status}" 201
}


@test "if movie was created, then key objectId should be in response json" {
    run jq --exit-status 'has("objectId")' <<< "${response_body}"
    assert_equal "${status}" 0
}


@test "if movie was created, then key createdAt should be in response json" {
    run jq --exit-status 'has("createdAt")' <<< "${response_body}"
    assert_equal "${status}" 0
}


@test "if movie was created, then number of keys in response JSON is 2" {
    local len=$(jq length <<< "${response_body}")
    assert_equal "${len}" 2
}


@test "if movie was created, then response content type should be json" {
    local content_type=$(jq --raw-output '."Content-Type"' <<< "${response_headers_as_json}")

    assert_equal "${content_type}" "application/json; charset=utf-8"
}
