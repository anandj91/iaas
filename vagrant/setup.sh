# MySql setup
edit_file_if_not_already $MYSQL_CONF "bind-address\s*= 127.0.0.1" "bind-address = 0.0.0.0"
if [ ! `grep "skip-grant-tables" $MYSQL_CONF` ]; then
	sed -i "s/^\[mysqld\]$/[mysqld]\nskip-grant-tables/g" $MYSQL_CONF
fi
service mysql restart
for d in ${MYSQL_DBS[@]}; do
	echo "$d"
	echo "CREATE DATABASE IF NOT EXISTS $d;" | mysql
done

# Kafka setup
if [ ! -d $KAFKA_DIR ]; then
	wget $KAFKA_MIRROR
	tar -zxvf $KAFKA_TGZ
fi

pushd $KAFKA_DIR
add_to_file_if_not_already $KAFKA_CONFIG "advertised.host.name=127.0.0.1"
(./bin/kafka-server-stop.sh) || true
(./bin/zookeeper-server-stop.sh) || true
./bin/zookeeper-server-start.sh $ZK_CONFIG &
sleep 2
./bin/kafka-server-start.sh $KAFKA_CONFIG &
sleep 2
for t in ${KAFKA_TOPICS[@]}; do
	./bin/kafka-topics.sh --zookeeper localhost:2181 --create --replication-factor 1 --partitions 1 --topic $t
done
popd

# Cassandra setup
edit_file_if_not_already $CASSANDRA_CONF "^listen_address: localhost$" "listen_address: 127.0.0.1"
edit_file_if_not_already $CASSANDRA_CONF "^rpc_address: localhost$" "rpc_address: 0.0.0.0"
add_to_file_if_not_already $CASSANDRA_CONF "broadcast_rpc_address: 127.0.0.1"
service cassandra restart
