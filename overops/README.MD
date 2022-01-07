# Overops V5 Chart
This is the main umbrella helm chart for [OverOps](https://www.overops.com/) deployment stack. It is based on the Overops docker releases of various components found [here](https://hub.docker.com/r/overops/). 

This chart pulls in each Overops component and can be configured to install individual or the full deployment. This includes:

* [Overops Backend Server](../overops-server/README.MD) ( Including supporting database)
* [Overops Receiver Server](../overops-receiver-server/README.MD) (V5 Only)

NOTE: The V5 Overops Chart can be used to deploy V5 specific versions of the server and receiver server. For other components you can use the v4 versions of the helm charts.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!
* PV provisioner support in the underlying infrastructure


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
- overops/overops-receiver-server

To disable the dependency during installation, set `overops-server.enabled` to `false`. 

_See [helm dependency](https://helm.sh/docs/helm/helm_dependency/) for command documentation._

## Uninstall Chart

```console
# Helm
$ helm uninstall [RELEASE_NAME]

# To uninstall and delete postgres volume:
$ helm uninstall -n [NAMESPACE] [RELEASE_NAME] ; kubectl delete -n [NAMESPACE] pvc -l app.kubernetes.io/name=postgresql
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

| Parameter                                    | Description                                                                    | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------| ---------------------------------------------------- |
| `overops-server.enabled`                     | Enables the deployment of the OverOps Backend server                           | `true`                                               |
| `overops-server.overops.defaultUser`         | Default Username to be pre-populated. This should be an email address          | `user@overops.com`                                   |
| `overops-server.overops.defaultUserFirst`    | Default User first name to be pre-populated.                                   | `Overops`                                            |
| `overops-server.overops.defaultUserLast`     | Default User last name to be pre-populated.                                    | `user`                                               |
| `overops-server.overops.defaultUserPass`     | Default User's Password to be pre-populated.  *                                | `nil`                                                |
| `overops-server.overops.defaultUserServiceKey` | Default Service Key for the pre-populated key *                              | `nil`                                                |
| `overops-server.overops.frontendURL`         | `overops-server` frontend url ENV variable setting.                            | `http://overops.127.0.0.1.nip.io:9191/`              |
| `global.enableStorageServer`                 | Enables the deployment of the OverOps Storage server                           | `false`                                              |
| `global.enableStorageServerS3`               | Enables the deployment of the OverOps Storage server S3                        | `false`                                              |
| `global.enableKedaAuth`                      | Enables the use of a shared KEDA Autoscaler Authentication and Secret.         | `false`                                              |
| `auth.existingSecret`                        | Name of an existing secret rather than creating a one.                         | `nil`                                                |
| `keda.rabbitQueue.service`                   | V5: Service or external hostname of the Rabbit MQ server                       | `nil`                                                |
| `keda.rabbitQueue.port`                      | V5: Port of the Rabbit MQ server                                               | `5672`                                               |
| `keda.rabbitQueue.username`                  | V5: Username to authenticate to the Rabbit MQ Exchange                         | `overops`                                            |
| `keda.rabbitQueue.password`                  | V5: Password to authenticate to the Rabbit MQ Exchange                         | `nil`                                                |

_*: Indicates parameters that need to be set._


## Enabling OverOps Receiver Autoscaling

The OverOps Helm chart can enable KEDA scaling across multiple overops-receiver instances using the `enableKedaAuth` flag. This allows creating a single
secret and TriggerAuthentication rather than creating an instance for every receiver.