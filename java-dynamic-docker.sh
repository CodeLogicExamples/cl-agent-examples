# Generate docker agent in the CodeLogic UI store.  Make sure to copy the AGENT_UUID and AGENT_PASSWORD.

docker run --pull always --rm --interactive --tty \
     --env CODELOGIC_HOST="http://<CODELOGIC_HOST>" \
     --env AGENT_UUID="<CODELOGIC_AGENT_UUID>" \
     --env AGENT_PASSWORD="CODELOGIC_AGENT_PASSWORD>" \
     --env RMI_REGISTRY_PORT="1097" \                              # You can change this to any port that is open.
     --env SERVER_RMI_PORT="1097" \                                # You can change this to any port that is open
     --env JAVA_OPTS="-Djava.rmi.server.hostname=<AGENT_HOST>" \
     --env NAMESPACES=<YOUR_NAMESPACES> \                          # Comma seperated list of Namespaces or packages.  Example: "com.codelogic,com.example"
     --publish 1097:1097 \                                         # Configure docker to expose the same ports as RMI.
     <CODELOGIC_HOST>/codelogic_java:latest dynamic

# Retrieve java-instrumentation.jar from CodeLogic server.
wget http://<CODELOGIC_HOST>/codelogic/server/packages/java-instrumentation.jar

# Instrument application and connect to running remote java dynamic agent:
java -javaagent:java-instrumentation.jar=rmiRegistryHost=<AGENT_HOST>;rmiRegistryPort=1097 -Xbootclasspath/a:java-instrumentation.jar -jar <PATH_TO_JAR>/demo-0.0.1-SNAPSHOT.jar
