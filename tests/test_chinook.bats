#!/usr/bin/env bats

load '/tools/libs/bats-assert/load.bash'
load '/tools/libs/bats-support/load.bash'


@test "when imported expect 5 media types" {
    # Act
    run sqlite3 data/chinook.sqlite "select count(*) from mediatype"

    # Assert
    assert [[ $output == 5 ]]
}
