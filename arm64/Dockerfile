FROM arm64v8/openjdk:11.0.6-jdk-stretch as builder

MAINTAINER andrey.dyachkov@gmail.com

RUN mkdir nakadi
WORKDIR /nakadi
RUN apt-get update && apt-get install -y curl wget jq tar git
RUN git clone https://github.com/zalando/nakadi.git .
RUN wget -O nakadi-authz-file-plugin-0.2.jar https://github.com/adyach/nakadi-authz-file-plugin/releases/download/v0.2.2/nakadi-authz-file-plugin-0.2.2.jar
RUN cp nakadi-authz-file-plugin-0.2.jar plugins/nakadi-authz-file-plugin-0.2.jar
RUN chmod u+x gradlew
RUN ./gradlew assemble

FROM arm64v8/openjdk:11.0.6-jdk-slim

# configure Nakadi
COPY --from=builder /nakadi/app/build/libs/app.jar nakadi.jar
COPY --from=builder /nakadi/app/api/nakadi-event-bus-api.yaml ./api/nakadi-event-bus-api.yaml

# file based authz config
COPY --from=builder /nakadi/plugins/nakadi-authz-file-plugin-0.2.jar ./plugins/nakadi-authz-file-plugin-0.2.jar
COPY ./data/authz.json /data/authz.json
ENV NAKADI_AUTHZ_FILE_PLUGIN_AUTHZ_FILE=/data/authz.json

EXPOSE 8080
ENTRYPOINT exec java -Dloader.path=plugins -Djava.security.egd=file:/dev/./urandom -jar nakadi.jar
