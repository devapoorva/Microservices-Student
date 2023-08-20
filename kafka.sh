#!/bin/sh
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
LOG "kafka started"
exit 0