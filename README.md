## REDSCAN-SSLSCAN

| Attribute     | Value                                        |
| ------------- | -------------------------------------------- |
| Subscribe to  |  FANOUT_HTTP_SERVICE_EXCHANGE_NAME           |
| Send to       |  FANOUT_VULNERABILITIES_EXCHANGE_NAME        |
| Tools used    |               SSl Scan                       |
| Configuration | /conf/log4j2.xml : Log4j2 configuration file |

### Objective

Identifies and inspect SSL/TLS/Certificate configuration on HTTP Service.

### Description

Use SSl scan ot gather intel on certificate and on SSL/TLS. Send vulnerability accordingly:

- *obs_prot* : Obsolete protocol. eg: SSL
- *obs_prot_vers* : Obsolete protocol version. eg: TLS1.0
- *heartbleed* : Heartbleed
- *weak_key* : insufficient Key strenght < 2048
- *autosigned* : If certificate is self-signed
- *expired* : if certificate date is in the past. 

### How to develop

WARNING: For dev you need to change the condition to check if the target is SSL (changed it to if (true))

```
docker run -d -p 5672:5672 -p 15672:15672 --name redscan-rabbit-dev rabbitmq:3-management
docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" --name redscan-elasticsearch-dev docker.elastic.co/elasticsearch/elasticsearch:7.10.1

# If cache is required for the plugin
docker run -d -p 8080:8080 --name redscan-cache-dev docker.pkg.github.com/certmichelin/redscan-cache/redscan-cache:latest
```
