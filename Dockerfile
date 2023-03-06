FROM ubuntu:18.04 as Downloader

WORKDIR /downloader

RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/freyacodes/Lavalink/releases/download/3.7.4/Lavalink.jar -o Lavalink.jar
RUN curl -L https://raw.githubusercontent.com/freyacodes/Lavalink/master/LavalinkServer/application.yml.example -o application.yml

FROM azul/zulu-openjdk-alpine:17-jre as Runner

WORKDIR /opt/Lavalink

COPY --from=Downloader /downloader/ /opt/Lavalink/

CMD [ "java", "-jar", "Lavalink.jar" ]