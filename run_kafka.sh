#!/bin/sh
exec scala "$0" "$@"
!#
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._
import sys.process._

val topics: List[String] = List("assetEvents","alertEvents")
val kafkaDirectory = "/Users/alexandergraff/Projects/kafka_2.11-0.10.0.0/"

println("Starting ZooKeeper")
Process(s"${kafkaDirectory}bin/zookeeper-server-start.sh ${kafkaDirectory}config/zookeeper.properties").lines
Thread.sleep(2000)
println("Starting Kafka")
Process(s"${kafkaDirectory}bin/kafka-server-start.sh ${kafkaDirectory}config/server.properties").lines
Thread.sleep(2000)
println("Creating Topics")
topics.foreach{ topic =>
  Process(s"${kafkaDirectory}bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic ${topic}").lines
}
Thread.sleep(100)
System.exit(0)
