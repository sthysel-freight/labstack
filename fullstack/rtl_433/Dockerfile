FROM debian:buster-slim

ENV MQTT_ADDRESS mqtt
ENV MQTT_PORT 1883
ENV MQTT_USER ""
ENV MQTT_PASSWORD ""
ENV MQTT_TOPIC RTL_433

RUN apt-get update && \
  apt-get install -y  \
  git \
  libtool \
  libusb-1.0.0-dev \
  librtlsdr-dev \
  rtl-sdr \
  cmake \
  automake

RUN git clone https://github.com/merbanan/rtl_433.git /tmp/rtl_433 && \
	cd /tmp/rtl_433/ && \
	mkdir build && \
	cd build && \
	cmake ../ && \
	make && \
	make install

CMD ["sh", "-c", "rtl_433 -F mqtt://${MQTT_ADDRESS}:${MQTT_PORT},events=${MQTT_TOPIC},user=${MQTT_USER},pass=${MQTT_PASSWORD}"]
