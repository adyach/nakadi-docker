# Why and where
- There is no official docker image for Nakadi
- Published in docker hub registry: https://hub.docker.com/r/adyach/nakadi-docker

# How to run it
## Using Nakadi project provided dependencies
Download [Nakadi](https://github.com/zalando/nakadi/releases) and start its dependencies
```
./gradlew startStorages
```
Start Nakadi docker container using `host` network (dependencies are running in host network)
```
docker run -e SPRING_PROFILES_ACTIVE=local -e NAKADI_OAUTH2_MODE=OFF --network=host adyach/nakadi-docker:latest
```

Start Nakadi with [file based authz](https://github.com/adyach/nakadi-authz-file-plugin)
```
docker run \
-e SPRING_PROFILES_ACTIVE=local \
-e NAKADI_OAUTH2_MODE=OFF \
-e NAKADI_PLUGINS_AUTHZ_FACTORY=org.crazycoder.nakadiauthzfileplugin.FileAuthorizationServiceFactory \
-p 8080:8080 -t adyach/nakadi-docker:latest
```
Note: [authz config is used](https://github.com/adyach/nakadi-docker/blob/master/data/authz.json). it is not possible to configure UID of an oauth2 token, when running Nakadi in NAKADI_OAUTH2_MODE=OFF, that's why the [UID is allways `adminClientId`](https://github.com/zalando/nakadi/blob/effb2ed7e95bd329ab73ce06b2857aa57510e539/src/main/java/org/zalando/nakadi/security/ClientResolver.java#L27).
It should be possible to replace authz.json in container using `-v` option [docker volumes](https://docs.docker.com/storage/volumes)

## Using docker compose
Note: the setup was tested against [integration smoke test](https://github.com/zalando/nakadi/blob/167c0c1206b83128f5ec16b5808d54ec20c75c82/src/acceptance-test/java/org/zalando/nakadi/webservice/UserJourneyAT.java)
```
docker-compose up
```
