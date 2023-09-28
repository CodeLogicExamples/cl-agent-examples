#!/usr/bin/env bash

# Source in agent environment variables.
[ ! -f .agent_env ] || export $(grep -v '^#' .agent_env | xargs)

# Run scan with the configured values in .agent_env file.
docker run --pull always --rm --network host --interactive --tty \
     --env CODELOGIC_HOST="${PROTOCOL}://${CL_HOST}:${PORT}" \
     --env AGENT_UUID=${DB_AGENT_UUID} \
     --env AGENT_PASSWORD=${DB_AGENT_PASSWORD} \
     ${CL_HOST}/codelogic_sql:latest \
     "analyze -a ${DB_APPNAME} -c jdbc:${DB_TYPE}://${DB_HOST}:${DB_PORT}/${DB_NAME};${DB_XTRA} -u ${DB_USER} -pwd ${DB_PASS} --expunge-scan-sessions"
