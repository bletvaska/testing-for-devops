#!/usr/bin/env bats

# load modules
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

# globals
readonly IMAGE_NAME='bletvaska/weather'
readonly CONTAINER_NAME='weather'


# fixtures
function setup_file() {
  docker container run -it \
    --name "${CONTAINER_NAME}" \
    --detach \
    "${IMAGE_NAME}:latest"
}

function teardown_file() {
  docker container stop "${CONTAINER_NAME}"
}


# tests
@test "when started then working directory is /app" {
  # arrange
  local EXPECTED="/app"

  # act
  run docker container exec -it "${CONTAINER_NAME}" pwd

  # assert
  assert_output "${EXPECTED}"
  # assert_equal "${PWD}" "/app"
}


@test "when started then user is mrilko" {
  # arrange
  local EXPECTED="mrilko"

  # act
  run docker container exec -it "${CONTAINER_NAME}" whoami

  # assert
  assert_output "${EXPECTED}"
  # assert_equal "${USER}" "${EXPECTED}"
}


@test "when started then version of Python interpretter is 3.11" {
  # arrange
  local EXPECTED="Python 3.11.10"

  # act
  run docker container exec -it "${CONTAINER_NAME}" python --version

  # assert
  assert_output "${EXPECTED}"
}
