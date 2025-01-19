FROM jenkins/ssh-slave
FROM folioci/jenkins-slave-all:java-21

USER 0
RUN apt-get update 
RUN apt-get install -y python3 \
                       python3-pip \
                       vim
RUN pip3 install xmlrunner

USER jenkins
RUN mkdir -p /home/jenkins/.ssh
COPY ssh/authorized_keys /home/jenkins/.ssh

USER 0

