# extracts HTTP status code from HTTP response
function get_http_status(){
    local response="${1:?Response object not set.}"

    sed -rne  '1s|.* ([0-9]+) .*|\1|p' <<< "${response}"
}


# Extracts headers from HTTP response
function get_headers() {
    local response="${1:?Response object not set.}"

    sed -nre 's/\r$//' -e '2,/^$/p' <<< "${response}"
}


# Extracts headers from HTTP response as JSON
# Function gets the response headers as JSON object.
# To retrieve the values with dash in key names, use following syntax:
# $ jq '."Content-Type"' <<< "${json}"
function get_headers_as_json() {
    local response="${1:?Response object not set.}"

    headers=$(get_headers "${response}")
    jq --slurp --raw-input \
        '[split("\n")[:-1][]
            | rtrimstr("\\r")
            | split(": ")
            | {(.[0]): .[1]} ]
        | add' <<< "${headers}"
}


# Extracts body from HTTP response
function get_body() {
    local response="${1:?Response object not set.}"

    sed -nre 's/\r$//' -e '/^$/,$p' <<< "${response}"
}
