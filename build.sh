#!/usr/bin/env sh
#  Copyright (C) 2022  lise GmbH
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses>.

ALPINE_VERSION=3.15.2
BIND_VERSION=9.16

docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \
  --build-arg ALPINE_VERSION=$ALPINE_VERSION \
  --build-arg BIND_VERSION=$BIND_VERSION \
  -t lisegmbh/dns-forwarder:$BIND_VERSION-alpine$ALPINE_VERSION \
  -t lisegmbh/dns-forwarder:$BIND_VERSION \
  -t lisegmbh/dns-forwarder:latest \
  --push \
  .