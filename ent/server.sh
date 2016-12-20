#!/bin/sh

PRG="$0"
PRGDIR=`dirname "$PRG"`
HAZELCAST_HOME=`cd "$PRGDIR/.." >/dev/null; pwd`/hazelcast
PID_FILE=$HAZELCAST_HOME/hazelcast_instance.pid
JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::") 

if [ $JAVA_HOME ]
then
    echo "JAVA_HOME found at $JAVA_HOME"
    RUN_JAVA=$JAVA_HOME/bin/java
else
    echo "JAVA_HOME environment variable not available."
    RUN_JAVA=`which java 2>/dev/null`
fi

if [ -z $RUN_JAVA ]
then
    echo "JAVA could not be found in your system."
    exit 1
fi

    echo "Path to Java : $RUN_JAVA"

if [ "x$MIN_HEAP_SIZE" != "x" ]; then
    JAVA_OPTS="$JAVA_OPTS -Xms${MIN_HEAP_SIZE}"
fi

if [ "x$MAX_HEAP_SIZE" != "x" ]; then
    JAVA_OPTS="$JAVA_OPTS -Xmx${MAX_HEAP_SIZE}"
fi

export CLASSPATH=$HAZELCAST_HOME/hazelcast-enterprise-all-$HZ_VERSION.jar:$CLASSPATH/*

echo "########################################"
echo "# RUN_JAVA=$RUN_JAVA"
echo "# JAVA_OPTS=$JAVA_OPTS"
echo "# starting now...."
echo "########################################"

PID=$(cat "${PID_FILE}");
if [ -z "${PID}" ]; then
    echo "Process id for hazelcast instance is written to location: {$PID_FILE}"
    $RUN_JAVA $JAVA_OPTS -Dhazelcast.enterprise.license.key=$HZ_LICENSE_KEY com.hazelcast.core.server.StartServer &
    echo $! > ${PID_FILE}
else
    echo "Another hazelcast instance is already started in this folder."
    exit 0
fi
sleep infinity
