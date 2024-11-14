#!/usr/bin/env bats

# load modules
load "../libs/bats-support/load.bash"
load "../libs/bats-assert/load.bash"
load "../libs/http.bash"

# globals
@test "when the movie is retrieved, then status code is 200" {
  http_get "https://parseapi.back4app.com/classes/movies/u9wuoyMaqE" \
    X-Parse-Application-Id:"axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ" \
    X-Parse-REST-API-Key:"sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"

    assert_http_status_code 200
}


@test "when the movie is retrieved, then content type will by application/json" {
  http_get "https://parseapi.back4app.com/classes/movies/u9wuoyMaqE" \
    X-Parse-Application-Id:"axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ" \
    X-Parse-REST-API-Key:"sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"

    assert_http_header "Content-Type" "application/json; charset=utf-8"
}
