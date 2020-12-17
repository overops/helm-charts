# Overops Storage Server Chart
This is the main Storage Server chart for [OverOps](https://www.overops.com/) deployment. It is based on the Overops docker releases of the Storage Server found [here](https://hub.docker.com/r/overops/storage-server).

The Storage Server can be deployed into the same namespace as a Collector or configured to work with a remote one.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!

## Get Repo Info
```
helm repo add overops https://overops.github.io/helm-charts
helm repo update
```

## Install Chart
```console
# Helm 3 
$ helm install -n=overops storage overops/overops-storage-server
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
$ helm show values overops/overops-storage-server
```

The following table lists the configurable parameters of the OverOps Storage Server chart and their default values. This is not a complete list, additional values can be found by inspecting the respected chart.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `overops.maxUsedStoragePercentage`           | Max Storage Percentage Used                                                                  | `0.90`                                               |
| `overops.retentionPeriodDays`                | Number of days after which events last seen are to be deleted.                               | `92`                                                 |
| `overops.cleanupJobEnabled`                  | Enables Storage Server clean up task                                                         | `true`                                               |
| `overops.cleanupJobInterval`                 | Clean up task interval                                                                       | `6h`                                                 |
| `image.repository`                           | `overops-storage-server` image repository.                                                   | `overops/storage-server`                             |
| `image.tag`                                  | `overops-storage-server` image tag.                                                          |  Pulled from chart.yaml                              |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `persistence.size`                           | Persistence Volume Claim Size                                                                | `20Gi`                                               |

_More Storage Server setting info can be found [here](https://doc.overops.com/docs/storage-server-cleanup-task-to-free-up-space)._

## Ingress Support

The OverOps Storage server communicates with clients using an http endpoint that can be exposed using an ingress. Below is an example `values.yaml` which includes an Ingress using nginx:

```
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - host: overops.test
      paths:
        - "/storage"
```

## Setting up Hybrid Storage

Once deployment steps must be made to enable hybrid storage for a given OverOps environment. Instructions can be found [here](https://doc.overops.com/docs/enabling-storage-server-connectivity-over-http)
