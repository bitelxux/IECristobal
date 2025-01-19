suffix=intest

docker exec -u root jenkins_intest sh -c "echo | openssl s_client -connect gitlab.localhost.com:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/gitlab.crt"
docker exec -u root jenkins_intest sh -c "keytool -delete -alias gitlab -cacerts -storepass changeit || true"
docker exec -u root jenkins_intest sh -c "keytool -import -alias gitlab -file /tmp/gitlab.crt -cacerts -storepass changeit -noprompt"

