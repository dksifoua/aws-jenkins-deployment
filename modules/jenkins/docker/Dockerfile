FROM jenkins/jenkins:lts-jdk17
LABEL authors="Dimitri Sifoua"
LABEL description="Jenkins CI/CD Server"
LABEL maintainer="Dimitri Sifoua <dimitri.sifoua@gmail.com>"
LABEL repository="dksifoua"
LABEL version="1.1.3"

ARG JCASC_FILE
ARG PLUGINS_FILE
ARG JENKINS_ADMIN_USER
ARG JENKINS_ADMIN_NAME
ARG JENKINS_ADMIN_DESC
ARG JENKINS_ADMIN_PASS
ARG JENKINS_ADMIN_EMAIL
ARG GITHUB_ACCESS_TOKEN

ENV JENKINS_ADMIN_USER $JENKINS_ADMIN_USER
ENV JENKINS_ADMIN_NAME $JENKINS_ADMIN_NAME
ENV JENKINS_ADMIN_DESC $JENKINS_ADMIN_DESC
ENV JENKINS_ADMIN_PASS $JENKINS_ADMIN_PASS
ENV JENKINS_ADMIN_EMAIL $JENKINS_ADMIN_EMAIL
ENV GITHUB_ACCESS_TOKEN $GITHUB_ACCESS_TOKEN

#USER root
#RUN apt-get update && apt-get install -y lsb-release
#RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
#    https://download.docker.com/linux/debian/gpg
#RUN echo "deb [arch=$(dpkg --print-architecture) \
#    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
#    https://download.docker.com/linux/debian \
#    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
#RUN apt-get update && apt-get install -y docker-ce-cli

USER jenkins
COPY ${JCASC_FILE} $JENKINS_HOME/jenkins.yaml
COPY ${PLUGINS_FILE} $REF/plugins.txt
RUN echo 2.0 > $REF/jenkins.install.UpgradeWizard.state
RUN jenkins-plugin-cli -f $REF/plugins.txt