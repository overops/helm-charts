# Overops Java Bullshifier
This is the helm chart for [OverOps](https://www.overops.com/) java bullshifier. It is based on the Overops Java Bullshifier dockerfile found [here](https://github.com/takipi/java-bullshifier/blob/master/Dockerfile). 

The java bullshifier is an test / demonstration tool you can find source code [here](https://github.com/takipi/java-bullshifier) As part of the helm chart it can be configured to
communicate with an overops collector in the same k8s cluster. 

The java-bullshifier can also be configured to use the OverOps agent-sidecar rather than the embedded agent. This can be useful example to demostrate the side-car use case which uses an init container. More info on the agent-sidecar can be found [here](https://hub.docker.com/r/overops/agent-sidecar) 

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

## Executing Java Bullshifier as a Job
TBD 

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
$ helm show values overops/overops-java-bullshifier
```

You may similarly use the above configuration commands on each chart [dependency](#dependencies) to see it's configurations.

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                                    | Description                                                                                  | Default                           |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ----------------------------------|
| `overops.collectorHost`                      | Collector hostname or K8s Service Name                                                       | `nil`                             |
| `overops.collectorPort`                      | Collector port                                                                               | `6060`                            |
| `overops.applicationName`                    | Application Name to display on OverOps (Automatically detected if not set)                   | `nil`                             |
| `overops.deploymentName`                     | Deployment Name to display on OverOps (Automatically detected if not set)                    | `nil`                             |
| `overops.serverName`                         | Server Name to display on OverOps (Automatically detected if not set)                        | `nil`                             |
| `overops.job.enabled`                        | Enables a k8s Job Workload for the Event Generator                                           | `false`                           |
| `overops.job.color`                          | The plan of the Bulshifier - affect on how intense will be the load on the application - (Options: white/yellow/red/black) .                                      | `white`                              |
| `image.repository`                           | `overops-event-generator` image repository.                                                  | `overops/event-generator`         |
| `image.tag`                                  | `overops-event-generator` image tag.                                                         |  Pulled from chart.yaml           |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                    |
| `overops.agentSidecar.enabled`               | Enable the use of agent-sidecar init container instead of embedded agent.                    | `false`                           |
| `overops.agentSidecar.repository`            | Agent Sidecar image repository.                                                              | `overops/agent-sidecar`           |
| `overops.agentSidecar.pullPolicy`            | Agent Sidecar image pull policy.                                                             | `IfNotPresent`                    |
| `overops.agentSidecar.tag`                   | Agent Sidecar image tag.                                                                     | `latest`                          |
