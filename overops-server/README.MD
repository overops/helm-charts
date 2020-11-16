# Overops Server Backend
This is the helm chart for [OverOps](https://www.overops.com/) backend server. It is based on the Overops Server docker release found [here](https://hub.docker.com/r/overops/server). 

Besides bootstrapping the Overops server it also includes deploying a database (currently mysql 5.X) 

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
# Helm 3 (Updating the fields to install collector and server)
$ helm install -n=overops --set overops.defaultUserPass=[YOUR-PASSWORD] --set overops.defaultUserServiceKey=[YOUR-KEY] myoverops overops/overops-server
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
| `overops.defaultUser`                        | Default Username to be pre-populated. This should be an email address                        | `user@overops.com`                                   |
| `overops.defaultUserFirst`                   | Default User first name to be pre-populated.                                                 | `Overops`                                            |
| `overops.defaultUserLast`                    | Default User last name to be pre-populated.                                                  | `user`                                               |
| `overops.defaultUserPass`                    | Default User's Password to be pre-populated.                                                 | `nil`                                                |
| `overops.defaultUserServiceKey`              | Default Service Key for the pre-populated key                                                | `nil`                                                |
| `overops.frontendURL`                        | `overops-server` frontend url ENV variable setting.                                          | `http://overops.127.0.0.1.nip.io:8080/`              |
| `image.repository`                           | `overops-server` image repository.                                                           | `overops/server`                                     |
| `image.tag`                                  | `overops-server` image tag.                                                                  |  Pulled from chart.yaml                              |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `database.type`                              | Database type used by overops server                                                         | `mysql`                                              |
| `database.external`                          | Flag to use an external database and not one deployed by helm.                               | `false`                                              |
| `mysql.enabled`                              | Enables the mysql dependency chart. If using an external DB set this to false                | `true`                                               | 
| `mysql.RootPassword`                         | Password for the `root` user. Ignored if existing secret is provided                         | Random 10 characters                                 |
| `mysql.mysqlUser`                            | Username of new database user to create.                                                      | `overops`                                            |
| `mysql.mysqlPassword`                        | Password for the new user. Ignored if existing secret is provided                            | Random 10 characters                                 |
| `config.enableExtraConfig`                   | Populates optional configuration files                                                       | see [values](values.yaml)                            |
