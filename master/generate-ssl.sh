#!/bin/bash

K8S_SERVICE_IP=10.3.0.1

cat << EOF > $CERTIFICATE_DESTINATION/openssl.cnf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
IP.1 = ${K8S_SERVICE_IP}
IP.2 = ${ip}
EOF

echo -e "\n"
echo "---- Generating root certificates (ca.pem and ca-key.pem)"
echo -e "\n"
openssl genrsa -out $CERTIFICATE_DESTINATION/ca-key.pem 2048
openssl req -x509 -new -nodes -key $CERTIFICATE_DESTINATION/ca-key.pem -days 10000 -out $CERTIFICATE_DESTINATION/ca.pem -subj "/CN=kube-ca"

echo -e "\n"
echo "---- Generating API server keypair"
echo -e "\n"

openssl genrsa -out $CERTIFICATE_DESTINATION/apiserver-key.pem 2048
openssl req -new -key $CERTIFICATE_DESTINATION/apiserver-key.pem -out $CERTIFICATE_DESTINATION/apiserver.csr -subj "/CN=kube-apiserver" -config $CERTIFICATE_DESTINATION/openssl.cnf
openssl x509 -req -in $CERTIFICATE_DESTINATION/apiserver.csr -CA $CERTIFICATE_DESTINATION/ca.pem -CAkey $CERTIFICATE_DESTINATION/ca-key.pem -CAcreateserial -out $CERTIFICATE_DESTINATION/apiserver.pem -days 365 -extensions v3_req -extfile $CERTIFICATE_DESTINATION/openssl.cnf
