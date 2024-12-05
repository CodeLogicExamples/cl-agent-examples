# Generate agent from in the CodeLogic UI store.
docker run --pull always --rm --interactive --tty \
     --env CODELOGIC_HOST="http://<CODELOGIC_HOST>" \
     --env AGENT_UUID="<CODELOGIC_AGENT_UUID>" \
     --env AGENT_PASSWORD="CODELOGIC_AGENT_PASSWORD>" \
     <CODELOGIC_HOST>/codelogic_sql:latest \
     analyze --application "<NAME_YOUR_APPLICATION>" --user <DATABASE_USER> --password <DATABASE_PASSWORD> --jdbc-url jdbc:oracle:thin:@<DATABASE_HOST>:1521/<DATABASE_NAME> -d <DATABASE_NAME> 
