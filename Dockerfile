FROM curlimages/curl:latest as Downloader

WORKDIR /downloader

RUN curl -L https://github.com/freyacodes/Lavalink/releases/download/3.7.4/Lavalink.jar -o Lavalink.jar
RUN curl -L https://raw.githubusercontent.com/freyacodes/Lavalink/master/LavalinkServer/application.yml.example -o application.yml

COPY . .

FROM azul/zulu-openjdk-alpine:17-jre as Runner

WORKDIR /opt/Lavalink

COPY --from=Downloader /downloader/ /opt/Lavalink/

CMD [ "java", "-jar", "Lavalink.jar" ]