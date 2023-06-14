#!/usr/bin/env bash

function main(){
    printf "Hello world!\n"
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo $name
    main "$@"
fi

