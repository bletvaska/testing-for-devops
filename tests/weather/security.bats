#!/usr/bin/env bats

# load modules
load "../libs/bats-assert/load.bash"
load "../libs/bats-support/load.bash"


# globals
# load "settings.sh"
readonly IMAGE_NAME="bletvaska/weather"
readonly SEVERITY="high" #negligible, low, medium, high, critical


#succeds if no vulnerabilities
@test "check for vulnerabilities in image" {
   run grype "${IMAGE_NAME}" --fail-on "${SEVERITY}" --quiet
   assert_success
}
