#!/bin/bash -eu
#
# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Gets the latest version of Docker-compose

set -e

LATEST_RELEASE=$( curl -L https://github.com/docker/compose/releases | grep releases/tag | grep -v '\-rc[0-9]' | head -1 | sed -e 's/^.*href="//' -e 's/".*$//' | sed -e 's/\/docker\/compose\/releases\/tag\///' )
echo Latest release: $LATEST_RELEASE

DOCKER_COMPOSE_URL=https://github.com/docker/compose/releases/download/${LATEST_RELEASE}/docker-compose-`uname -s`-`uname -m`
echo Loading from : $DOCKER_COMPOSE_URL

sudo curl -L $DOCKER_COMPOSE_URL  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
