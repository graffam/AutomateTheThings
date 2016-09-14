#!/bin/sh
exec scala "$0" "$@"
!#
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._
import sys.process._

val topics: List[String] = List("assetEvents","alertEvents")
val kafkaDirectory = "/Users/alexandergraff/Projects/kafka_2.11-0.10.0.0/"


topics.foreach(topic => {
  println(s"Purging ${topic}")
  Process(s"${kafkaDirectory}bin/kafka-topics.sh --zookeeper localhost:2181 --alter --topic ${topic} --config retention.ms=1000").lines
})
