#!/bin/sh
/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties
LOG "zookeeper started"
exit 0