#!/usr/bin/env bash

# Simple HTTP Lib module for extracting and later processing of HTTP response objects.
#
# To get the response object, use HTTPie in the form:
#
# $ http --print=hb http://pie.dev/get


# Return the HTTP status code of HTTP response.
#
# Globals:
#   none
# Arguments:
#   $1 - response object
# Returns:
#   0 on success, non-zero on error.
# Outputs:
#   STDOUT - HTTP status code
function _get_http_status() {
    local response="${1:?Response object not set.}"
    
    readarray -t -d" " content <<< "${response}"
    printf "%s" "${content[1]}"
}


# Return the headers of HTTP response as text.
function _get_http_headers() {
    local response="${1:?Response object not set.}"

    sed -nre 's/\r$//' -e '2,/^$/p' <<< "${response}"
}


# Return the headers of HTTP response as JSON object.
function _get_headers_as_json() {
   local response="${1:?Response object not set.}"

   headers=$(_get_http_headers "${response}")
   jq --slurp --raw-input \
       '[split("\n")[:-1][]
           | rtrimstr("\\r")
           | split(": ")
           | {(.[0]): .[1]} ]
       | add' <<< "${headers}"
}


# Return the body of HTTP response only.
function _get_body() {
   local response="${1:?Response object not set.}"

   sed -nre 's/\r$//' -e '/^$/,$p' <<< "${response}"
}


# Executes HTTP request
#
# Globals:
#   http_status_code - HTTP status code of response
#   http_headers - Headers of HTTP response
#   http_body - Body HTTP response
# Arguments:
#   $1 - HTTP method (GET|POST|PUT|...)
#   $2 - URL
#   $3 - HTTP params
# Returns:
#   0 on success, non-zero on error.
# Outputs:
#   none
function http_query() {
    local method="${1:?Missing HTTP method.}"
    local url="${2:?Missing URL.}"
    local params="${@:?Missing parameters for making HTTP request.}"

    response=$(http --print=hb "${@}")

    http_status_code=$(_get_http_status "${response}")
    http_headers=$(_get_headers_as_json "${response}")
    http_body=$(_get_body "${response}")

    export http_status_code
    export http_headers
    export http_body
}


function assert_http_status_code() {
    local status="${1}"

    if [[ $http_status_code != "$status" ]]; then
        batslib_print_kv_single_or_multi 8 \
            'expected' "$status" \
            'actual'   "$http_status_code" \
        | batslib_decorate 'HTTP status codes do not equal' \
        | fail
    fi
}
