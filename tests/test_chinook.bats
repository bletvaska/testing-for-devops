#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load

# globals
readonly DB_URI="${BATS_TEST_DIRNAME}/resources/chinook.sqlite"

function sql_query() {
    local query="${1:?Missing query.}"
    sqlite3 "${DB_URI}" "${query}"
}


@test "when imported then table mediatype should contain 5 entries" {
    run sql_query "SELECT COUNT(*) FROM MediaType"
    assert_output 5
}
