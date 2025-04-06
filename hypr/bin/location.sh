#!/bin/bash

#DEPRECATED USE ONLY weather.sh, the api returns the location too

#based on ip
# Get the public IP address
ip_address=$(curl -s ifconfig.me)
# Get the current network interface

# echo $(curl -s "https://ipinfo.io/$ip_address" | jq -r '"\(.city), \(.region), \(.country)"')
#
#more accurate site
curl -s "https://ipapi.co/$ip_address/json/" | jq -r '"\(.city), \(.region), \(.country)"'
