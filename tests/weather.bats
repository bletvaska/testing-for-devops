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

  # act
  run docker container run --rm -it --name "${CONTAINER_NAME}" "${IMAGE_NAME}:latest" pwd

  # assert
  assert_output "/app"
  # assert_equal "${PWD}" "/app"
}

