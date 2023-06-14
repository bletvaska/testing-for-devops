#!/usr/bin/env bats

readonly LIBS="/home/ubuntu/testing-for-devops/libs"

# bats libraries
load "${LIBS}/bats-assert/load.bash"
load "${LIBS}/bats-support/load.bash"
source "${LIBS}/http.bash"

# globals
readonly BASE_URL="https://parseapi.back4app.com"
readonly APP_ID="axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ"
readonly REST_API_KEY="sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk"

@test "when existing movie is retrieved then http status is 200" {
    url="${BASE_URL}/classes/movies/u9wuoyMaqE"

    http_query GET "${url}" \
        "X-Parse-Application-Id:${APP_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}"

    assert_equal "${http_status_code}" 200
}