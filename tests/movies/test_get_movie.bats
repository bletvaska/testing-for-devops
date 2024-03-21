#!/usr/bin/env bats

# load modules
load ../libs/bats-support/load
load ../libs/bats-assert/load
load ../libs/http.bash


# global variables
readonly MOVIE_ID="QMZ5f7GuXk"


function setup_file() {
    http_get "https://${BASE_URL}/classes/movies/${MOVIE_ID}" \
        "X-Parse-Application-Id:${APPID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"
}


@test "when movie is retrieved, then it's content type is json" {
    assert_http_header "Content-Type" "application/json; charset=utf-8"
}


@test "when movie is retrieved, then http status is 200" {
    assert_http_status_code 200
}


@test "when movie is retrieved, then it's content will be of specific structure" {
    skip "@stano will do it"
}
