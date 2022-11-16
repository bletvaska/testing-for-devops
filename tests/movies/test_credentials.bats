#!/usr/bin/env bats

load '/tools/libs/bats-support/load.bash'
load '/tools/libs/bats-assert/load.bash'


# ak nezadam ziadny token, tak http status kod je 401 a error message
# ak zadam len app id, tak http status kod je 403 a error message
# ak zadam len rest api key, tak http status kod je 401 a error message
# ak zadam oba kluce ale zle, tak http staus kod 401 a error message
# ak zadam validne oba kluce, tak http status kod 200 a dostanem film
