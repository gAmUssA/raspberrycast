#!/bin/sh

docker run -e JAVA_OPTS="-Dhazelcast.config=/configFolder/hazelcast.xml" -v ~/raspberrycast/oss:/configFolder -ti -p 5701:5701 raspberrycast
