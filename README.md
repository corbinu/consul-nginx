Consul Nginx
======================
This Docker container is setup to run Nginx with Consul for service discovery and health monitoring.

It has also been optimized to run on Joyent's [Triton](https://www.joyent.com/blog/understanding-triton-containers), however it will always also support strait Docker and boot2docker.

## Running

It can be run on its own simply via:

```
docker run -d  -p 8400 -p 8500 -p 8600 --name consul progrium/consul -server -bootstrap -ui-dir /ui
docker run -d --name lb1 --link consul:consul corbinu/consul-nginx

docker exec -it lb1 nginx-bootstrap
```

Consul will UI will be available on port mapped to 8500


## Consul notes

[Bootstrapping](https://www.consul.io/docs/guides/bootstrapping.html), [Consul clusters](https://www.consul.io/intro/getting-started/join.html), and the details about [adding and removing nodes](https://www.consul.io/docs/guides/servers.html). The [CLI](https://www.consul.io/docs/commands/index.html) and [HTTP](https://www.consul.io/docs/agent/http.html) API are also documented.

[Check for registered instances of a named service](https://www.consul.io/docs/agent/http/catalog.html#catalog_service)

```bash
curl -v http://consul:8500/v1/catalog/service/nginx | json -aH ServiceAddress
```

[Register an instance of a service](https://www.consul.io/docs/agent/http/catalog.html#catalog_register)

```bash
export MYIP=$(ip addr show eth0 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
curl http://consul:8500/v1/agent/service/register -d "$(printf '{"ID": "nginx-%s","Name": "nginx","Address": "%s"}' $MYIP $MYIP)"
```
