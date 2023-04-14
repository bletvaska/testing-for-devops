#!/usr/bin/env bats

load "${LIBS}/bats-support/load.bash"
load "${LIBS}/bats-assert/load.bash"

@test "when movie was successfully retrieved then http status code is 200" {
    http https://parseapi.back4app.com/classes/movies/u9wuoyMaqE \
    X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
    X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk

}