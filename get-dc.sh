#!/bin/bash

set -e

LATEST_RELEASE=$( curl -L https://github.com/docker/compose/releases | grep releases/tag | grep -v '\-rc[0-9]' | head -1 | sed -e 's/^.*href="//' -e 's/".*$//' | sed -e 's/\/docker\/compose\/releases\/tag\///' )
echo Latest release: $LATEST_RELEASE

DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/${LATEST_RELEASE}/docker-compose-`uname -s`-`uname -m`
echo Loading from : $DOCKER_COMPOSE_URL

sudo curl -L $DOCKER_COMPOSE_URL  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
