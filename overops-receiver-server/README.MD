# Overops Receiver Server
This is the helm chart for [OverOps](https://www.overops.com/) receiver server.

This is a V5 service that works with configured external queue service i.e. rabbitmq, kafka and the external database (mysql).

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!
* PV provisioner support in the underlying infrastructure

## Get Repo Info
```
helm repo add overops https://overops.github.io/helm-charts
helm repo update
```

## Install Chart
```console
# Helm 3 
$ helm install -n=overops  receiver overops/overops-receiver-server
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._


## Uninstall Chart

```console
# Helm
$ helm uninstal -n [NAMESPACE] [RELEASE_NAME] 

```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console

# Helm 3
$ helm show values overops/overops-receiver-server
```

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `overops.type`                               | Type of OverOps receiver to run as (rabbit, kafka)                                           | `RABBIT`                                             |
| `overops.loglevel`                           | Log Level for the deployment                                                                 | `INFO`                                               |
| `overops.auth.existingSecret`                | Name of an existing secret rather than creating a one.                                       | `nil`                                                |
| `overops.rabbitQueue.type`                   | Rabbit Queue configuration type (hit,decompiler,sql or custom)                               | `hit`                                                |
| `overops.rabbitQueue.customType`             | Overwrites the profile with a custom string                                                  | `nil`                                                |
| `overops.rabbitQueue.service`                | V5: Service or external hostname of the Rabbit MQ server                                     | `nil`                                                |
| `overops.rabbitQueue.port`                   | V5: Port of the Rabbit MQ server                                                             | `5672`                                               |
| `overops.rabbitQueue.username`               | V5: Username to authenticate to the Rabbit MQ Exchange                                       | `overops`                                            |
| `overops.rabbitQueue.password`               | V5: Password to authenticate to the Rabbit MQ Exchange                                       | `nil`                                                |
| `overops.rabbitQueue.exchange`               | V5: Exchange to use on the Rabbit MQ Server                                                  | `overops`                                            |
| `overops.agentSidecar.enabled`               | Enable the use of agent-sidecar init container instead of embedded agent.                    | `false`                                              |
| `overops.agentSidecar.repository`            | Agent Sidecar image repository.                                                              | `overops/agent-sidecar`                              |
| `overops.agentSidecar.pullPolicy`            | Agent Sidecar image pull policy.                                                             | `IfNotPresent`                                       |
| `overops.agentSidecar.tag`                   | Agent Sidecar image tag.                                                                     | `latest`                                             |
| `overops.agentSidecar.collectorHost`         | Agent Sidecar Collector hostname or K8s Service Name                                         | `nil`                                                |
| `overops.agentSidecar.collectorPort`         | Agent Sidecar Collector  Collector port                                                      | `6060`                                               |
| `overops.mysql.url`                          | mysql database url                                                                           | `nil`                                                |
| `overops.mysql.port`                         | mysql database port                                                                          | `3306`                                               |
| `overops.mysql.user`                         | Username of mysql database.                                                                  | `overops`                                            |
| `overops.mysql.password`                     | Password for the mysql user.                                                                 | `nil`                                                |
| `image.repository`                           | `overops-server` image repository.                                                           | `overops/server`                                     |
| `image.tag`                                  | `overops-server` image tag.                                                                  |  Pulled from chart.yaml                              |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `autoscaling.enabled`                        | Enable Autoscaling with KEDA                                                                 | `false`                                              |
| `autoscaling.pollingInterval`                | KEDA Setting see: https://keda.sh/                                                           | `5`                                                  |
| `autoscaling.cooldownPeriod`                 | KEDA Setting see: https://keda.sh/                                                           | `30`                                                 |
| `autoscaling.minReplicaCount`                | KEDA Setting see: https://keda.sh/                                                           | `0`                                                  |
| `autoscaling.maxReplicaCount`                | KEDA Setting see: https://keda.sh/                                                           | `10`                                                 |
| `autoscaling.targetQueueLength`              | KEDA RabbitMQ Scaler Setting for target Queue Length                                         | `5`                                                  |
