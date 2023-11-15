#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load
load libs/http.bash


@test "when no credentials are provided then status code is 401" {
    http_query get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE
    # echo $http_status_code
    # echo $http_headers
    # echo $http_body
    assert_equal "${http_status_code}" 402
}


@test "when no credentials are provided then expect error message" {
    run http https://parseapi.back4app.com/classes/movies/u9wuoyMaqE
    assert_output '{"error":"unauthorized"}'
}
