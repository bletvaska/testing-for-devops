#!/usr/bin/env bats

load "/tools/libs/bats-support/load.bash"
load "/tools/libs/bats-assert/load.bash"

readonly DB_URI="resources/movies.sqlite"


@test "when imported, then number of movies should be 6989" {
    # arrange
    local expected=6989
    local query="SELECT COUNT(*) FROM movie;"

    # act
    run sqlite3 "${DB_URI}" "${query}"

    # assert
    assert_equal $output $expected
}

