#!/bin/bash

echo "Create a db: CREATE DATABASE myname"
echo "Show existing a databases: SHOW DATABASES"
echo "Use a db: USE myname"
echo "To exit type: EXIT"
echo ""

docker exec -it influxdb influx
