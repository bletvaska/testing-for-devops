#!/usr/bin/env bats

# load modules
load "../libs/bats-support/load.bash"
load "../libs/bats-assert/load.bash"
load "../libs/http.bash"

# globals


# fixtures
function setup_file() {
  http_get "${BASE_URL:-localhost}/classes/movies/u9wuoyMaqE" \
    X-Parse-Application-Id:"${APPLICATION_ID:-none}" \
    X-Parse-REST-API-Key:"${REST_API_KEY:-none}"
}


@test "when the movie is retrieved, then status code is 200" {
  assert_http_status_code 200
}


@test "when the movie is retrieved, then content type will by application/json" {
    assert_http_header "Content-Type" "application/json; charset=utf-8"
}
