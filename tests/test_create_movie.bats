#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load
load libs/http.bash

# global variables
# readonly MOVIE='{ "title":"Killer", "year":2023, "genres":["Action","Adventure"] }'


# create a new movie
# when new movie was created then http status code is 201
# when new movie was created then content contains XXX
# when new movie was created then content of response will be json
# remove created movie

function setup_file() {
  http_query post "${BASE_URL}/classes/movies/" \
    X-Parse-Application-Id:"${APP_ID}" \
    X-Parse-REST-API-Key:"${REST_API_KEY}" \
    title="Killer" \
    year:=2023 \
    genres:='["Action", "Adventure"]'

  object_id=$(jq --raw-output .objectId <<< "${output}")
  readonly object_id
}


@test "when new movie was created then http status code is 201" {
  assert_http_status_code 201
}


@test "when new movie was created then content of response will be json" {
  assert_http_header "Content-Type" "application/json; charset=utf-8"
}


function teardown_file() {
  http_query delete "${BASE_URL}/classes/movies/${object_id}" \
    X-Parse-Application-Id:"${APP_ID}" \
    X-Parse-REST-API-Key:"${REST_API_KEY}"
}
