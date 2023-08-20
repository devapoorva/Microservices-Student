#!/bin/sh
# export KAFKA_HOME=/opt/kafka
# export PATH=${KAFKA_HOME}/bin:${PATH}
# ln -s $KAFKA_HOME/config/server.properties /etc/kafka.properties
/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties & /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties & java -jar zipkin.jar & /opt/keycloak/bin/kc.sh start-dev

# export KEYCLOAK_HOME=/opt/keycloak
# export PATH=${KEYCLOAK_HOME}/bin:${PATH}

# service enable zookeeper 
# service zookeeper start
# service kafka start
# kc.sh start-dev

echo "APPLICATION started"
exit 0