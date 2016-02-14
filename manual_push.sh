#!/bin/sh

set -e

docker build -t weka-docker-telegraf ./
docker tag weka-docker-telegraf:latest wekaio/docker-telegraf:latest
docker push wekaio/docker-telegraf
