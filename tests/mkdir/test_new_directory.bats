#!/usr/bin/env bats

set -o errexit
set -o pipefail
set -o nounset

# load modules
load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'

function setup_file(){
    # create folder with random name
    export folder=$(mktemp --directory --dry-run)
    mkdir "${folder}"
}


function teardown_file() {
    [[ -d "${folder}" ]] && rmdir "${folder}"
}


@test "when new folder is created, then it should exist" {
    assert [[ -d "${folder}" ]]
}
