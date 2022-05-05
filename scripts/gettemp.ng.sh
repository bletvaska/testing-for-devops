#!/usr/bin/env bash

set -o errexit  # stop when error occurs
set -o pipefail # if not, expressions like `error here | true`
                # will always succeed
set -o nounset  # detects uninitialised variables
[[ ${DEBUG:-} ]] && set -o xtrace   # prints every expression
                                    # before executing it (debugging)

readonly APIKEY="08f5d8fd385c443eeff6608c643e0bc5"

usage() {
    echo "usage: gettemp.sh CITY"
}


get_temp() {
    local city="${1:-}"

    # if no param given, then quit
    [[ -n $city ]] || {
        usage
        echo "Error: No city name given, which is required." 1>&2
        exit 1
    }

    # prepare URL
    URL="http://api.openweathermap.org/data/2.5/weather?units=metric&q=${city}&appid=${APIKEY}"

    # extract temp
    temp=$(curl -s "$URL" | jq .main.temp)

    # show temp
    echo "${temp}°C"
}


main() {
    get_temp "${@}"
}


# call the func only if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi

