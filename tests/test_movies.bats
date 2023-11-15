#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load
load libs/http.bash


@test "when no credentials are provided then status code is 401" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE
    assert_equal "${http_status_code}" 401
}


@test "WIP: when no credentials are provided then expect error message" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}
