#!/usr/bin/env bash

# Simple HTTP Lib module for extracting and later processing of HTTP response objects.
#
# To get the response object, use HTTPie in the form:
#
# $ http --print=hb http://pie.dev/get
#
# Created by (c)mirek 2023
# http://bletvaska.github.io


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

   sed -nre 's/\r$//' -e '/^$/,$p' <<< "${response}" | sed '1d'
}


# Executes HTTP request
#
# Globals:
#   http_status_code - HTTP status code of response
#   http_headers - Headers of HTTP response
#   output - Body of HTTP response
# Arguments:
#   $1 - HTTP method (GET|POST|PUT|...)
#   $2 - URL
#   $3 - HTTP params, optional
# Returns:
#   0 on success, non-zero on error.
# Outputs:
#   none
function http_query() {
    local method="${1:?Missing HTTP method.}"
    local url="${2:?Missing URL.}"
    local params=("${@}")

    response=$(http --print=hb "${method}" "${url}" "${params[@]:2}")

    http_status_code=$(_get_http_status "${response}")
    http_headers=$(_get_headers_as_json "${response}")
    output=$(_get_body "${response}")

    export http_status_code
    export http_headers
    export output
}


# Executes HTTP GET request
#
# Globals:
#   http_status_code - HTTP status code of response
#   http_headers - Headers of HTTP response
#   http_body - Body HTTP response
# Arguments:
#   $1 - URL
#   $2 - HTTP params, optional
# Returns:
#   0 on success, non-zero on error.
# Outputs:
#   none
function http_get() {
    local url="${1:?Missing URL.}"
    local params=("${@}")

    http_query get "${url}" "${params[@]:1}"
}


# Fail and display details if the expected and actual HTTP status codes do not
# equal. Details include both headers.
#
# Globals:
#   none
# Arguments:
#   $1 - expected HTTP status code
# Returns:
#   0 - values equal
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
function assert_http_status_code() {
    local expected="${1}"

    if [[ $http_status_code != "$expected" ]]; then
        batslib_print_kv_single_or_multi 8 \
            'expected' "$expected" \
            'actual'   "$http_status_code" \
        | batslib_decorate 'HTTP status codes do not equal' \
        | fail
    fi
}


# Fail and display details if the expected and actual headers do not
# equal. Details include both headers.
#
# Globals:
#   none
# Arguments:
#   $1 - header name
#   $2 - expected value
# Returns:
#   0 - values equal
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
function assert_http_header() {
    local header="${1:?Missing header.}"
    local expected="${2:?Missing value.}"

    local actual
    actual=$(jq --raw-output '."'"${header}"'"' <<< "${http_headers}")

    if [[ "${actual}" != "${expected}" ]]; then
        batslib_print_kv_single_or_multi 8 \
            'expected' "$expected" \
            'actual'   "$actual" \
        | batslib_decorate "values of HTTP header '${header}' do not match" \
        | fail
    fi
}
