#!/usr/bin/env bash

# Source in agent environment variables.
[ ! -f .dotnetagent_env ] || export $(grep -v '^#' .dotnetagent_env | xargs)

#set -x                                                 # Set for debugging. 
#DOTNET_CMD="scan-namespaces --help"                    # Help for scan-namespaces.  Used for understanding namespaces to scan
#DOTNET_CMD="analyze --help"                            # Help for analyze command.
#DOTNET_CMD="scan-namespaces --path /scan/DotNetNuke"   # Get namespaces from dll files in path.
# Example dotnet scan command.
#DOTNET_CMD="analyze -a dnn --path /scan --filter DotNetNuke. --filter DNN. --filter Dnn. --method-filter DotNetNuke. --method-filter DNN. --method-filter Dnn. --database jdbc:sqlserver://192.168.0.63;databaseName=dnn --expunge-scan-sessions"
DOTNET_CMD="analyze -a ${DOTNET_APPNAME} --path /scan --filter ${DOTNET_DLL_FILTER} --database ${JDBC_STRING} --method-filter ${DOTNET_METHOD_FILTER} --expunge-scan-sessions"

# Run scan with the configured values in .agent_env file.
docker run --pull always --rm --interactive --tty \
     --env CODELOGIC_HOST="${CL_PROTOCOL}://${CL_HOST}:${CL_PORT}" \
     --env AGENT_UUID="${DOTNET_AGENT_UUID}" \
     --env AGENT_PASSWORD="${DOTNET_AGENT_PASSWORD}" \
     --env SSL_CERT_FILE="/mycerts/ca.crt" \
     --volume "${DOTNET_BINARY_PATH}:/scan" \
     --volume "${CL_CERT_PATH}:/mycerts" \
     ${CL_HOST}/codelogic_dotnet:latest \
     ${DOTNET_CMD}
