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
# Install Collector connecting to OverOps SaaS (Default)
helm install -n=overops --set overops.serviceKey=[YOUR-KEY] collector overops/overops-collector

# OR Install Collector connecting to On-Prem OverOps Backend and Storage servers
helm install -n=overops --set overops.serviceKey=[YOUR-KEY] --set overops.backendURL=[YOUR-BACKEND-URL] --set overops.storageTestURL=[YOUR-STORAGE-URL]  collector overops/overops-collector

# OR if Backend was installed in the same cluster use the Helm Release name
helm install -n=overops --set overops.serviceKey=[YOUR-KEY] --set overops.backendReleaseName=[BACKEND-RELEASE-NAME] collector overops/overops-collector
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

=======
| Parameter                                      | Description                                                                                  | Default                                              |
| --------------------------------------------   | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `overops.serviceKey`                           | Service Key for the collector                                                                | `nil`                                                |
| `overops.installToken`                         | Install Token used with MEC                                                                  | `nil`                                                |
| `overops.backendURL`                           | URL Address for the Backend Server.                                                          | `Defaults to OverOps SaaS`                           |
| `overops.storageTestURL`                       | URL Address for the Storage Test endpoint.                                                   | `Defaults to OverOps SaaS`                           |
| `overops.backendReleaseName`                   | Helm Release Name for the Backend Server. (Only if Backend is in the same K8s namespace).    | `nil`                                                |
| `overops.storageReleaseName`                   | Helm Release Name for the Storage Server. (Only if Storage Server is in the same K8s namespace).    | `nil`                                         |
| `overops.serverName`                           | Collector Name (Appears on backend server)                                                   | `pod name`                                           |
| `overops.jvmHeapSize`                          | Collector JVM Heap Size (Overops collector requires 4G)                                      | `1G`                                                 |
| `image.repository`                             | `overops-collector` image repository.                                                        | `overops/collector`                                  |
| `image.tag`                                    | `overops-collector` image tag.                                                               |  Pulled from chart.yaml                              |
| `image.pullPolicy`                             | Image pull policy                                                                            | `IfNotPresent`                                       |
| `service.loadBalancerType`                     | Adds Service Loadbalancer Annotation for required Loadbalancer Types (i.e. "nlb")            | `nil`                                                |
| `persistence.enabled`                          | Enables persistence storage for the collectors "work" directory                              | `false`                                              |
| `persistence.accessModes`                      | Persistence storage Access Mode                                                              | `- ReadWriteOnce`                                    |
| `persistence.size`                             | Persistence storage Size                                                                     | `1Gi`                                                |
| `autoscaling.enabled`                          | Enable Horizontal Pod Autoscaling                                                            | `false`                                              |
| `autoscaling.minReplicas`                      | The minimum allowed replicas                                                                 | `1`                                                  |
| `autoscaling.maxReplicas`                      | The maximum allowed replicas                                                                 | `10`                                                 |
| `autoscaling.targetCPUUtilizationPercentage`   | CPU utilization target                                                                       | `70`                                                 |
| `autoscaling.targetMemoryUtilizationPercentage`| Memory utilization target                                                                    | `70`                                                 |

## Single Environment vs Multi-Environment Collectors

In a typical single collector environment, a `overops.serviceKey` is provided to the collector to identify which environment will be used on the backend. Collector also supports multi-environment
configuration by using the `overops.installToken`. This is described, in detail on the [Overops Doc page](https://doc.overops.com/docs/multi-environment-collector)

When using the helm chart, use either a `serviceKey` or `installToken` based on your desired configuration. If both are given, the collector will use the `installToken`.

## Overops Collector resources
 We usually recommend not to specify default resources and to leave this as a conscious
 choice for the user. This also increases chances charts run on environments with little
 resources, such as Minikube.
 If you do want to specify resources, adjust them to Overops collector pre requirements, as described [here](https://doc.overops.com/docs/overops-installation-requirements#section-collector-system-requirements) .

 ```
 resources:
   requests:
     memory: "4G"
     cpu: "2"
   limits:
     cpu: "4"
     memory: "8G"
 ```

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

## Storage
By default the collector helm chart deploys the collector as a Deployment without storage, to enable storage use the `persistence` section
of the values.yaml. This will deploy the collector as a Stateful Set persisting the "work" directory used by the collector.

## Extra Configuration
The helm chart allows for extra advanced configuration changes to overops-collector's configMap, for the file `collector.properties`.
For additional config entries to the `collector.properties` update the yaml as follows:

```yaml
overops:
  extraCollectorProperties: |-
    takipi.http.proxy=http://myproxy.com
    takipi.https.proxy=https://myproxy.com
```
