#!/bin/bash -e

SYNC_DIR="/vagrant"
ROOT_DIR="/root"

# MySql
MYSQL_CONF=/etc/mysql/my.cnf

# Kafka
KAFKA_MIRROR=http://mirror.fibergrid.in/apache/kafka/0.8.2.2/kafka_2.11-0.8.2.2.tgz
KAFKA_DIR=kafka_2.11-0.8.2.2
KAFKA_TGZ=${KAFKA_DIR}.tgz

pushd $ROOT_DIR

# MySql setup
service mysql start

# Kafka setup
if [ ! -d $KAFKA_DIR ]; then
	wget $KAFKA_MIRROR
	tar -zxvf $KAFKA_TGZ
fi

pushd $KAFKA_DIR
(./bin/kafka-server-stop.sh) || true
(./bin/zookeeper-server-stop.sh) || true
./bin/zookeeper-server-start.sh config/zookeeper.properties &
./bin/kafka-server-start.sh config/server.properties &
popd

popd
