function get_http_status(){
    local response="${1:?Response object not set.}"

    sed -rne  '1s|.* ([0-9]+) .*|\1|p' <<< "${response}"
}


function get_headers() {
    local response="${1:?Response object not set.}"

    sed -nre 's/\r$//' -e '2,/^$/p' <<< "${response}"
}


function get_body() {
    local response="${1:?Response object not set.}"

    sed -nre 's/\r$//' -e '/^$/,$p' <<< "${response}"
}
