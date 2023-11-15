#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load
load libs/http.bash


@test "when no credentials are provided then status code is 401" {
    http_query get "${BASE_URL}/classes/movies/"
    assert_equal "${http_status_code}" 401
}


@test "when no credentials are provided then expect error message" {
    http_query get "${BASE_URL}/classes/movies/"
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when no parse app id is provided then status code is 401" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"
    assert_equal "${http_status_code}" 401
}


@test "when no parse app id is provided then expect error message" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "WIP when no rest api key provided then status code is 403" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-Application-Id:"${APP_ID}"
    assert_equal "${http_status_code}" 403
}


@test "when no rest api key provided then expect error message" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-Application-Id:"${APP_ID}"
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when invalid keys are provided then status code is 401" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-Application-Id:invalid \
        X-Parse-REST-API-Key:invalid
    assert_equal "${http_status_code}" 401
}


@test "when invalid keys are provided then expect error message" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-Application-Id:invalid \
        X-Parse-REST-API-Key:invalid
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when valid credentials are provided then status code is 200" {
    http_query get "${BASE_URL}/classes/movies/" \
        X-Parse-Application-Id:"${APP_ID}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"
    assert_equal "${http_status_code}" 200
}


@test "when valid credentials are provided then response is json object" {
    expected='{"objectId":"u9wuoyMaqE","title":"Dune","year":2021,"genres":["Sci-Fi","Adventure","Drama","Action"],"createdAt":"2021-11-04T13:59:15.547Z","updatedAt":"2022-11-17T06:53:40.640Z"}'

    http_query get "${BASE_URL}/classes/movies/u9wuoyMaqE" \
        X-Parse-Application-Id:"${APP_ID}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"
    assert_equal "${http_body}" "${expected}"
}
