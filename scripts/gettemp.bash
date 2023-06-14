#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
[[ "${ENVIRONMENT:-prod}" == "devel" ]] && set -o xtrace

# global variables
readonly APIKEY="08f5d8fd385c443eeff6608c643e0bc5"
readonly URL="http://api.openweathermap.org/data/2.5/weather"


function error(){
  local message="${*}"
  printf "ERROR: %s\n" "${message}" 1>&2;
}


function usage() {
	cat << EOF
Usage: gettemp.sh [OPTIONS] CITY[,COUNTRY]
Shows current temperature for given location.

-h, --help      shows this help
-u, --units     change unit (metric|imperial)

(c)2023 by mirek
EOF
}


function get_temp(){
    local query="${1}"
    local temp
    local city
    local json

    # http request
    json=$(http "${URL}" units==metric q=="${query}" appid=="${APIKEY}")

    # extract temperature and name of the city
    temp=$(jq --raw-output .main.temp <<< "${json}")
    city=$(jq --raw-output .name <<< "${json}")
    
    # render output
    printf "The current temperature in %s is %.2f°C" "${city}" "${temp}"
}


# the main function
function main(){
    local query="${1:-}" #?Error: Missing query.}"

    # check if query was provided
    if [[ -n $query ]]; then
    # [[ $query ]] || {
        usage
        error "Missing query."
        exit 1
    # }
    fi

    # get the temperature
    get_temp "${query}"
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
