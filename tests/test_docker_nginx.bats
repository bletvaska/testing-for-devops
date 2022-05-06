#!/usr/bin/env bats

load '/tools/libs/bats-assert/load.bash'
load '/tools/libs/bats-support/load.bash'

CONTAINER=nginx_test

setup_file() {
    docker container run --rm -it \
    --publish 8080:80 \
    --name "${CONTAINER}" \
    --detach \
    nginx
}


teardown_file(){
    docker container stop "${CONTAINER}"
}


@test "hello world" {
    docker container exec -it "${CONTAINER}" hostname
}


