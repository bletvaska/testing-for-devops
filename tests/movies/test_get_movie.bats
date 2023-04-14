#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"


function get_http_status() {
    local response="${1:?Response object not set.}"
    
    local array=(${response})
    printf "${array[1]}"
}


@test "when movie was successfully retrieved then http status code is 200" {
    response=$(http --header https://parseapi.back4app.com/classes/movies/u9wuoyMaqE   X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ   X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk)
    
    http_status_code=$(get_http_status "${response}")

    assert_equal "${http_status_code}" 200
}

@test "when no tokens have been provided then expect 401 " {
    response=$(http --header https://parseapi.back4app.com/classes/movies/u9wuoyMaqE)

    http_status_code=$(get_http_status "${response}")

    assert_equal "${http_status_code}" 401
}


@test "when only App Id is provided then http status code is 403" {
    response=$(http --header https://parseapi.back4app.com/classes/movies/u9wuoyMaqE   X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ)

    http_status_code=$(get_http_status "${response}")

    assert_equal "${http_status_code}" 403
}


@test "when only REST API key is provided then http status code is 401" {
    response=$(http --header https://parseapi.back4app.com/classes/movies/u9wuoyMaqE X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk)

    http_status_code=$(get_http_status "${response}")

    assert_equal "${http_status_code}" 401
}
