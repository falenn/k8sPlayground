# Demo showing Docker Monitoring with Prometheus / CAdvisor

## Reference
[https://prometheus.io/docs/guides/cadvisor/]
[https://github.com/grafana/grafana/blob/master/devenv/docker/ha_test/docker-compose.yaml]

## URLs
Connect to cAdvisor:  [http://localhost:8080]
Connect to Prometheus: [http://localhost:9090]
Connect to Grafana:   [http://localhost:3000]

## Startup
Run `sudo docker-compose up &` 
This starts up the docker compose solution with 3 Docker images:
* cAdvisor
* Prometheus
* Redis

Prometheus is configured to query cAdvisor for info from Docker.
Redis is an example app emitting metrics.

## Prometheus

### Sample queries in Prometheus

#### CPU Time by ContainerName
rate(container_cpu_usage_seconds_total{name="redis"}[1m]))

#### Total CPU time by ContainerName
sum(rate(container_cpu_usage_seconds_total{name="redis"}[1m])) by (app) 
