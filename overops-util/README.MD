# Overops Util Deployment
This is the helm chart for [OverOps](https://www.overops.com/) the V5 Utility Deployment.

It deploys a docker image with various tools for easy debugging or accessing services within a cluster without impacting running services.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!


## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console

# Helm 3
$ helm show values overops-v5/overops-resetdb
```

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                                    | Description                                                                                  | Default              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------- |
| `database.host`                              | Database hostname                                                                            | `mysql-aws-service`  |
| `database.user`                              | Database User                                                                                | `overops`            |
| `cache.host`                                 | Cache Hostname                                                                               | `redis-aws-service`  |
| `auth.existingSecret`                        | Name of an existing secret containing the database password                                  | `nil`                |
| `image.repository`                           | Image repository.                                                                            | `overops-util`       |
| `image.tag`                                  | Image tag.                                                                                   | `latest`             |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`       |

## Usage

Just copy the command from the Notes to exec into the pod. The pod has the following alias:

- redis_connect = Connects to the Configured redis cache
- db_connect = Connects to the Configured DB.

