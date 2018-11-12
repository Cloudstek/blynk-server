# Blynk Server

[![](https://images.microbadger.com/badges/image/cloudstek/blynk-server.svg)](http://microbadger.com/images/cloudstek/blynk-server
"Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/cloudstek/blynk-server.svg)](http://microbadger.com/images/cloudstek/blynk-server
"Get your own version badge on microbadger.com")

[Blynk](http://www.blynk.cc) is the most popular mobile app for the IOT. Works with anything: ESP8266, Arduino, Raspberry Pi, SparkFun and others.

With this Docker image you can run your own private [Blynk](http://www.blynk.cc) server without relying on the public [Blynk](http://www.blynk.cc) cloud server.

### Exposed ports

- **8080** - HTTP
- **9443** - HTTPS

### Volumes

- **/data** - Storage of data
- **/config** - Custom configuration files

## How to run

Simply start a container:

```sh
docker run cloudstek/blynk-server:latest
```

To forward IP ports from the host to the container, do this:

```sh
docker run -p 8080:8080 -p 9443:9443 cloudstek/blynk-server:latest
```

To persist data, mount a directory into the container on `/data`:

```sh
docker run -v $(PWD):/data cloudstek/blynk-server:latest
```

To include your own [server.properties](https://github.com/blynkkk/blynk-server/blob/master/server/core/src/main/resources/server.properties) / [mail.properties](https://github.com/blynkkk/blynk-server/blob/master/server/notifications/email/src/main/resources/mail.properties) / [sms.properties](https://github.com/blynkkk/blynk-server/blob/master/server/notifications/sms/src/main/resources/sms.properties) file(s), mount them into `/config`:

```sh
docker run -v $(PWD)/server.properties:/config/server.properties -v $(PWD)/server.properties:/config/mail.properties -v $(PWD)/server.properties:/config/sms.properties cloudstek/blynk-server:latest
```

## Building the image

In case you want to modify and/or build the image yourself. Clone the repository and run:

```sh
docker build --pull .
```

This will pull the latest base image (Open JDK) and build the Blynk server image. To change the Blynk server version simply change the `BLYNK_SERVER_VERSION` env var:

```sh
docker build --pull --build-arg BLYNK_SERVER_VERSION=<BLYNK SERVER VERSION> .
```

