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
    # Arrange
    cmd="service nginx status"
    expected="nginx is running."

    # Act
    run docker container exec -it "${CONTAINER}" $cmd

    # Assert
    assert [[ "${output}" =~ "$expected" ]]
}


# user check
@test "when created then user is root" {
    # Arrange
    cmd="whoami"
    expected="root"

    # Act
    run docker container exec -it "${CONTAINER}" $cmd

    # Assert
    assert [[ "${output}" =~ "$expected" ]]
}

