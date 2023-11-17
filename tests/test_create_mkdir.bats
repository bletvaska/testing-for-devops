#!/usr/bin/env bats

set -o nounset

# load modules
load libs/bats-support/load
load libs/bats-assert/load

# fixtures
function setup() {
  folder=$(mktemp --directory --dry-run)
  readonly folder

  run mkdir "${folder}"
}

function teardown() {
  if [ -d "${folder}" ]; then
    rmdir "${folder}"
  fi
}

function setup_file() {
  readonly FILE=$(mktemp --dry-run)
  wget http://chinook.com/data.sqlite \
    --output-document "${FILE}"
  readonly DBURI="sqlite://${FILE}"
}

function teardown_file() {
  if [[ -f "${FILE}" ]]; then
    rm "${FILE}"
  fi
}

@test "when created then folder exist" {
  assert [ -d "${folder}" ]
}

@test "when created then folder is empty" {
  # false
}
