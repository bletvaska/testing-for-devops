#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'

function setup_file() {
    # set local test variables
    export URL="${BASE_URL}/classes/movies/"
}

# http post https://parseapi.back4app.com/classes/movies/ \
#     X-Parse-Application-Id:axACcyh0MTO3z42rUN8vFHfyAgE22VRjd3IJOwlJ \
#     X-Parse-REST-API-Key:sQAPUPRNJg2GpZ9f0fXZaALSvekT7N2KmdM8kBWk \
#     title="Indiana Jones 5" \
#     year:=2023 \
#     genres:='["Adventure", "Action"]'


# ak sa podarilo film vytvorit, tak http status kod 201 a vo vysledku bude objectId a createdAt
# ak poslem prazdny dopyt, tak
