#!/usr/bin/env bats

load '/tools/libs/bats-support/load'
load '/tools/libs/bats-assert/load'
source "${LIBS}/http.bash"


function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"

    # create a new entry
    response=$(http --pretty=none --print=hb "${URL}" \
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
}


function teardown_file() {
    # get object_id of movie to delete
    object_id=$(jq --raw-output .objectId <<< "${response_body}")

    # remove created movie
    http --pretty=none --print=hb delete "${URL}${object_id}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}


@test "when movie was created, then http status code is 201" {
    assert_equal "${http_status}" 201
}


@test "when movie was created, then key objectId should be in response json" {
    run jq --exit-status .objectId <<< "${response_body}"
    assert_equal "${status}" 0
}


@test "when movie was created, then key createdAt should be in response json" {
    run jq --exit-status .createdAt <<< "${response_body}"
    assert_equal "${status}" 0
}
