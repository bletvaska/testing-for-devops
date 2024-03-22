#!/usr/bin/env bats

# load modules
load libs/bats-support/load
load libs/bats-assert/load

# globals
readonly DB_URI="chinook.sqlite"

function sql_query() {
    local query="${1:?Query is missing.}"

    sqlite3 "${DB_URI}" "${query}"
}


@test "when imported, then number of genres is 25" {
    # Arrange
    expected=25
    query="SELECT COUNT(*) FROM genre"

    # Act
    run sql_query #"${query}"

    # Assert
    assert_output "${expected}"
}