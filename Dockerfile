FROM openjdk:11-jre-slim
MAINTAINER Maarten de Boer <maarten@cloudstek.nl>

# Wget
RUN apt-get update && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir /blynk /data /config

# Download Blynk
ENV BLYNK_SERVER_VERSION 0.41.0
RUN wget -q -O /blynk/server.jar https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}.jar

# Download default configuration
RUN wget -q -O /config/server.properties https://raw.githubusercontent.com/blynkkk/blynk-server/v${BLYNK_SERVER_VERSION}/server/core/src/main/resources/server.properties
RUN wget -q -O /config/mail.properties https://raw.githubusercontent.com/blynkkk/blynk-server/v${BLYNK_SERVER_VERSION}/server/notifications/email/src/main/resources/mail.properties
RUN wget -q -O /config/sms.properties https://raw.githubusercontent.com/blynkkk/blynk-server/v${BLYNK_SERVER_VERSION}/server/notifications/sms/src/main/resources/sms.properties

# Create volumes
VOLUME ["/config", "/data"]

# Expose ports
# 8080: Hardware without ssl/tls support
# 9443: Blynk app, https, web sockets, admin port
EXPOSE 8080 9443

WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data", "-serverConfig", "/config/server.properties", "-mailConfig", "/config/mail.properties", "-smsConfig", "/config/sms.properties"]
