#!/bin/bash
apt-get update
apt-get install -y nginx

# Check the hostname and set content accordingly
if [[ $(hostname) == "web1" ]]; then
    echo "This is Web Server 1" > /var/www/html/index.html
elif [[ $(hostname) == "web2" ]]; then
    echo "This is Web Server 2" > /var/www/html/index.html
elif [[ $(hostname) == "web3" ]]; then
    echo "This is Web Server 3" > /var/www/html/index.html
else
    echo "This is a default page" > /var/www/html/index.html
fi