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


@test "when no credentials are provided then expect error message" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when no parse app id is provided then status code is 401" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk
    assert_equal "${http_status_code}" 401
}


@test "when no parse app id is provided then expect error message" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when no rest api key provided then status code is 403" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ
    assert_equal "${http_status_code}" 403
}


@test "when no rest api key provided then expect error message" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when invalid keys are provided then status code is 401" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlXXXJ \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk
    assert_equal "${http_status_code}" 401
}


@test "when invalid keys are provided then expect error message" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlXXX \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk
    assert_equal "${http_body}" '{"error":"unauthorized"}'
}


@test "when valid credentials are provided then status code is 200" {
    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk
    assert_equal "${http_status_code}" 200
}


@test "when valid credentials are provided then response is json object" {
    expected='{"objectId":"u9wuoyMaqE","title":"Dune","year":2021,"genres":["Sci-Fi","Adventure","Drama","Action"],"createdAt":"2021-11-04T13:59:15.547Z","updatedAt":"2022-11-17T06:53:40.640Z"}'

    http_get https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk
    assert_equal "${http_body}" "${expected}"

}
