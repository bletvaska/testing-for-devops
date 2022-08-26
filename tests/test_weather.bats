#!/usr/bin/env bats

load '../libs/bats-assert/load.bash'
load '../libs/bats-support/load.bash'


readonly CONTAINER_NAME=weather

#function setup_file(){
    #docker container run --rm -it \
    #--name "${CONTAINER_NAME}" \
    #--detach \
    #bletvaska/weather
#}


#function teardown_file(){
     #docker container stop "${CONTAINER_NAME}"
#}


@test "when started then user is mrilko" {
    # arrange
    local expected="mrilko"
    local cmd="whoami"

    # act
    run docker container exec "${CONTAINER_NAME}" "${cmd}"

    # assert
    [[ "${output}" == "${expected}" ]]
}


@test "when started, then process with pid=1 is python weather" {
    # arrange
    local cmd='ps --pid 1 --no-headers -o "cmd"'
    local expected="/usr/local/bin/python /usr/local/bin/weather"

    # act
    run docker container exec "${CONTAINER_NAME}" "${cmd}"

    # assert
    [[ "${output}" == "${expected}" ]]
}
