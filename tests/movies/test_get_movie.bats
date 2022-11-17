#!/usr/bin/env bats

load "${LIBS}/bats-support/load"
load "${LIBS}/bats-assert/load"
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

    # extract headers
    export response_headers=$(get_headers_as_json "${response}")
    export response_headers_as_json=$(get_headers_as_json "${response}" )

    # extract body
    export response_body=$(get_body "${response}")
}


function teardown_file() {
    # get object_id of movie to delete
    local object_id=$(jq --raw-output .objectId <<< "${response_body}")

    # remove created movie
    http delete "${URL}${object_id}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}
