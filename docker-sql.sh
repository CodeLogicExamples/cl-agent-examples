#!/usr/bin/env bash

# Source in agent environment variables.
[ ! -f .agent_env ] || export $(grep -v '^#' .agent_env | xargs)

LOCAL_DIR=`pwd`
CERT_DIR="${LOCAL_DIR}/certs"

CL_SQLCMD="analyze -a ${DB_APPNAME} -c jdbc:${DB_TYPE}://${DB_HOST}:${DB_PORT}/${DB_NAME};${DB_XTRA} -u ${DB_USER} -pwd ${DB_PASS} --expunge-scan-sessions"
echo ${CL_SQLCMD}

# Run scan with the configured values in .agent_env file.
docker run --pull always --rm --network host --interactive --tty \
     --volume "${CERT_DIR}/cacerts:/usr/local/openjdk-11/lib/security/cacerts:ro" \
     --env CODELOGIC_HOST="${PROTOCOL}://${CL_HOST}:${PORT}" \
     --env AGENT_UUID=${DB_AGENT_UUID} \
     --env AGENT_PASSWORD=${DB_AGENT_PASSWORD} \
     ${CL_HOST}/codelogic_sql:latest #\
     #"analyze -a ${DB_APPNAME} -c jdbc:${DB_TYPE}://${DB_HOST}:${DB_PORT}/${DB_NAME}";"${DB_XTRA} -u ${DB_USER} -pwd ${DB_PASS} --expunge-scan-sessions"
