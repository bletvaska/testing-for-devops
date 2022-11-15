declare -ar _LEVEL_NAMES='(
    [10]="DEBUG" 
    [20]="INFO" 
    [30]="WARNING" 
    [40]="ERROR" 
    [50]="CRITICAL"
)'


function _log(){
    local level="${1:?Missing log level.}"
    local message="${2:?Missing log message.}"
    local ts=$(date "+%F %T")
    local stream=1

    # print all messages with log level >= 40 to stderr
    if [[ $level -ge 40 ]]; then
        stream=2
    fi

    # print log message
    printf "%s %s: %s\n" \
           "${ts}" "${_LEVEL_NAMES[${level}]}" "${message}" \
           >&${stream}
}


# print DEBUG log message
function debug(){
    local message="${1:?Missing message.}"

    _log 10 "${message}" 
}


# print INFO log message
function info(){
    local message="${1:?Missing message.}"

    _log 20 "${message}" 
}


# print WARNING log message
function warning(){
    local message="${1:?Missing message.}"

    _log 30 "${message}" 
}


# print ERROR log message
function error(){
    local message="${1:?Missing message.}"

    _log 40 "${message}" 
}


# print CRITICAL log message
function critical(){
    local message="${1:?Missing message.}"

    _log 50 "${message}" 
}
