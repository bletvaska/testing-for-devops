#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load
load libs/http.bash

# globals
readonly MOVIE_ID='u9wuoyMaqE'


function setup_file(){
    http_get "${BASE_URL}/classes/movies/${MOVIE_ID}" \
        X-Parse-Application-Id:"${APP_ID}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"
}


@test "when movie is retrieved then content type of response will be json" {
    assert_http_header "Content-Type" "application/json; charset=utf-8"
}


@test "when movie is retrieved then http status code is 200" {
    assert_http_status_code 200
}

@test "when movie is retrieved then it's content should contain specific structure" {
    run check-jsonschema --schemafile tests/resources/movie.schema.json <(echo "${output}")
    assert_success
}
