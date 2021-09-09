# Overops Collector V5 Chart
This is the main Collector chart for [OverOps](https://www.overops.com/) deployment. It is based on the Overops docker releases of the collector found [here](https://hub.docker.com/r/overops/collector).

The collector can be deployed into the same namespace as an Overops Backend Server or configured to work with a remote one.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!

## Get Repo Info
```
helm repo add overops helm repo add overops-v5 s3://overops-v5-helm/v5/
helm repo update
```

## Install Chart
```console
# Helm 3 (Updating the fields)
$ helm install -n=overops --set overops.serviceKey=[YOUR-KEY] --set overops.backendURL=[YOUR-BACKEND-URL]  myoverops overops-v5/overops-collector
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._


## Uninstall Chart

```console
# Helm 3
$ helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console

# Helm 3
$ helm show values overops-v5/overops-collector
```

The following table lists the configurable parameters of the OverOps Collector chart and their default values. This is not a complete list, additional values can be found by inspecting the respected chart.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `overops.installationKey`                    | Installation Key for the collector                                                           | `nil`                                                |
| `overops.installationToken`                  | Installation Token used with MEC                                                             | `nil`                                                |
| `overops.backendURL`                         | URL Address for the Backend Server.                                                          | `Defaults to local deployed backend`                 |
| `overops.storageTestURL`                     | URL Address for the Storage Test endpoint.                                                   | `Defaults to local deployed backend`                 |
| `overops.collectorName`                      | Collector Name (Appears on backend server)                                                   | `pod name`                                           |
| `overops.extraCollectorProperties`           | Additional Configuration (See Section)                                                       | `nil`                                                |
| `overops.agentSidecar.enabled`               | Enable the use of agent-sidecar init container instead of embedded agent.                    | `false`                                              |
| `overops.agentSidecar.repository`            | Agent Sidecar image repository.                                                              | `overops/agent-sidecar`                              |
| `overops.agentSidecar.pullPolicy`            | Agent Sidecar image pull policy.                                                             | `IfNotPresent`                                       |
| `overops.agentSidecar.tag`                   | Agent Sidecar image tag.                                                                     | `latest`                                             |
| `overops.agentSidecar.collectorURL`          | Agent Sidecar Collector URL                                                                  | `nil`                                                |
| `overops.agentSidecar.applicationName`       | Agent Sidecar Application Name to display on OverOps (Automatically detected if not set)     | `nil`                                                |
| `overops.agentSidecar.deploymentName`        | Agent Sidecar Deployment Name to display on OverOps (Automatically detected if not set)      | `nil`                                                |
| `overops.agentSidecar.serverName`            | Agent Sidecar Server Name to display on OverOps (Automatically detected if not set)          | `nil`                                                |
| `overops.agentSidecar.environmentName`       | Agent Sidecar Environment Name to display on OverOps (Automatically detected if not set)     | `nil`                                                |
| `overops.agentSidecar.agentProperties`       | Extended configuration settings to be added to `agent.properties` file                       | see [values](values.yaml)                            |
| `image.repository`                           | `overops-collector` image repository.                                                        | `overops/collector`                                  |
| `image.tag`                                  | `overops-collector` image tag.                                                               |  Pulled from chart.yaml                              |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |

| `autoscaling.enabled`                        | Enable Horizontal Pod Autoscaling                                                            | `false`                                              |
| `autoscaling.minReplicas`                    | The minimum allowed replicas                                                                 | `1`                                                  |
| `autoscaling.maxReplicas`                    | The maximum allowed replicas                                                                 | `10`                                                 |
| `autoscaling.targetCPUUtilizationPercentage` | CPU utilization target                                                                       | `70`                                                 |
| `autoscaling.targetMemoryUtilizationPercentage`| Memory utilization target                                                                  | `70`                                                 |

## Single Environment vs Multi-Environment Collectors

In a typical single collector environment, a `overops.installationKey` is provided to the collector to identify which environment will be used on the backend. Collector also supports multi-environment
configuration by using the `overops.installationToken`. This is described, in detail on the [Overops Doc page](https://doc.overops.com/docs/multi-environment-collector)

When using the helm chart, use either a `installationKey` or `installationToken` based on your desired configuration. If both are given, the collector will use the `installationToken`.

## Extra Configuration
The helm chart allows for extra configuration changes to overops-collector's configMap, for the file `collector.properties`.
For additional config entries to the `collector.properties` update the yaml as follows:

```yaml
overops.extraCollectorProperties: |-
  MY_PROPERTY1=A
  MY_PROPERTY2=B
  MY_PROPERTY3=C
```
