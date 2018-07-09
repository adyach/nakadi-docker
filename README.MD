# Why and where
- There is no official docker image for Nakadi
- Published in docker hub registry: https://hub.docker.com/r/adyach/nakadi-docker

# How to run it
## Using Nakadi project provided dependencies
Download [Nakadi](https://github.com/zalando/nakadi/releases) and start its dependencies
```
./gradlew startStorages
```
Srart Nakadi docker container using `host` network (dependencies are running in host network)
```
docker run -e SPRING_PROFILES_ACTIVE=local -e NAKADI_OAUTH2_MODE=OFF --network=host adyach/nakadi-docker:latest
```
