# Overops Reset DB Job
This is the helm chart for [OverOps](https://www.overops.com/) to reset the V5 backend database.

It deploys an mysql client in order to run a reset script against the database used by the namespace.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!


## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console

# Helm 3
$ helm show values overops-v5/overops-resetdb
```

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `database.host`                              | mysql database hostname                                                                      | `nil`                                                |
| `database.user`                              | mysql database User                                                                          | `overops`                                            |
| `auth.existingSecret`                        | Name of an existing secret containing the database password                                  | `nil`                                                |
| `image.repository`                           | `mysql` image repository.                                                                    | `mysql`                                              |
| `image.tag`                                  | `mysql` image tag.                                                                           | `5.7`                                                |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                                       |
