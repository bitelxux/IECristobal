#!/bin/sh -x

action=$1

QUALIFIER=demo

export JENKINS_NAME=jenkins
export GITLAB_NAME=gitlab

export JENKINS_DATA=/home/cnn/workspace/$QUALIFIER/jenkins_data
export GITLAB_DATA=/home/cnn/workspace/$QUALIFIER/gitlab_data

function start_environment {

    echo "starting jenkins-gitlab environment"

    # build agent image with docker client
    # docker images | grep -q docker-agent || docker build -t docker-agent files/docker_agent
    
    # create network for jenkins agents
    # docker network ls | grep -q docker-agents || docker network create docker-agents
    
    # run docker compose
    docker compose up -d
    
    while true; do
        (docker ps | grep -qE "starting|unhealthy") || break
        echo "$(date) waiting for containers ..."
        sleep 10 
    done
    
    # trust gitlab certificate
    echo "containers are up !"
    echo "trusting gitlab certificate in jenkins"
    docker exec -u root $JENKINS_NAME sh -c "echo | openssl s_client -connect gitlab.localhost.com:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/gitlab.crt"
    docker exec -u root $JENKINS_NAME sh -c "keytool -delete -alias gitlab -cacerts -storepass changeit || true"
    docker exec -u root $JENKINS_NAME sh -c "keytool -import -alias gitlab -file /tmp/gitlab.crt -cacerts -storepass changeit -noprompt"
}

function stop_environment {
    echo "stopping jenkins-gitlab environment"
    docker compose stop
}

function delete_environment {
    echo "deleting containers"
    docker compose down
}


if [[ "$action" == 'start' ]]; then
   start_environment
elif [[ "$action" = 'stop' ]]; then
   stop_environment
elif [[ "$action" = 'down' ]]; then
   delete_environment
else
   echo "action not in start|stop|down"
   exit 1
fi
