#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'

function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"
}

