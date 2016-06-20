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
sleep 4
for t in $KAFKA_TOPICS; do
	./bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic $t
	./bin/kafka-topics.sh --zookeeper localhost:2181 --create --replication-factor 1 --partitions 1 --topic $t
done
popd


