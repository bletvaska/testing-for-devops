function _log(){
    local level="${1}"
    local message="${2}"
    local ts=$(date "+%F %T")

    printf "%s %s: %s\n" "${ts}" "${level}" "${message}"
}


function error(){
    local message="${1}"

    _log "ERROR" "${message}" 
}
