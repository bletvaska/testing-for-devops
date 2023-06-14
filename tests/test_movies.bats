#!/usr/bin/env bats

# globals
source local.env

# bats libraries
load "${LIBS}/bats-assert/load.bash"
load "${LIBS}/bats-support/load.bash"
load "${LIBS}/http.bash"


@test "when existing movie is retrieved then http status is 200" {
    url="${BASE_URL}/classes/movies/u9wuoyMaqE"

    http_query GET "${url}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}" \
        "X-Parse-Application-Id:${APP_ID}"

    assert_equal "${http_status_code}" 200
}