FROM openjdk:8u171-jdk-stretch as builder

MAINTAINER andrey.dyachkov@gmail.com

WORKDIR /tmp
RUN apt-get update && apt-get install -y curl wget jq tar
RUN wget -O nakadi.tar.gz $(curl --silent "https://api.github.com/repos/zalando/nakadi/releases/latest" | jq -r .tarball_url)
RUN tar -xvf nakadi.tar.gz --strip-components=1
RUN chmod u+x gradlew
RUN ./gradlew assemble

FROM openjdk:8u171-jdk-alpine3.7
COPY --from=builder /tmp/build/libs/nakadi.jar .
COPY --from=builder /tmp/api/nakadi-event-bus-api.yaml .
EXPOSE 8080
ENTRYPOINT exec java -Djava.security.egd=file:/dev/./urandom -jar nakadi.jar

