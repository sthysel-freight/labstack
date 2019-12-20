FROM nodered/node-red:latest

# install all nodes you need in container
# node-red-contrib-home-assistant-websoc

RUN npm install \
  node-red-contrib-flightaware \
  node-red-contrib-alexa-local \
  node-red-contrib-bigtimer \
  node-red-contrib-blynk-ws \
  node-red-contrib-boolean-logic \
  node-red-contrib-config \
  node-red-contrib-diode \
  node-red-contrib-esplogin \
  node-red-contrib-file-function \
  node-red-contrib-grove \
  node-red-contrib-influxdb \
  node-red-contrib-isonline \
  node-red-contrib-moment \
  node-red-contrib-npm \
  node-red-contrib-owntracks \
  node-red-contrib-particle \
  node-red-contrib-ramp-thermostat \
  node-red-contrib-timeout \
  node-red-contrib-web-worldmap \
  node-red-dashboard \
  node-red-node-darksky \
  node-red-node-emoncms \
  node-red-node-geofence \
  node-red-node-google \
  node-red-node-openweathermap \
  node-red-node-pi-gpiod \
  node-red-node-ping \
  node-red-node-random \
  node-red-node-smooth \
  node-red-node-sqlite

RUN npm audit fix
