FROM resin/rpi-raspbian
RUN apt-get -y update && apt-get install -y oracle-java8-jdk
ENV HZ_VERSION 3.8-EA
ENV HZ_HOME /opt/hazelcast/
RUN mkdir -p $HZ_HOME
WORKDIR $HZ_HOME
# Download hazelcast jars from maven repo.
ADD https://repository-hazelcast-l337.forge.cloudbees.com/release/com/hazelcast/hazelcast-enterprise-all/$HZ_VERSION/hazelcast-enterprise-all-$HZ_VERSION.jar $HZ_HOME
ADD server.sh /$HZ_HOME/server.sh
ADD stop.sh /$HZ_HOME/stop.sh
RUN chmod +x /$HZ_HOME/server.sh
RUN chmod +x /$HZ_HOME/stop.sh
# Start hazelcast standalone server.
CMD ./server.sh
EXPOSE 5701

