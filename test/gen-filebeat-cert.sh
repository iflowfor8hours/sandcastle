#!/usr/bin/env bash

set -e
cd $(dirname $0)

openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 -keyout filebeat.key -out filebeat.crt
