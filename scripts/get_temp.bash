#!/bin/bash


APP_ID="08f5d8fd385c443eeff6608c643e0bc5"
CITY_NAME="$1"


if [ -z "$CITY_NAME" ]; then
    echo "Error: No city name given, which is required." >&2
    exit 1
fi


function get_data() {
    local CITY_NAME="$1"


    local JSON=`http http://api.openweathermap.org/data/2.5/weather units==metric q=="$CITY_NAME" appId=="$APP_ID"`
    status="${?}"
    if [ $status -gt 0 ]; then
        echo "Error: There was an error receiving the data" >&2
        return 1
    fi

    echo $JSON
    return 0
}


function print_temperature() {
    local CITY_NAME="$1"

    local JSON=`get_data "$CITY_NAME"`
}