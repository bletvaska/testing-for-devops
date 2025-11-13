#!/usr/bin/env bats


# load modules/libraries
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"
load "libs/http.bash"


@test "when movie is retrieved then the HTTP status code will be 200" {
    http_get "https://parseapi.back4app.com/classes/movies/u9wuoyMaqE" \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk

    assert_http_status_code 200
}


@test "when movie is retrieved then the content type of response will be json" {
    http_get "https://parseapi.back4app.com/classes/movies/u9wuoyMaqE" \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk

    assert_http_header "Content-Type" "application/json; charset=utf-8"    
}


@test "when movie is retrieved, the it's content should contain specific structure" {
    http_get "https://parseapi.back4app.com/classes/movies/u9wuoyMaqE" \
        X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
        X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk

    run jq --exit-status 'has("objectId")' <<< "${output}"
    assert_success
}