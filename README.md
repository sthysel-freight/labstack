# LABStack (Version 0.0.1)

LABStack is a IOT enabling collection of services and tools. It allows the user
to get going with a full set of modern and convenient tools with very little
effort.

LABStack is intended to be deployed on a Raspberry Pi 3 or later running Arch
ARM with a predominantly docker hosted stack of usefull LAB IIOT Tools.

LABStack will work fine on Raspian as well, Arch ARM is preferred as it is more
up to date and performant, and seems a better fit for a LAB environment.

In short:

- ansible is used to prep the pi for docker and keep things tight
- dotfiles to keep the pi environment sane
- docker-compose is used to maintain the service stack

LABStack running on server `labstack` provides

| Service   | Description                    | Port or URL          |
|-----------|--------------------------------|----------------------|
| portainer | Container management           | http://labstack:9000 |
| mqtt      | MQTT Broker                    | 1883                 |
| influx    | Time series database           | 8086/8083/2003       |
| telegraf  | System metrics harvester       |                      |
| grafana   | Time series data visualization | http://labstack:3000 |
| nodered   | MQTT message swicth            | http://labstack:1880 |


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
