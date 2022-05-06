#!/usr/bin/env bats

load '/tools/libs/bats-assert/load.bash'
load '/tools/libs/bats-support/load.bash'

MOVIE_ID="zxLyFAMt8B"

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
    response=$(http "${BASE_URL}/${MOVIE_ID}" \
         "X-Parse-Application-Id:${PARSE_APP_ID}" \
         "X-Parse-REST-API-Key:${PARSE_REST_API_KEY}" \
         --print hb)

    # split response to header and body
    res_header=$(sed '/^\s*$/q' <<< "${response}")
    res_body=$(sed '1,/^\s*$/d' <<< "${response}")

    # extract status from header
    _status=($(head -n 1 <<< "${response}"))
    res_status="${_status[1]}"

    # update header
    res_header=$(sed '1d;$d' <<< "${res_header}")

    # export variables
    export res_header
    export res_body
    export res_status

    echo "${res_header}" > /tmp/header
    echo "${res_body}" > /tmp/body
    echo "${res_status}" > /tmp/status
}


teardown_file() {
    unset res_header
    unset res_body
    unset res_status
}


@test "when movie is downloaded expect status ok" {
    # Arrange
    local expected=200

    # Assert
    assert [[ $res_status == $expected ]]
}


@test "when movie was downloaded expect content type json" {
    # Arrange
    line=$(grep "^Content-Type: " <<< "${res_header}")

    # Assert
    assert [[ "${line}" =~ "application/json" ]]
}


@test "when movie was downloaded expect specific keys in movie json" {
    # Act
    jq -e ".|select(.objectId)|select(.title)|select(.year)|select(.genres)|select(.createdAt)|select(.updatedAt)" <<< "${res_body}"
}

