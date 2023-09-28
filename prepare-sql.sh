#!/usr/bin/env bash

# Requires java.
apt install -y default-jdk

# Source in agent environment variables.
[ ! -f .agent_env ] || export $(grep -v '^#' .agent_env | xargs)

LOCAL_DIR=`pwd`
CERT_DIR="${LOCAL_DIR}/certs"

cp /etc/ssl/certs/java/cacerts ${CERT_DIR}

openssl s_client -showcerts -connect ${CL_HOST}:$PORT < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ${CERT_DIR}/ca.crt

keytool -import -trustcacerts -keystore ${CERT_DIR}/cacerts -storepass changeit -noprompt -alias codelogic -file ${CERT_DIR}/ca.crt
