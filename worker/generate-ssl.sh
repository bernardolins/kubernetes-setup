#!/bin/bash

cat << EOF > worker-openssl.cnf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
IP.1 = $ip
EOF

echo -e "\n"
echo "---- Generating worker keypairs"
echo -e "\n"
openssl genrsa -out ${fqdn}-worker-key.pem 2048
openssl req -new -key ${fqdn}-worker-key.pem -out ${fqdn}-worker.csr -subj "/CN=${fqdn}" -config worker-openssl.cnf
openssl x509 -req -in ${fqdn}-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out ${fqdn}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf
