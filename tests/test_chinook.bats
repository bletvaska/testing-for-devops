#!/usr/bin/env bats

# globals
source local.env

# bats libraries
load "${LIBS}/bats-assert/load.bash"
load "${LIBS}/bats-support/load.bash"

function sql_query() {
    local query="${1:?Query is missing}"

    sqlite3 "${DB_URI}" "${query}"
}

function setup_file() {
    # open db connection
}

function teardown_file() {
    # close db connection
}

@test "when imported then the number of tracks should be 3503" {
    # Arrange
    local query="select count(*) from track"
    local expected=3503

    # Act
    run sql_query "${query}"

    # Assert
    assert_output "${expected}"
}
