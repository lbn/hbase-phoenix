FROM harisekhon/hbase:latest

ARG APACHE_MIRROR=https://www.apache.org/dist
ARG PHOENIX_VERSION=4.14.0
ENV HBASE_MAJOR 1.3
ENV HBASE_HOME /hbase
ENV PHOENIX_HOME /hbase/phoenix
ENV PATH $PATH:$PHOENIX_HOME/bin

RUN apk --no-cache add wget ca-certificates python && update-ca-certificates \
    && wget -q -O - $APACHE_MIRROR/phoenix/apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR/bin/apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR-bin.tar.gz | tar -xz -C /hbase/ \
    && cd /hbase && ln -s ./apache-phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR-bin phoenix \
    && cp $PHOENIX_HOME/phoenix-core-$PHOENIX_VERSION-HBase-$HBASE_MAJOR.jar $HBASE_HOME/lib/phoenix.jar \
    && cp $PHOENIX_HOME/phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR-server.jar $HBASE_HOME/lib/phoenix-server.jar

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 8765

