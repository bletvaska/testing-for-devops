#!/usr/bin/env bats

load '/tools/libs/bats-assert/load.bash'
load '/tools/libs/bats-support/load.bash'

DB_PATH="data/chinook.sqlite"

# source "sqlquery_sqlite.sh"


sql_query() {
    local query="${1}"

    sqlite3 "${DB_PATH}" "${query}"
}


@test "when imported expect 5 media types" {
    # Arrange
    query="select count(*) from mediatype"
    expected=5

    # Act
    run sql_query "${query}"

    # Assert
    assert [[ $output == $expected ]]
}

