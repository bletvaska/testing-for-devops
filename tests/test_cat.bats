#!/usr/bin/env bats

set -o nounset

# load modules
load libs/bats-support/load
load libs/bats-assert/load

# globals
readonly CMD=/usr/bin/cat

@test "if file doesn't exist then show error message" {
  local file=$(mktemp --dry-run)
  run "${CMD}" "${file}"
  assert_output "${CMD}: ${file}: No such file or directory"
  assert_failure
}

@test "if there are insufficient permissions then show error message" {
  local file=/etc/shadow
  run "${CMD}" "${file}"
  assert_output ""${CMD}": ${file}: Permission denied"
  assert_failure
}

@test "if invalid option provided then show error message" {
  local option='--invalid-option'
  run "${CMD}" "${option}"
  assert_line --index 0 ""${CMD}": unrecognized option '${option}'"
  assert_failure
}
