#!/usr/bin/env bats

load '/tools/libs/bats-assert/load.bash'
load '/tools/libs/bats-support/load.bash'

CONTAINER=nginx_test

_setup_file() {
    docker container run --rm -it \
    --publish 8080:80 \
    --name "${CONTAINER}" \
    --detach \
    nginx
}


_teardown_file(){
    docker container stop "${CONTAINER}"
}


# presence of file
@test "when created then index.html is in /usr/share/nginx/html/" {
    docker container exec -it "${CONTAINER}" \
        [ -f /usr/share/nginx/html/index.html ]
}


# content of file
@test "when created then index.html contains string 'Welcome to nginx!'" {
    docker container exec -it "${CONTAINER}" \
        grep "Welcome to nginx!" /usr/share/nginx/html/index.html
}


# running process
@test "when created expect running process nginx" {
    # Act
    run docker container exec -it "${CONTAINER}" service nginx status

    # Assert
    assert [[ "${output}" =~ "nginx is running." ]]
}


# user check
@test "when created then user is root" {
}

