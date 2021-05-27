# Overops Server Backend V5
This is the helm chart for [OverOps](https://www.overops.com/) backend server. It is based on the Overops Server docker release found [here](https://hub.docker.com/r/overops/server). 

This is the V5 Version of the Chart.

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
- [bitnami/postgres](https://github.com/bitnami/charts/tree/master/bitnami/postgresql/)  <--- Enabled by default

To disable the default dependency during installation, set `postgresql.enabled` to `false`. 

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
| `overops.auth.existingSecret`                | Name of an existing secret rather than creating a one.                                       | `nil`                                                |
| `overops.rabbitQueue.enabled`                | V5: Enables the OverOps to run with rabbit message queue                                     | `false`                                              |
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
| `image.repository`                           | `overops-server` image repository.                                                           | `overops/server`                                     |
| `image.tag`                                  | `overops-server` image tag.                                                                  |  Pulled from chart.yaml                              |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `externalDatabase.enabled`                   | Flag to use an external database and not one deployed by helm.                               | `false`                                              |
| `externalDatabase.type`                      | External Database type used by overops server                                                | `mysql`                                              |
| `externalDatabase.url`                       | External Database URL used by overops server                                                 | `nil`                                                |
| `externalDatabase.dbUser`                    | External Database User used by overops server                                                | `nil`                                                |
| `externalDatabase.dbPassword`                | External Database Password used by overops server                                            | `nil`                                                |
| `mysql.enabled`                              | Enables the mysql dependency chart.                                                          | `false`                                              |
| `mysql.RootPassword`                         | Password for the `root` user. Ignored if existing secret is provided                         | Random 10 characters                                 |
| `mysql.mysqlUser`                            | Username of new database user to create.                                                     | `overops`                                            |
| `mysql.mysqlPassword`                        | Password for the new user. Ignored if existing secret is provided                            | Random 10 characters                                 |
| `postgresql.enabled`                         | Enables the postgresql dependency chart.                                                     | `true`                                              | 
| `postgresql.postgresqlUsername`              | Username of new database postgresql user to create.                                          | `overops`                                            |
| `postgresql.postgresqlPassword`              | Password for the new postgresql database user. Random if not set.                            | Random 10 characters                                 |
| `config.enableExtraConfig`                   | Populates optional configuration files                                                       | see [values](values.yaml)                            |
