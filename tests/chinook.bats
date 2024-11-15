#!/usr/bin/env bats

# load modules
load "libs/bats-assert/load.bash"
load "libs/bats-support/load.bash"


# globals
readonly DB_URI="${BATS_TEST_DIRNAME}/chinook.sqlite"

@test "when created then number of genres is 25" {
  # arrange
  local query="SELECT COUNT(*) FROM genre"
  local expected=25

  # act
  run sqlite3 "${DB_URI}" "${query}"

  # assert
  assert_output "${expected}"
}
