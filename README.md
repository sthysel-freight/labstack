# LABStack (Version 0.0.3)

![Full Stack Developer](docs/pics/fullstack.jpg)

LABStack is a curated and managed collection of IoT services and tools. The
stack runs in concert in a containerized environment. It allows the user to get
going with current best-of-breed services with minimum effort.

LABStack is intended to be deployed on a Raspberry Pi 3 or later running Arch
ARM Linux. LABStack works fine on Raspian or any other system running docker as
well.

Arch ARM is preferred as it is more up to date and performant, and seems a
better fit for a LAB environment, YMMV.

All services are shipped and managed in docker containers with persistent data
volumes.

# Usage

FullStack can be deployed as is on any existing linux machine with docker already
installed by

 - cloning this repo
 - run `./up.sh` in the `services` directory
 
This will download all the images and start the various stack services. 

For notes on prepping a new pi for LABStack on Arch see below. If yo just want
to stick with Raspian (which is perfectly fine), be sure to install docker and
docker-compose.

![Oi](docs/pics/pi.png)

# Services

LABStack running on server `labstack` provides

| Service   | Description                         | Port or URL          |
|-----------|-------------------------------------|----------------------|
| heimdall  | Service portal                      | http://labstack      |
| portainer | Container management                | http://labstack:9000 |
| influx    | Time series database                | 8086/8083/2003       |
| grafana   | Time series data visualization      | http://labstack:3000 |
| node-red  | IIOT message switch                 | http://labstack:1880 |
| mqtt      | MQTT Broker                         | tcp:labstack:1883    |
| telegraf  | System metrics harvester            |                      |
| rtl_433   | 433Mhz SDR Dongle message harvester |                      |

With a labstack system running you have most all infrastructure in place to
gather, process, visualize and persist data in your home IIOT LAB. Container
data is persisted in volumes and can be forwarded to a cloud hosted store if
needed.

See the [docker-compose](labstack/docker-compose.yml) file for detail.

## Heimdall

![Heindall Portal](docs/pics/heimdall.png)

Heimdall provides a landing page portal that allows you to configure all your
interesting landing pages once so you do not have to remember on which port each
service resides.

To get to a specific service browse to http://labstack and click on the relevant
service icon. See below on how to rename a typical raspberry pi based LABStack
server.

## Portainer

Use portainer to manage individual containers.

![Portainer Dashboard](docs/pics/portainer-dash.png)

![Portainer Containers](docs/pics/portainer-containers.png)


## Node-red

Nodered wired to MQTT allows message management, visualization and processing.

### rtl_433 traffic flow

![RTL 433](docs/pics/rtl_433.png)

The RTL_433 process uses a software defined radio dongle to receive wireless
sensor traffic on the 433Mhz band, and others, decodes the packets and submits
data messages to mqtt. Here node red picks up the message, transforms it to
influxdb line protocol and writes it to the influx time series database.

The function node example here transforms the rtl_433 message to something the
influx write node understands:

``` javascript
msg.topic="Prologue";
var orig = msg.payload;

msg.payload = [
    {
        temperature:orig.temperature_C,
        humidity:orig.humidity,
    },
    {
        battery:orig.battery,
        id:orig.id,
        rid:orig.rid,
        channel:orig.channel,
        model:orig.model,
    },
];

return msg; 
```

### External message source

![PAT](docs/pics/nodered-pat.png)

Feed flows in from any other available sources. Here is a another MQTT data
source.

### Plugins

The following plugins are available out of the box:

*  node-red-contrib-flightaware
*  node-red-contrib-alexa-local
*  node-red-contrib-bigtimer
*  node-red-contrib-blynk-ws
*  node-red-contrib-boolean-logic
*  node-red-contrib-config
*  node-red-contrib-diode
*  node-red-contrib-esplogin
*  node-red-contrib-file-function
*  node-red-contrib-grove
*  node-red-contrib-influxdb
*  node-red-contrib-isonline
*  node-red-contrib-moment
*  node-red-contrib-npm
*  node-red-contrib-owntracks
*  node-red-contrib-particle
*  node-red-contrib-ramp-thermostat
*  node-red-contrib-timeout
*  node-red-contrib-web-worldmap
*  node-red-dashboard
*  node-red-node-darksky
*  node-red-node-emoncms
*  node-red-node-geofence
*  node-red-node-google
*  node-red-node-openweathermap
*  node-red-node-pi-gpiod
*  node-red-node-ping
*  node-red-node-random
*  node-red-node-smooth
*  node-red-node-sqlite


## rtl_433

If a SDR dongle is plugged into the pi, this service will start harvesting
433Mhz messages and publish them to mqtt where node-red and grafana will process
and visualize them. They can also be persisted to the influx database.

## Grafana

![Grafana RTL Prologue](docs/pics/grafana.png)

Grafana is used to visualize data available from the influxdb and others. In
this example the RTL 433 data from the SDR dongle that was persisted to the
influx database is displayed.

# Scratch install

In short:

- install a labstack host, something like a recent pi
- Make use of the optional ansible roles to prep the pi for docker and keep
  things tight
- dotfiles to keep the pi environment sane
- docker-compose is used to maintain the service stack

## Prep SD card

From
[Archlinux|ARM](https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4)
install Arch on SD Card.


## Bootstrap the basics on the pi

Boot the pi, find it on the local LAN `$ nmap -sn 10.0.0.1/24`, its called
`alarmpi`, user `alarm`, root password is `root`, change if so inclined.

ssh to `alarmpi`

 - make a user, say `thys`
 - add `thys` to wheel using `visudo`

Like so:

```
# pacman -Syyu
# useradd -G wheel -m thys
# pacman -S sudo vim
# visudo
```

Change the server name to `labstack` for convenience:

```
$ sudo hostnamectl set-hostname labstack
```

## Run ansible over pi

Check out this repo on the pi and in the `ansible` directory run `./play`. To
run the playbook over the pi from another machine with ansible installed do`./play $PI_IP`

## Start the stack

Once ansible has run to completion start the stack in `~/labstack/labstack/` by running
`up.sh`.
