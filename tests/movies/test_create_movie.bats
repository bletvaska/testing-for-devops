#!/usr/bin/env bats

load "/tools/libs/bats-support/load.bash"
load "/tools/libs/bats-assert/load.bash"

readonly ENV_FILE="tests/movies/.env"

function setup_file(){
    # if .env file is missing, then exit
    [[ -f "${ENV_FILE}" ]] || {
        echo "Error: Missing .env file." >&2
        exit 1
    }

    # source .env file
    source "${ENV_FILE}"

    # create a movie
    local response=$(curl -X POST \
        -w " %{http_code}" \
        -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
        -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
        -H "Content-Type: application/json" \
        --data @movie.json \
        "${BASE_URL}")
    echo "${response}" > log
}


@test "if movie was created successfully, the status code should be 201" {
    echo "hello"
}


function teardown_file(){
    # delete movie from db
    echo "world"

}

