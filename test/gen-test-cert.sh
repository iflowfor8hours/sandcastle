#!/usr/bin/env bash

openssl genrsa -out rootCA.key 4096

openssl req -x509 -new -nodes -key rootCA.key -days 3650 -out rootCA.pem <<EOF
AU
Some-State
City
_AAA Sandstorm Test
section
common name
email@address
EOF

openssl genrsa -out sandstorm.key 4096

openssl req -new -key sandstorm.key -out sandstorm.csr -config openssl.cnf <<EOF
AU
Some-State
City
Sandstorm Test
section
common name
email@address
challenge pass
company name
EOF

openssl x509 -req -in sandstorm.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out sandstorm.crt -days 730 -extensions v3_req -extfile openssl.cnf

