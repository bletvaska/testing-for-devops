#!/usr/bin/env bats

load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

setup_file() {
    # check the .env file existence
    [[ -f .env ]] || {
        echo "Error: Missing .env file" >&2
        exit 1
    }

    # import .env file
    set -o allexport
    source .env
    set +o allexport

    # make a request
    response=$(http "${BASE_URL}" \
         "X-Parse-Application-Id:${PARSE_APP_ID}" \
         "X-Parse-REST-API-Key:${PARSE_REST_API_KEY}" \
         -p hb)

    # split response to header and body
    #res_header=$(sed '1,/^\s*$/p' -n <<< "${response}")
    res_header=$(sed '/^\s*$/q' <<< "${response}")
    res_body=$(sed '1,/^\s*$/d' <<< "${response}")

    # extract status from header
    _status=($(head -n 1 <<< "${response}"))
    res_status="${_status[1]}"

    # update header
    res_header=$(sed '1d;$d' <<< "${res_header}")

    # exports
    export res_header
    export res_body
    export res_status
}


teardown_file() {
    unset res_header
    unset res_body
    unset res_status
}


@test "wip: when credentials are provided expect status ok" {
    # Arrange
    expected=200

    # Assert
    assert [[ ${res_status} == ${expected} ]]
}


@test "wip: when credentials are provided expect body as json" {
    # Act
    run jq . <<< "${res_body}"
    #run jq -e . 2> /dev/null 1>&2 <<< "${res_body}"

    # Assert
    assert [[ ${status} == 0 ]]
}


@test "wip: when credentials are provided expect key results in body" {
    # Act
    run jq -e .results <<< "${res_body}"

    # Assert
    assert [[ ${status} == 0 ]]
}


@test "when no credentials are provided expect status code 401" {
    # Arrange

    # Act
    response=($(http -h GET https://parseapi.back4app.com/classes/movies))

    # Assert
    assert [[ ${response[1]} == 401 ]]
}


@test "when no credentials are provided expect error message" {
    # Arrange
    expected='{
  "error": "unauthorized"
}'

    # Act
    response=$(http GET https://parseapi.back4app.com/classes/movies | jq .)

    # Assert
    assert [[ "$response" == "$expected" ]]
}

