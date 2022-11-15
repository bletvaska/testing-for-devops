# Returns current temperature for given location
# Function returns current temperature from openweathermap.org service. 
# The query for retrieving the temperature is given in parameter. 
# Optionally you can pass also units parameter to set the result unit.
# @param query the city to retrieve temperature for
# @param units possible values are only `metric` or `imperial`
# @return 
# @output 
function get_temperature(){
    local query="${1:?Error: query not set}"
    local units="${2:-metric}"

    json=$(http "${BASE_URL:-localhost}/data/2.5/weather" \
        units=="${units}" \
        q=="${query}" \
        appid=="${APP_ID:?Error: Application ID is missing.}" \
    )

    temp=$(jq --raw-output '.main.temp' <<< "${json}")
    printf "%.1f°C\n" "${temp}"
}
