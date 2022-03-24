# dns-forwarder

[![lisegmbh/dns-forwarder](https://badgen.net/badge/Source/%F0%9F%8D%83lisegmbh%2Fdns-forwarder/gray?icon=github)](https://github.com/lisegmbh/dns-forwarder)

A minimal dns server that relays incoming queries to an upstream server.

The container listens on port 53 (tcp/udp) and forwards incoming DNS queries to one or more upstream DNS servers.
This can be useful in scenarios where the authoritative name servers can not be reached directly by dependent DNS clients.  

## Usage

```shell
docker run -d -p 53:53/udp -p 53:53/tcp -e UPSTREAMS="8.8.8.8" lisegmbh/dns-forwarder
```

## Available tags
This image uses the following tag schema.
```
<BIND_VERSION>[-<DISTRO><DISTRO_VERSION>]
```

- `:latest`, `:9.16`, `:9.16-alpine3.15.2`  

## Configuration
You can configure the forwarder by overwriting the following environment variables.

| Name          | Description                                                   | Default                           |
| :---          | :---                                                          | :---                              |
| `UPSTREAM`    |  Space separated list of upstream DNS server IPs to be used.  | `1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4` |
| `PORT`        | The port number the DNS forwarder will listen on.             | `53`                              |

## Examples

### Azure DNS
If one wants to provide Azure hostname resolution to on-premises computers (e.g. connected by an Azure VPN Gateway),
the following container could be deployed as a DNS proxy.
It will forward incoming requests to Azure's internal virtual DNS server address (`168.63.129.16`).

```shell
docker run -d -p 53:53/udp -p 53:53/tcp -e UPSTREAMS="168.63.129.16" lisegmbh/dns-forwarder
```

Further reading:
- [Azure docs: Name resolution szenario table](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
- [Azure docs: Name resolution that uses your own DNS server](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances#name-resolution-that-uses-your-own-dns-server)


## Mentions
This image has been inspired by 
- UQ eResearch Group - dnsrelay ([GitHub](https://github.com/uq-eresearch/docker-dnsrelay), [dockerhub](https://hub.docker.com/r/uqeresearch/dnsrelay))