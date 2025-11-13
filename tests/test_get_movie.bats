#!/usr/bin/env bats

if [[ -f "${BATS_TEST_DIRNAME}/movies.env" ]]; then
   source "${BATS_TEST_DIRNAME}/movies.env"
fi

# load modules/libraries
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"
load "libs/http.bash"

# globals
readonly MOVIE_ID="u9wuoyMaqE"

# aliases
alias hurl="docker container run --rm -it --volume .:/data --workdir /data ghcr.io/orange-opensource/hurl:latest"


function setup_file() {
    http_get "${BASE_URL}/movies/${MOVIE_ID}" \
        X-Parse-Application-Id:"${APP_ID}" \
        X-Parse-REST-API-Key:"${REST_API_KEY}"
}


@test "when movie is retrieved then the HTTP status code will be 200" {
    assert_http_status_code 200
}


@test "when movie is retrieved then the content type of response will be json" {
    assert_http_header "Content-Type" "application/json; charset=utf-8"    
}


@test "when movie is retrieved, the it's content should contain specific structure" {
    run jq --exit-status 'has("objectId")' <<< "${output}"
    assert_success
}


@test "run hurl" {
    # arrange
    cd "${BATS_TEST_DIRNAME}"

    # act
    docker container run --rm -it --volume .:/data --workdir /data ghcr.io/orange-opensource/hurl:latest --test --variables-file movies.env  get_movie.hurl

    # assert
    assert_success
}
