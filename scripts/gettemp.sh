#!/usr/bin/env bash
 
set -o errexit  # stop when error occurs
set -o pipefail # if not, expressions like `error here | true`
                # will always succeed
set -o nounset  # detects uninitialised variables
[[ "${DEBUG:-}" ]] && set -o xtrace   # prints every expression
                                      # before executing it (debugging)
 
readonly APPID="08f5d8fd385c443eeff6608c643e0bc5"
# source .env
 

function usage(){
    echo "Usage: ./gettemp.sh [city,countrycode]"
    echo "Created by (c)2022 peto, mirek, michal"
}


function get_temp(){
    local location="${1:-}"
 
    [[ -z "${location}" ]] && {
        usage
        echo "Error: No city name given, which is required." >&2
        exit 1
    }
 
    temp=$(jq .main.temp <(http "http://api.openweathermap.org/data/2.5/weather?units=metric&q=${location}&appid=${APPID}"))

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

