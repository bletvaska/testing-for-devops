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


# presence of file
@test "when created then index.html is in /usr/share/nginx/html/" {
    docker container exec -it "${CONTAINER}" hostname
}


# content of file
@test "when created then index.html contains string Welcome to nginx" {
}


# running process
@test "when created then process nginx is running" {
}


# user check
@test "when created then user is root" {
}

