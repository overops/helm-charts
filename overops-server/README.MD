# Overops Server Backend
This is the helm chart for [OverOps](https://www.overops.com/) backend server. It is based on the Overops Server docker release found [here](https://hub.docker.com/r/overops/server). 

Besides bootstrapping the Overops server it also includes deploying a database (As of Chart Version 2.1: Postgres Version 11.10.0 )

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
| `overops.defaultUserEnabled`                 | Enables a Default User to be created at deployment                                           | `true`                                               |
| `overops.defaultUser`                        | Default Username to be pre-populated. This should be an email address                        | `user@overops.com`                                   |
| `overops.defaultUserFirst`                   | Default User first name to be pre-populated.                                                 | `Overops`                                            |
| `overops.defaultUserLast`                    | Default User last name to be pre-populated.                                                  | `user`                                               |
| `overops.defaultUserPass`                    | Default User's Password to be pre-populated.                                                 | `nil`                                                |
| `overops.defaultUserServiceKey`              | Default Service Key for the pre-populated key                                                | `nil`                                                |
| `overops.frontendURL`                        | `overops-server` frontend url ENV variable setting.                                          | `http://overops.127.0.0.1.nip.io:8080/`              |
| `image.repository`                           | `overops-server` image repository.                                                           | `overops/server`                                     |
| `image.tag`                                  | `overops-server` image tag.                                                                  |  Pulled from chart.yaml                              |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
| `auth.existingSecret`                        | Name of an existing K8S Secret that contains Sensitive Values                                | `nil`                                                |
| `externalDatabase.enabled`                   | Flag to use an external database and not one deployed by helm.                               | `false`                                              |
| `externalDatabase.type`                      | External Database type used by overops server                                                | `mysql`                                              |
| `externalDatabase.url`                       | External Database URL used by overops server                                                 | `nil`                                                |
| `externalDatabase.dbUser`                    | External Database User used by overops server                                                | `nil`                                                |
| `externalDatabase.dbPassword`                | External Database Password used by overops server                                            | `nil`                                                |
| `mysql.enabled`                              | Enables the mysql dependency chart.                                                          | `false`                                              |
| `mysql.RootPassword`                         | Password for the `root` user. Ignored if existing secret is provided                         | Random 10 characters                                 |
| `mysql.mysqlUser`                            | Username of new database user to create.                                                     | `overops`                                            |
| `mysql.mysqlPassword`                        | Password for the new user. Ignored if existing secret is provided                            | Random 10 characters                                 |
| `postgresql.enabled`                         | Enables the postgresql dependency chart.                                                     | `true`                                               |
| `postgresql.postgresqlUsername`              | Username of new database postgresql user to create.                                          | `overops`                                            |
| `postgresql.postgresqlPassword`              | Password for the new postgresql database user. Random if not set.                            | Random 10 characters                                 |
| `config.enableExtraConfig`                   | Populates optional configuration files                                                       | see [values](values.yaml)                            |
| `persistence.enabled`                        | Enables Persistence Storage for the Backend Storage                                          | `true`                                               |
| `persistence.size`                           | Persistence Storage Size                                                                     | `20Gi`                                               |
| `persistence.privateMountPath`               | Sets the mount path for the config directory                                                 | `/opt/private`                                       |
| `persistence.storageMountPath`               | Sets the mount path for the storage directory                                                | `/opt/takipi-server/storage`                         |

## Advanced

### Existing Secret

Rather than passing passwords / keys using the helm values an existing secret can also be used by setting the `auth.existingSecret` value. This must be set to existing name of k8s secret installed
in the same namespace. If not set, a secret will be created by the helm chart containing the values.

The following key value's will be used:

```yaml
dbPassword: # Database Password
defaultUserPass: # Default User Password
defaultUserServiceKey: # Default Service Key
```

### Extra Configuration
The helm chart allows for extra configuration changes to overops-server's configMap, this includes `my.server.properties` and additional configuration files such as the `smtpserver.properties`. 
Set `config.enableExtraConfig: true` for additional config entries to the `my.server.properties` update the yaml as follows:

```yaml
myServerProperties: |-
  MY_PROPERTY1=A
  MY_PROPERTY2=B
  MY_PROPERTY3=C
```
To add additional config files use the `extraConfigurationFiles` option adding an entry each filename to be added to the configMap as follows:

```yaml
extraConfigurationFiles: 
    smtp.properties: |-
       SMTP_SERVER_USERNAME=
       SMTP_SERVER_PASSWORD=
       SMTP_FROM_ADDRESS=
    smtpserver.properties: |-
       mail.transport.protocol=smtp
```
### Persistence Storage
By default persistence storage is enabled using the default for the backend `storage` path. This will use the default storage class on the cluster. Additionally, you can modify the mount path
of the `storage` and `private` mounts but are default to match the overop-server docker image https://hub.docker.com/r/overops/server. 

Only update the `MountPath` values if you are using a custom image and require different paths!

### Update the Certificate Authority

In cases where additional certificates need to be added to the Overops server pod, it is recommended to use a certificate injector. For example, in order to configure the overops server to
communicate with a private LDAP server using SSL a private Certificate Authority needs to be added to Java's install cacerts keystore. More info LDAP configuration can be found [here](https://doc.overops.com/docs/configuring-ldap-for-on-premises-deployments)

A certificate Injector can solve this issue by updating the target pod's ca bundle to include your CA certificate. One solution is [cloudbees-sidecar-injector](https://github.com/joostvdg/jenkins-examples/tree/master/cloudbees/gke/charts/cloudbees-core/charts/cloudbees-sidecar-injector)

To use this with the overops-server docker hub image, ensure that the java cacert path is included in the helm values during install. The path is `/usr/local/openjdk-8/lib/security/cacerts` and can be added to the `injectionJavaKeystore` 
parameter in the values.yaml as you follow the linked instructions. This will result in the updated java cacerts file mounted into the pod.
