#!/usr/bin/env bats

load "/tools/libs/bats-support/load.bash"
load "/tools/libs/bats-assert/load.bash"

source "scripts/gettemp.sh"

readonly LOCATION="kosice"
readonly INVALID_LOCATION="asdf"


function setup_file(){
	echo ">> setup file" >> log
}


function teardown_file(){
	echo ">> teardown file" >> log
}

function setup(){
	echo ">> setup for test" >> log
}


function teardown(){
	echo ">> teardown for test" >> log
}

@test "if location is valid then temperature is printed out" {
	# arrange - local setup

	# act - make action
    run get_temp "${LOCATION}"

	# assert - test assertion
    assert [[ -n ${output} ]]
}


@test "if location is valid then temperature is printed out in specific format" {
    run get_temp "${LOCATION}"
    [[ "${output}" =~ ^[-]?[0-9]{1,2}\.[0-9]{0,2}°C$ ]]
}


@test "if location is valid then exit status is 0 {
    run get_temp "${LOCATION}"
    assert [[ ${status} == 0 ]]
}


@test "if location is not valid then status code is 1" {
    run get_temp "${INVALID_LOCATION}"
    assert [[ ${status} == 1 ]]
}


@test "if location is not valid then error output is printed out" {
    run get_temp "${INVALID_LOCATION}"
    [[ "${lines}"  =~ ^Error* ]]
}


@test "if location is empty then status code = 1" {
    run get_temp
    assert [[ ${status} == 1 ]]
}


@test "if location is empty then usage is printed out" {
    run get_temp
    [[ ${lines[1]}  =~ ^Usage* ]]
}


@test "if location is empty then error output is printed out" {
    run get_temp
    [[ ${lines[0]}  =~ ^Error* ]]
}

