#!/usr/bin/env bash
set -e

apt-get install -qq rng-tools
echo 'HRNGDEVICE=/dev/urandom' > /etc/default/rng-tools
service rng-tools start

