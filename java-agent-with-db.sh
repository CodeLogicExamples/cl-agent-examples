# Oracle example:
docker run --pull always --rm --interactive --tty \
     --env CODELOGIC_HOST="http://<CODELOGIC_HOST>" \
     --env AGENT_UUID="<CODELOGIC_AGENT_UUID>" \
     --env AGENT_PASSWORD="<CODELOGIC_AGENT_PASSWORD>" \
     --volume "/path/to/artifacts:/scan" \
     <CODELOGIC_HOST>/codelogic_java:latest \
     analyze --application "<YOUR_APPLICATION_NAME>" --path /scan --database "jdbc:oracle:thin:@<DATABASE_HOST>:1521/<DATABASE_NAME>"  # You may have to add the --rescan flag if the same artifact has already been scanned. 
