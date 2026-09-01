FROM eclipse-temurin:8-jdk AS java8
FROM eclipse-temurin:17-jdk AS java17
FROM eclipse-temurin:21-jdk AS java21
FROM eclipse-temurin:25-jdk AS java25

FROM debian:bookworm-slim

LABEL version="latest"
LABEL author="Janosch | Solus Labs" maintainer="info@janosch-bl.de"

RUN apt-get update && apt-get install -y wget curl jq bash git ca-certificates && rm -rf /var/lib/apt/lists/*

ENV JAVA8_HOME=/opt/java8 \
    JAVA17_HOME=/opt/java17 \
    JAVA21_HOME=/opt/java21 \
    JAVA25_HOME=/opt/java25

RUN mkdir -p $JAVA8_HOME $JAVA17_HOME $JAVA21_HOME $JAVA25_HOME

COPY --from=java8 /opt/java/openjdk $JAVA8_HOME
COPY --from=java17 /opt/java/openjdk $JAVA17_HOME
COPY --from=java21 /opt/java/openjdk $JAVA21_HOME
COPY --from=java25 /opt/java/openjdk $JAVA25_HOME

ENV JAVA_HOME=$JAVA21_HOME \
    JAVA_VERSION=auto
ENV PATH=$JAVA_HOME/bin:$PATH

RUN useradd -m -d /home/container -s /bin/bash container

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R container:container /home/container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

CMD ["/bin/bash", "/entrypoint.sh"]
