# Overops Chart
This is the main umbrella helm chart for [OverOps](https://www.overops.com/) deployment stack. It is based on the Overops docker releases of various components found [here](https://hub.docker.com/r/overops/). 

This chart pulls in each Overops component and can be configured to install individual or the full deployment. This includes:

* [Overops Collector](../overops-collector/README.MD)
* [Overops Backend Server](../overops-server/README.MD) ( Including supporting database)

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
# Helm 3 (Updating the fields)
$ helm install -n=overops --render-subchart-notes --set overops-server.overops.defaultUserPass=[YOUR-PASSWORD] --set overops-server.overops.defaultUserServiceKey=[YOUR-KEY] --set overops-collector.overops.serviceKey=[YOUR-KEY] myoverops overops/overops

# or Use a local file 
$ vi ./local-values.yaml
#overops-server:
#  overops:
#    defaultUserPass: "[YOUR-PASSWORD]"
#    defaultUserServiceKey: "[YOUR-KEY]"
#overops-collector:
#  overops:
#    serviceKey: "[YOUR-KEY]"
$ helm install -n=overops --render-subchart-notes -f ./local-values.yaml myoverops overops/overops
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Dependencies

By default this chart installs additional, dependent charts:

- overops/overops-server
- overops/overops-collector

To disable the dependency during installation, set `overops-server.enabled` to `false`. 

_See [helm dependency](https://helm.sh/docs/helm/helm_dependency/) for command documentation._

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
$ helm show values overops/overops
```

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

The following table lists the configurable parameters of the OverOps chart and their default values. This is not a complete list, additional values can be found by inspecting the respected chart.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `overops-server.enabled`                     | Enables the deployment of the OverOps Backend server                                         | `true`                                               |
| `overops-server.overops.defaultUser`         | Default Username to be pre-populated. This should be an email address                        | `user@overops.com`                                   |
| `overops-server.overops.defaultUserFirst`    | Default User first name to be pre-populated.                                                 | `Overops`                                            |
| `overops-server.overops.defaultUserLast`     | Default User last name to be pre-populated.                                                  | `user`                                               |
| `overops-server.overops.defaultUserPass`     | Default User's Password to be pre-populated.  *                                              | `nil`                                                |
| `overops-server.overops.defaultUserServiceKey` | Default Service Key for the pre-populated key *                                            | `nil`                                                |
| `overops-server.overops.frontendURL`         | `overops-server` frontend url ENV variable setting.                                          | `http://overops.127.0.0.1.nip.io:8080/`              |
| `overops-collector.enabled`                  | Enables the deployment of the OverOps Collector.                                             | `true`                                               |
| `overops-collector.overops.serviceKey`       | Service Key for the collector *                                                              | `nil`                                                |
| `overops-collector.overops.backendURL`       | URL Address for the Backend Server.                                                          | `Defaults to local deployed backend`                 |
| `overops-collector.overops.storageTestURL`   | URL Address for the Storage Test endpoint.                                                   | `Defaults to local deployed backend`                 |
| `overops-collector.overops.serverName`       | Collector Name (Appears on backend server)                                                   | `pod name`                                           |
| `overops-collector.overops.jvmHeapSize`      | Collector JVM Heap Size                                                                      | `1G`                                                 |

_*: Indicates parameters that need to be set._