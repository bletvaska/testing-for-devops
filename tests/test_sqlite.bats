#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"

readonly DB_URI="resources/movies.sqlite"


@test "when imported then number of movies is 6989" {
    expected=6989
    query='SELECT COUNT(*) FROM movie'

    run sqlite3 "${DB_URI}" "${query}"

    assert_equal "${output}" "${expected}"
}
