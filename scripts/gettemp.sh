#!/usr/bin/env bash
 
set -o errexit  # stop when error occurs
set -o pipefail # if not, expressions like `error here | true`
                # will always succeed
#set -o nounset  # detects uninitialised variables
[[ "${DEBUG:-}" ]] && set -o xtrace   # prints every expression
                                      # before executing it (debugging)
 
readonly APPID="${OPENWEATHERMAP_API_KEY:-08f5d8fd385c443eeff6608c643e0bc5}"
# source .env
 

function usage(){
    echo "Usage: ./gettemp.sh [city,countrycode]"
    echo "Created by (c)2022 peto, mirek, michal"
}


function get_temp(){
    local location="${1:-}"
 
    # check if location is entered
    [[ -z "${location}" ]] && {
        echo "Error: No city name given, which is required." >&2
        usage
        exit 1
    }
 
    # download data
    local json=$(http "http://api.openweathermap.org/data/2.5/weather?units=metric&q=${location}&appid=${APPID}")

    # if http status code is not 200, then exit
    local http_status=$(echo "${json}" | jq --raw-output .cod)
    [[ "${http_status}" == 200 ]] || {
        printf "Error: Invalid location ${location}.\n" >&2
        exit 1
    }

    # extract temperature
    local temp=$(echo "${json}" | jq --raw-output .main.temp)

    echo "${temp}°C"
}

 
function main(){
    local location="${1:-}"
    get_temp "${location}"
}
 

# call the func only if the script is executed directly
if [[ "${BASH_SOURCE[0]:-}" == "${0}" ]]; then
  main "$@"
fi

