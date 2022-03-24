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

rm /etc/bind/*

cat <<CONF > /etc/bind/named.conf
options {
  directory "/var/bind";
  forwarders {
CONF

SAVEIFS=$IFS
IFS=' '
for upstream in $UPSTREAMS
do
  echo "    $upstream;" >> /etc/bind/named.conf
done
IFS=$SAVEIFS


cat <<CONF >> /etc/bind/named.conf
  };
  listen-on port $PORT { any; };
  allow-query { any; };
  allow-recursion { any; };
  allow-transfer { none; };
  auth-nxdomain no;    # conform to RFC1035
};
controls {}; # Disable RNDC
CONF

echo "### Starting with config:"
cat /etc/bind/named.conf
echo "###"

exec /usr/sbin/named -4 -g