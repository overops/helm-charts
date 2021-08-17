# Overops Collector Chart
This is the main Collector chart for [OverOps](https://www.overops.com/) deployment. It is based on the Overops docker releases of the collector found [here](https://hub.docker.com/r/overops/collector). 

The collector can be deployed into the same namespace as an Overops Backend Server or configured to work with a remote one.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!

## Get Repo Info
```
helm repo add overops https://overops.github.io/helm-charts
helm repo update
```

## Install Chart
```console
# Helm 3 (Updating the fields)
$ helm install -n=overops --set overops.serviceKey=[YOUR-KEY] --set overops.backendURL=[YOUR-BACKEND-URL]  myoverops overops/overops-collector
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
$ helm show values overops/overops-collector
```

The following table lists the configurable parameters of the OverOps Collector chart and their default values. This is not a complete list, additional values can be found by inspecting the respected chart.

| Parameter                                      | Description                                                                                  | Default                                              |
| -----------------------------------------------| -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `overops.serviceKey`                           | Service Key for the collector *                                                              | `nil`                                                |
| `overops.backendURL`                           | URL Address for the Backend Server.                                                          | `Defaults to local deployed backend`                 |
| `overops.storageTestURL`                       | URL Address for the Storage Test endpoint.                                                   | `Defaults to local deployed backend`                 |
| `overops.serverName`                           | Collector Name (Appears on backend server)                                                   | `pod name`                                           |
| `overops.jvmHeapSize`                          | Collector JVM Heap Size                                                                      | `1G`                                                 |
| `image.repository`                             | `overops-collector` image repository.                                                        | `overops/collector`                                  |
| `image.tag`                                    | `overops-collector` image tag.                                                               |  Pulled from chart.yaml                              |
| `image.pullPolicy`                             | Image pull policy                                                                            | `IfNotPresent`                                       |
| `service.loadBalancerType`                     | Adds Service Loadbalancer Annotation for required Loadbalancer Types (i.e. "nlb")            | `nil`                                                |
| `autoscaling.enabled`                          | Enable Horizontal Pod Autoscaling                                                            | `false`                                              |
| `autoscaling.minReplicas`                      | The minimum allowed replicas      	                                                          | `1`                                                  |
| `autoscaling.maxReplicas`                      | The maximum allowed replicas                                                                 | `false`                                              |
| `autoscaling.targetCPUUtilizationPercentage`   | CPU utilization target                                                                       | `70`                                                 |
| `autoscaling.targetMemoryUtilizationPercentage`| Memory utilization target                                                                  | `70`                                                 |

_*: Indicates parameters that need to be set.

## Ingress / Service Support

The OverOps collector uses a TCP port (Defaults 6060) for communication with an agent, therefore if a collector requires connections external to a cluster
configuration specific to an Ingress Controller is required or another method is needed (NodePort, LoadBalancer). TCP is not directly supported by 
the networking.k8s.io Ingress spec.

For exposing the service on AWS the recommended method is using type `LoadBalancer` and use the AWS Network Load Balancer to do this use the follow values:

```
service:
  loadBalancerType: nlb
  type: LoadBalancer
```
