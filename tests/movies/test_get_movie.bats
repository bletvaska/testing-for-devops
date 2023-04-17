#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"

source "${LIBS}/http.bash"

readonly BASE_URL="https://parseapi.back4app.com"
readonly APP_ID="axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ"
readonly REST_API_KEY="sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"


@test "when movie was successfully retrieved then http status code is 200" {
    http_query get \
        "${BASE_URL}/classes/movies/u9wuoyMaqE" \
        "X-Parse-Application-Id:${APP_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
    
    http_status_code=$(get_http_status "${response}")

    assert_equal "${http_status_code}" 200
}

@test "when no tokens have been provided then expect 401" {
    http_query get "${BASE_URL}/classes/movies/u9wuoyMaqE"

    assert_equal "${http_status_code}" 401
}


@test "when only App Id is provided then http status code is 403" {
    http_query get \
        "${BASE_URL}/classes/movies/u9wuoyMaqE" \
        "X-Parse-Application-Id:${APP_ID}"

    assert_equal "${http_status_code}" 403
}


@test "when only REST API key is provided then http status code is 401" {
    http_query get \
        "${BASE_URL}/classes/movies/u9wuoyMaqE" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"

    assert_equal "${http_status_code}" 401
}
