#!/usr/bin/env bats

function skip_platform(){
    skip "Not a selected platform"
}

@test "if not a linux then skip" {
    skip_platform "linux"

    run date
}


@test "addition using bc" {
    result="$(echo 2+2 | bc)"
    [[ $result == 4 ]]
}


@test "addition using dc" {
    printf ">> running dc\n"
    result="$(echo 2 2+p | dc)"
    [[ $result == 4 ]]
}


@test "if cat is invoked with a nonexistent file then expect an error message" {
    run cat xfile
    [[ ${output} == "cat: can't open 'xfile': No such file or directory" ]]
}
