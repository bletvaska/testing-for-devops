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
function get_http_status() {
    local response="${1:?Response object not set.}"
    
    readarray -t -d" " content <<< "${response}"
    printf "%s" "${content[1]}"
}


# Return the headers of HTTP response as text.
function get_http_headers() {
    local response="${1:?Response object not set.}"

    sed -nre 's/\r$//' -e '2,/^$/p' <<< "${response}"
}


# Return the headers of HTTP response as JSON object.
function get_headers_as_json() {
   local response="${1:?Response object not set.}"

   headers=$(get_http_headers "${response}")
   jq --slurp --raw-input \
       '[split("\n")[:-1][]
           | rtrimstr("\\r")
           | split(": ")
           | {(.[0]): .[1]} ]
       | add' <<< "${headers}"
}


# Return the body of HTTP response only.
function get_body() {
   local response="${1:?Response object not set.}"

   sed -nre 's/\r$//' -e '/^$/,$p' <<< "${response}"
}


function http_query() {
    local method="${1:?Missing HTTP method.}"
    local url="${2:?Missing URL.}"
    local params="${@:?Missing parameters for making HTTP request.}"

    response=$(http --print=hb "${@}" )

    http_status_code=$(get_http_status "${response}")
    http_headers=$(get_headers_as_json "${response}")
    http_body=$(get_body "${response}")

    export http_status_code
    export http_headers
    export http_body
}
