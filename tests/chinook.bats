#!/usr/bin/env bats

# load modules
load "libs/bats-assert/load.bash"
load "libs/bats-support/load.bash"


# globals
readonly DB_URI="${BATS_TEST_DIRNAME}/chinook.sqlite"

function sql_query() {
  local query="${1:?SQL query is missing.}"
  sqlite3 "${DB_URI}" "${query}"
}


@test "when created then number of genres is 25" {
  # arrange
  local query="SELECT COUNT(*) FROM genre"
  local expected=25

  # act
  run sql_query "${query}"

  # assert
  assert_output "${expected}"
}
