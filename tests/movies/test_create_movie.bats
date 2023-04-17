#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"

source "${LIBS}/http.bash"

readonly BASE_URL="https://parseapi.back4app.com"
readonly APP_ID="axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ"
readonly REST_API_KEY="sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"


function setup_file() {
    http_query post \
        "${BASE_URL}/classes/movies/" \
        "X-Parse-Application-Id:${APP_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}" \
        "Content-Type:application/json" \
        title="Tetris" \
        year:=2023 \
        genres:='["Biography", "Drama", "History"]' 
}


function teardown_file() {
    object_id=$(jq --raw-output .objectId <<< "${http_body}")

    http_query delete \
        "${BASE_URL}/classes/movies/${object_id}" \
        "X-Parse-Application-Id:${APP_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}


@test "when movie is created then http status code is 201" {
    assert_equal "${http_status_code}" 201
}


@test "when movie is created then objectId will be set" {
    object_id=$(jq --raw-output .objectId <<< "${http_body}")

    assert [ -n "${object_id}" ]
}

@test "when movie is created then conte-type is application/json" {
    content_type=$(jq --raw-output '."Content-Type"' <<< "${http_headers}")
    assert_equal "${content_type}" "application/json; charset=utf-8"
}
