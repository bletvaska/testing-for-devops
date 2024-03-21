#!/usr/bin/env bats

# load modules
load ../libs/bats-support/load
load ../libs/bats-assert/load
load ../libs/http.bash

@test "when movie is retrieved, then it's content type is json" {
    http_get "https://parseapi.back4app.com/classes/movies/QMZ5f7GuXk" \
        "X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ" \
        "X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"

    assert_http_header "Content-Type" "application/json; charset=utf-8"
}

@test "when movie is retrieved, then http status is 200" {
    http_get "https://parseapi.back4app.com/classes/movies/QMZ5f7GuXk" \
        "X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ" \
        "X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"

    assert_http_status_code 200
}

@test "when movie is retrieved, then it's content will be of specific structure" {

}
