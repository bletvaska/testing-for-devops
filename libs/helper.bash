source "./logging.bash"


# https://stackoverflow.com/a/64331640/1671256
function or_exit() {
    local exit_status="${?}"
    local message="${*}"

    echo "${exit_status}"

    [[ "${exit_status}" == 0 ]] || {
        error "${message}"
        echo exit "${exit_status}"
    }
}
