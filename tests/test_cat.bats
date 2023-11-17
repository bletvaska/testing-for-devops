#!/usr/bin/env bats

set -o nounset


# load modules
load libs/bats-support/load
load libs/bats-assert/load


@test "when file doesn't exist then show error message" {
    local file=$(mktemp --dry-run)
    run cat "${file}"
    assert_output "cat: ${file}: No such file or directory"
}

@test "when file doesn't exist then exit status is 1" {
    run cat $(mktemp --dry-run)
    assert_failure
}
