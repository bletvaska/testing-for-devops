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
    [[ ${output} =~ ^[-]?[0-9]{1,2}\.[0-9]{0,2}°C$ ]]
}


@test "if location is valid then exit status is 0 {
    local location="kosice"
    run get_temp "${location}"
    [[ ${status} == 0 ]]
}


@test "if location is not valid then status code is 1" {
    local location="adfs"
    run get_temp "${location}"
    [[ ${status} == 1 ]]
}


@test "if location is not valid then error output is printed out" {
    local location="adfs"
    run get_temp "${location}"
    [[  ${lines}  =~ ^Error* ]]
}


@test "if location is empty then status code = 1" {
    run get_temp
    [[ ${status} == 1 ]]
}


@test "if location is empty then usage is printed out" {
    run get_temp
    [[  ${lines[1]}  =~ ^Usage* ]]
}


@test "if location is empty then error output is printed out" {
    run get_temp
    [[  ${lines[0]}  =~ ^Error* ]]
}

