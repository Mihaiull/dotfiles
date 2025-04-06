#!/bin/bash


#usage: weather_location.sh
if [ -z "$1" ]; then
    echo "Usage: $0 --location|--weather"
    echo "  --location: Get location information
  --weather: Get weather information"
    exit 1
fi



ip=$(curl -s ifconfig.me)
apikey="$(cat ~/.apis/weatherapi)"

curl -s "http://api.weatherapi.com/v1/current.json?key=$apikey&q=$ip&aqi=no" > ~/.config/hypr/bin/weather/weather.json

#now parse that fucker
city=$(jq -r '.location.name' ~/.config/hypr/bin/weather/weather.json)
region=$(jq -r '.location.region' ~/.config/hypr/bin/weather/weather.json)
country=$(jq -r '.location.country' ~/.config/hypr/bin/weather/weather.json)
temp=$(jq -r '.current.temp_c' ~/.config/hypr/bin/weather/weather.json)
condition=$(jq -r '.current.condition.text' ~/.config/hypr/bin/weather/weather.json)
humidity=$(jq -r '.current.humidity' ~/.config/hypr/bin/weather/weather.json)
feelslike=$(jq -r '.current.feelslike_c' ~/.config/hypr/bin/weather/weather.json)

#mm how do I present this
# "City: $city"
# "Temperature: $temp"
# "Condition: $condition"
# "Humidity: $humidity"
# "Feels like: $feelslike"
if [[ $1 == "--location" ]]; then
    echo "$city, $region, $country"
elif [[ $1 == "--weather" ]]; then
    echo "$condition, $temp°C, feels like $feelslike°C, humidity $humidity%"
else
    echo "Invalid option. Use --location or --weather."
    exit 1
fi

#icons on the way
