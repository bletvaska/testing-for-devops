#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'


function setup_file(){
    # create name of folder
    FOLDER=$(mktemp --directory --dry-run)
    export FOLDER

    # create folder
    mkdir "${FOLDER}"
}


function teardown_file() {
    [[ -d "${FOLDER}" ]] && rmdir "${FOLDER}"
    unset FOLDER
}


@test "when new folder is created, then it should exist" {
    assert [[ -d "${FOLDER}" ]]
}
