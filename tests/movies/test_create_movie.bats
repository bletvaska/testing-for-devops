#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'


function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"

    # create a new entry
    response=$(http --pretty=none --print=hb "${URL}" \
        "X-Parse-Application-Id:${APPLICATION_ID}" \
        "X-Parse-REST-API-Key:${REST_API_KEY}" \
        title="Indiana Jones 5" \
        year:=2023 \
        genres:='["Adventure", "Action"]'
    )

    # extract http status code from first line
    export http_status=$(sed -rne  '1s|.* ([0-9]+) .*|\1|p' <<< "${response}")

    # extract header
    export response_headers=$(sed -nre 's/\r$//' -e '2,/^$/p' <<< "${response}")

    # extract body
    export response_body=$(sed -nre 's/\r$//' -e '/^$/,$p' <<< "${response}")
}


@test "hello world" {
    # printf "%d\n" "${http_status}"
    # printf "%s\n" "${response_headers}"
    printf "%s\n" "${response_body}"
    assert true
}


# ak sa podarilo film vytvorit, tak http status kod 201 a vo vysledku bude objectId a createdAt
@test "WIP: when movie was created, then http status code is 201" {
    assert_equal "${http_status}" 201
}

# ak poslem prazdny dopyt, tak
