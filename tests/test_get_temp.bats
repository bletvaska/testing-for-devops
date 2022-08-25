#!/usr/bin/env bats

source "scripts/gettemp.sh"


@test "if location is valid then temperature is printed out" {
    local location="kosice"
    run get_temp "${location}"
    [[ -n ${output} ]]
}


@test "if location is valid then temperature is printed out in specific format" {
    local location="kosice"
    run get_temp "${location}"
    [[ ${output} =~ [0-9]{2}\.[0-9]{2}°C ]]
}


@test "if location is valid then exit status is 0 {
    local location="kosice"
    run get_temp "${location}"
    [[ ${status} == 0 ]]
}

