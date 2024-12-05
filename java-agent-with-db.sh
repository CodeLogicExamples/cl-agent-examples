docker run --pull always --rm --interactive --tty \
     --env CODELOGIC_HOST="http://192.168.0.3:80" \
     --env AGENT_UUID="2b1fd85d-b1ff-448c-bf4f-5d0536fa6b9a" \
     --env AGENT_PASSWORD="6L1sBYSN1qf5oadF" \
     --volume "/opt/ofbiz-oracle-docker/ofbiz-output:/scan" \
     192.168.0.3:80/codelogic_java:latest \
     analyze --application "ofbiz-framework" --path /scan --database "jdbc:oracle:thin:@192.168.0.4:1521/ofbiz"
