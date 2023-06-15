#!/usr/bin/env bats

# globals
source local.env
readonly MOVIE_ID=xfZlYgGtSR

# bats libraries
load "${LIBS}/bats-assert/load.bash"
load "${LIBS}/bats-support/load.bash"
load "${LIBS}/http.bash"


# get the specific movie ONCE
function setup_file() {
    local url="${BASE_URL}/classes/movies/${MOVIE_ID}"

    http_query GET "${url}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}" \
        "X-Parse-Application-Id:${APP_ID}"
}


@test "when movie was downloaded expect status ok" {
    assert_equal "${http_status_code}" 200
}


@test "when movie was downloaded expect content type json" {
    local content_type=$(jq --raw-output '."Content-Type"' <<< "${http_headers}")
    [[ "${content_type}" =~ ^application/json ]]
}


@test "when movie was downloaded expect specific keys in movie json" {
    run jq --exit-status '
        has("objectId") 
        and has("title") 
        and has("year") 
        and has("genres") 
        and has("createdAt") 
        and has("updatedAt")
        ' <<< "${http_body}"
    assert_success
}
