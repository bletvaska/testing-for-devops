#!/usr/bin/env bats

set -o errexit
set -o pipefail
set -o nounset

# load modules
load "${LIBS}/bats-support/load"
load "${LIBS}/bats-assert/load"
source "${LIBS}/http.bash"

# globals
readonly url="${BASE_URL}/classes/movies/"


function setup_file() {
    # create a new entry
    local response=$(http --pretty=none --print=hb post "${url}" \
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
    response=$(http --pretty=none --print=hb "${url}/${object_id}" \
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
    http delete "${url}${object_id}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}


@test "if movie was retrieved successfully, then http status code should be 200" {
    assert_equal "${http_status}" 200
}


@test "if movie was retrieved, then it should contain specific keys in json" {
    run jq --exit-status 'has("createdAt") and has("objectId") and has("title")' <<< "${response_body}"
    assert_equal "${status}" 0
}


@test "when movie was retrieved, expect content type json" {
    local content_type=$(jq --raw-output '."Content-Type"' <<< "${response_headers_as_json}")
    assert [[ "${content_type}" =~ "application/json" ]]
}


@test "if movie was retrieved, then it should match json schema" {
    run jsonschema tests/movies/movie.schema.json <<< "${response_body}"
    assert_equal "${status}" 0
}
