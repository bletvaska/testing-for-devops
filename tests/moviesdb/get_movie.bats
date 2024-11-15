#!/usr/bin/env bats

# load modules
load "../libs/bats-support/load.bash"
load "../libs/bats-assert/load.bash"
load "../libs/http.bash"


# globals
readonly MOVIE_ID=u9wuoyMaqE

# fixtures
function setup_file() {
  http_get "${BASE_URL:-localhost}/classes/movies/${MOVIE_ID}" \
    X-Parse-Application-Id:"${APPLICATION_ID:-none}" \
    X-Parse-REST-API-Key:"${REST_API_KEY:-none}"
}


@test "when the movie is retrieved, then status code is 200" {
  assert_http_status_code 200
}


@test "when the movie is retrieved, then content type will by application/json" {
  assert_http_header "Content-Type" "application/json; charset=utf-8"
}


@test "when the movie is retrieved, then it's content should container key objectId" {
  run jq --exit-status  'has("objectId")' <<< "${output}"
  assert_success
}


@test "when the movie is retrieved, then it's content should container key createdAt" {
  run jq --exit-status  'has("createdAt")' <<< "${output}"
  assert_success
}


@test "when movie is retrieved, then it should match json schema" {
  run jsonschema "${BATS_TEST_DIRNAME}/movie.schema.json" --instance <(printf "%s\n" "${output}")
  assert_success
}
