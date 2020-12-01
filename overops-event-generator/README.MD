# Overops Event Generator
This is the helm chart for [OverOps](https://www.overops.com/) event generator. It is based on the Overops Event Generator docker release found [here](https://hub.docker.com/r/overops/event-generator). 

The event generator is an test / demonstration tool as described [here](https://github.com/takipi-field/overops-event-generator) As part of the helm chart it can be configured to
communicate with an overops collector in the same k8s cluster. 

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!

## Get Repo Info
```
helm repo add overops https://overops.github.io/helm-charts
helm repo update
```

## Install Chart
```console
# Helm 3 (Updating the fields to install collector and server)
$ helm install -n=overops --set overops.collectorHost=[YOUR-COLLECTOR-HOSTNAME] myoverops overops/overops-event-generator
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
$ helm show values overops/overops-event-generator
```

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                                    | Description                                                                                  | Default                           |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ----------------------------------|
| `overops.collectorHost`                      | Collector hostname or K8s Service Name                                                       | `nil`                             |
| `overops.collectorPort`                      | Collector port                                                                               | `6060`                            |
| `overops.applicationName`                    | Application Name to display on OverOps (Automatically detected if not set)                   | `nil`                             |
| `overops.deploymentName`                     | Deployment Name to display on OverOps (Automatically detected if not set)                    | `nil`                             |
| `image.repository`                           | `overops-event-generator` image repository.                                                  | `overops/event-generator`         |
| `image.tag`                                  | `overops-event-generator` image tag.                                                         |  Pulled from chart.yaml           |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                    |
