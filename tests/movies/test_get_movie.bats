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
    set -o allexport
    source "${ENV_FILE}"
    set +o allexport

    # create a movie
    local response=$(curl -X POST \
        -w " --- %{http_code}" \
        -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
        -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
        -H "Content-Type: application/json" \
        --data @tests/movies/movie.json \
        "${BASE_URL}")

    # extracting objectId
    export OBJECT_ID=$(cut -f1 -d' --- ' <<< "${response}" | jq --raw-output .objectId)

    # get movie
    local response=$(curl -X GET \
        -w " --- %{http_code}" \
        -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
        -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
        -H "Content-Type: application/json" \
        "${BASE_URL}/${OBJECT_ID}")

    # extract data
    export RESPONSE_BODY=$(cut -f1 -d' --- ' <<< "${response}")
    export RESPONSE_STATUS_CODE=$(cut -f2 -d' --- ' <<< "${response}")
}


@test "if movie was created successfully, the status code should be 201" {
    echo "${OBJECT_ID}"
    echo "${RESPONSE_STATUS_CODE}"
    echo "${RESPONSE_BODY}"

    #echo curl -X GET \
        #-w " %{http_code}" \
        #-H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
        #-H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
        #-H "Content-Type: application/json" \
        #"${BASE_URL}/${OBJECT_ID}"

    assert false
}


function teardown_file(){
    # extract objectId from created movie
    local object_id=$(jq --raw-output .objectId <<< "${RESPONSE_BODY}")

    # delete movie from db
    local url="${BASE_URL}/${object_id}"
    local response=$(curl -X DELETE \
        -w " %{http_code}" \
        -H "X-Parse-Application-Id: ${PARSE_APPLICATION_ID}" \
        -H "X-Parse-REST-API-Key: ${PARSE_REST_API_KEY}" \
        "${url}")

    # extract status code from http response
    local status_code=$(cut -f2 -d' ' <<< "${response}")

    # if not 200, then error
    [[ "${status_code}" -eq 200 ]] || {
        echo "Error: Movie with objectId=${object_id} was not deleted"
        exit 1
    }
}

