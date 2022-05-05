#!/usr/bin/env bats

load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"


# the rule: AAA pattern
# Arrange - Act - Assert
@test "if sets are provided then translation will be provided" {
    # Arrange
    local set1="aeiouy"
    local set2="AEIOUY"
    local text="hello"
    local expected="hEllO"

    # Act
    output=$(echo "${text}" | tr "${set1}" "${set2}")

    # Assert
    [[ $output == "${expected}" ]]
}

