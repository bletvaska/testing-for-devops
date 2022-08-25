#!/usr/bin/env bats

source "scripts/gettemp.sh"


@test "if location is valid then temperature is printed out" {
    local location="kosice"
    run get_temp "${location}"
    [[ -n ${output} ]]
    [[ ${output} =~ [0-9]{2}.[0-9]{2}°C ]]
}

