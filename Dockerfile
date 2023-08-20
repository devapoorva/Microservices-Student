FROM --platform=linux/x86_64 ubuntu:20.04
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ARG profile
ENV SPRING_PROFILES_ACTIVE ${profile}

ENV KEYCLOAK_ADMIN admin
ENV KEYCLOAK_ADMIN_PASSWORD secret
ENV KEYCLOAK_VERSION 22.0.1
ENV NODE_VERSION 16.0.0
ENV MAVEN_VERSION 3.9.4
ENV KAFKA_VERSION 2.13-3.5.1

# Install base dependencies
RUN apt-get update &&  apt-get -y  upgrade && apt-get autoremove 
RUN apt-get install -y net-tools
RUN apt-get install -y wget 
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y  git software-properties-common curl
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
COPY . /application

# Node js

RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} -o nodesource_setup.sh
RUN  apt install -y nodejs

# JDK
RUN apt-cache search openjdk | grep openjdk-17
RUN apt install -y openjdk-17-jdk


# maven
RUN wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN tar xf apache-maven-${MAVEN_VERSION}-bin.tar.gz
RUN mv apache-maven-${MAVEN_VERSION} /opt/maven/
RUN export M2_HOME=/opt/maven
RUN export MAVEN_HOME=/opt/maven
RUN export PATH=${M2_HOME}/bin:${PATH}
RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn
RUN mvn --version

# cafka https://www.linuxtechi.com/how-to-install-apache-kafka-on-ubuntu/
# https://downloads.apache.org/kafka/3.5.1/ https://kafka.apache.org/downloads
# RUN apt install -y zookeeperd

# https://archive.apache.org/dist/kafka/3.5.0/kafka_2.12-3.5.0.tgz 

RUN wget https://downloads.apache.org/kafka/3.5.1/kafka_${KAFKA_VERSION}.tgz
RUN tar -xzf kafka_${KAFKA_VERSION}.tgz
RUN mv kafka_${KAFKA_VERSION} /opt/kafka

WORKDIR /application

COPY server.properties /opt/kafka/config/server.properties
COPY zookeeper.service /etc/systemd/system/zookeeper.service
COPY kafka.service /etc/systemd/system/kafka.service
RUN export KAFKA_HOME=/opt/kafka
RUN export PATH=${KAFKA_HOME}/bin:${PATH}
RUN ln -s $KAFKA_HOME/config/server.properties /etc/kafka.properties
# RUN systemctl daemon-reload

# keycloak
# https://github.com/keycloak/keycloak/releases/download/22.0.1/keycloak-22.0.1.tar.gz
RUN wget https://github.com/keycloak/keycloak/releases/download/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz
RUN tar -xzf keycloak-${KEYCLOAK_VERSION}.tar.gz
RUN mv keycloak-${KEYCLOAK_VERSION} /opt/keycloak
RUN export KEYCLOAK_HOME=/opt/keycloak
RUN export PATH=${KEYCLOAK_HOME}/bin:${PATH}

# https://stackoverflow.com/questions/30209776/docker-container-will-automatically-stop-after-docker-run-d
# ENTRYPOINT ["tail"]
# CMD ["-f","/dev/null"] 
# zipkin
RUN curl -sSL https://zipkin.io/quickstart.sh | bash -s

CMD sh start.sh && tail -f /dev/null