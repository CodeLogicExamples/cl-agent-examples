#!/usr/bin/env bash

# Source in agent environment variables.
[ ! -f .agent_env ] || export $(grep -v '^#' .agent_env | xargs)

# Remove original daemon.json
rm -f /etc/docker/daemon.json

# Create empty daemon.json
cat << EOF > /etc/docker/daemon.json
{ }
EOF

# Make directory reflecting host exposing self-signed cert.
mkdir -p /etc/docker/certs.d/${HOST}

# Retrieve certificate from host and place in docker cert location.
openssl s_client -showcerts -connect ${HOST}:$PORT < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /etc/docker/certs.d/${HOST}/ca.crt

# Stop CodeLogic.
systemctl stop codelogic

sleep 10

# Restart docker.
systemctl restart docker

sleep 10

# For whatever reason the docker daemon will start a subset of CodeLogic containers. Stop orphans.
docker stop $(docker ps -q)

sleep 10

# Start CodeLogic
systemctl start codelogic
