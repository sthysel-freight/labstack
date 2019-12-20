# FullStack (Version 0.0.1)

![Full Stack Developer](docs/pics/fullstack.jpg)

FullStack is a curated and managed collection of IoT services and tools. It
allows the user to get going with current best-of-breed services with minimum
effort.

FullStack is intended to be deployed on a Raspberry Pi 3 or later running Arch
ARM Linux. FullStack will work fine on Raspian as well. Arch ARM
is preferred as it is more up to date and performant, and seems a better fit for
a LAB environment, YMMV.

All services are shipped and managed in docker containers with persistent data
volumes.

FullStack can be deployed as is on a existing linux machine with docker already
installed by

 - cloning this repo
 - run `./up.sh` in the `services` directory
 
This will download all the images and start the various stack services.

In short:

- ansible is used to prep the pi for docker and keep things tight
- dotfiles to keep the pi environment sane
- docker-compose is used to maintain the service stack

# Services

Fullstack running on server `fullstack` provides

| Service   | Description                    | Port or URL          |
|-----------|--------------------------------|----------------------|
| portainer | Container management           | http://labstack:9000 |
| influx    | Time series database           | 8086/8083/2003       |
| grafana   | Time series data visualization | http://labstack:3000 |
| nodered   | MQTT message switch            | http://labstack:1880 |
| mqtt      | MQTT Broker                    | 1883                 |
| telegraf  | System metrics harvester       |                      |



## Portainer

![Portainer Dashboard](docs/pics/portainer-dash.png)

![Portainer Containers](docs/pics/portainer-containers.png)

## Nodered

![PAT](docs/pics/nodered-pat.png)

# Install

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

## Run ansible over pi

Check out this repo on the pi and in the `ansible` directory run `./play`. To
run the playbook over the pi from another machine with ansible installed do`./play $PI_IP`

## Start the stack

Once ansible has run to completion start the stack in `~/packstack` by running
`up.sh`.
