# Copyright (C) 2022  lise GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses>.
ARG ALPINE_VERSION=3.15.2
FROM alpine:$ALPINE_VERSION

ARG BIND_VERSION=9.16
# Download BIND and tini
RUN apk add --update --no-cache \
    "bind~=$BIND_VERSION" \
    tini \
    && rm -rf /var/cache/apk/*

# Copy setup script
COPY opt/dns-forwarder /opt/dns-forwarder
RUN chmod +x /opt/dns-forwarder/run.sh

# Default settings
ENV UPSTREAMS="1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4"
ENV PORT="53"

# Start
ENTRYPOINT ["/sbin/tini", "--",  "/opt/dns-forwarder/run.sh"]