# Overops Server Backend
This is the helm chart for [OverOps](https://www.overops.com/) backend server. It is based on the Overops Server docker release found [here](https://hub.docker.com/r/overops/server). 

Besides bootstrapping the Overops server it also includes deploying a database (currently mysql 5.X) 

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!
* PV provisioner support in the underlying infrastructure

## Get Repo Info
TBD

## Install Chart
```console

# Helm 3
$ helm install [RELEASE_NAME] ./overops-server --set mysql.mysqlPassword=[ENTER-PASSWORD] 
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Dependencies

By default this chart installs additional, dependent charts:

- [stable/mysql](https://github.com/helm/charts/tree/master/stable/mysql)

To disable the dependency during installation, set `mysql.enabled` to `false`. 

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
$ helm show values overops/overops-server
```

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `image.repository`                           | `overops-server` image repository.                                                           | `overops/server`                                     |
| `image.tag`                                  | `overops-server` image tag.                                                                  |  Pulled from chart.yaml                              |
| `frontendURL`                                | `overops-server` frontend url ENV variable setting.                                          |  `http://overops.127.0.0.1.nip.io:8080/`             |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `database.type`                              | Database type used by overops server                                                         | `mysql`                                              |
| `mysql.enabled`                              | Enables the mysql dependency chart.                                                          | `true`                                               | 
| `mysql.RootPassword`                         | Password for the `root` user. Ignored if existing secret is provided                         | Random 10 characters                                 |
| `mysql.mysqlUser`                            | Username of new user to create.                                                              | `nil`                                                |
| `mysql.mysqlPassword`                        | Password for the new user.                                                                   | `nil`                                                |
| `mysqlPassword`                              | Password for the new user. Ignored if existing secret is provided                            | Random 10 characters                                 |
| `configurationFiles.my.server.properties`    | Populates the my.server.properties configmap                                                 | see [values](values.yaml)                            |
