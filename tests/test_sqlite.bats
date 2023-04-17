#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"

readonly DB_URI="resources/movies.sqlite"

function sql_query() {
    local query="${1:?No query entered.}"
    sqlite3 "${DB_URI}" "${query}"
}


@test "when imported then number of movies is 6989" {
    expected=6989
    query='SELECT COUNT(*) FROM movie'

    run sql_query "${query}"

    assert_equal "${output}" "${expected}"
}
