#!/usr/bin/env bats

# load modules
load "libs/bats-support/load.bash"
load "libs/bats-assert/load.bash"

# globals
readonly IMAGE_NAME='bletvaska/weather'
readonly CONTAINER_NAME='weather'


# fixtures


# tests
@test "when started then working directory is /app" {
  # arrange
  local EXPECTED="/app"

  # act
  run docker container run --rm -it --name "${CONTAINER_NAME}" "${IMAGE_NAME}:latest" pwd

  # assert
  assert_output "${EXPECTED}"
  # assert_equal "${PWD}" "/app"
}

@test "when started then user is mrilko" {
  # arrange
  local EXPECTED="mrilko"

  # act
  run docker container run --rm -it --name "${CONTAINER_NAME}" "${IMAGE_NAME}:latest" whoami

  # assert
  assert_output "${EXPECTED}"
  # assert_equal "${USER}" "${EXPECTED}"
}


@test "when started then version of Python interpretter is 3.11" {
  # arrange
  local EXPECTED="Python 3.11.10"

  # act
  run docker container run --rm -it --name "${CONTAINER_NAME}" "${IMAGE_NAME}:latest" python --version

  # assert
  assert_output "${EXPECTED}"
  # assert_equal "${USER}" "${EXPECTED}"
}
