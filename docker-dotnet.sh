#!/usr/bin/env bash

# Source in agent environment variables.
[ ! -f .dotnetagent_env ] || export $(grep -v '^#' .dotnetagent_env | xargs)

LOCAL_DIR=`pwd`
CERT_DIR="${LOCAL_DIR}/certs"
CL_DOTNETCMD=""

# Run scan with the configured values in .agent_env file.
docker run --pull always --rm --interactive --tty \
     --env CODELOGIC_HOST="${PROTOCOL}://${CL_HOST}:${PORT}" \
     --env AGENT_UUID="<THE_AGENT_UUID>" \
     --env AGENT_PASSWORD="<THE_AGENT_PASSWORD>" \
     --env SSL_CERT_FILE="/mycerts/ca.crt" \
     --volume "/opt/dnn:/scan" \
     --volume "/opt/dnn/cl-agent-examples/certs:/mycerts" \
     ${CL_HOST}/codelogic_dotnet:latest \
     ${CL_DOTNETCMD}
