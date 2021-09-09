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
$ helm install -n=overops --set overops.collectorHost=[YOUR-COLLECTOR-HOSTNAME] --set image.repository=[YOUR-REPOSITORY] [RELEASE_NAME] overops/overops-java-bullshifier
```

_Note: Currently java-bullshifier is not hosted on dockerhub but can built from source and published to a local repository. Therefore must set the image.repository value_

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
| `overops.collectorURL`                       | Collector URL i.e. http://overops-collector:6060                                             | `nil`                             |
| `overops.collectorKeyID`                     | Collector Key ID used with MEC                                                               | `nil`                             |
| `overops.applicationName`                    | Application Name to display on OverOps (Automatically detected if not set)                   | `nil`                             |
| `overops.deploymentName`                     | Deployment Name to display on OverOps (Automatically detected if not set)                    | `nil`                             |
| `overops.serverName`                         | Server Name to display on OverOps (Automatically detected if not set)                        | `nil`                             |
| `overops.environmentName`                    | Environment Name to display on OverOps (Automatically detected if not set)                   | `nil`                             |
| `overops.color`                              | The plan of the Bullshifier - affect on how intense will be the load on the application - (Options: white/yellow/red/black) .    | `white`                              |
| `overops.agentProperties`                    | Extended configuration settings to be added to `agent.properties` file                       | see [values](values.yaml)         |
| `overops.job.enabled`                        | Enables a k8s Job Workload for the Java Bullshifier                                          | `false`                           |
| `overops.job.activeDeadlineSeconds`          | Job Deadline to force completion of the Job.                                                 | `600`                             |
| `overops.job.runningDurationHours`           | The number of hours java-bullshifier app should be running                                   | `0`                               |
| `overops.job.runningDurationMinutes`         | The number of minutes java-bullshifier app should be running                                 | `5`                               |
| `image.repository`                           | `overops-java-bullshifier` image repository.                                                 | `nil`                             |
| `image.tag`                                  | `overops-java-bullshifier` image tag.                                                        |  Pulled from chart.yaml           |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                    |
| `overops.agentSidecar.enabled`               | Enable the use of agent-sidecar init container instead of embedded agent.                    | `false`                           |
| `overops.agentSidecar.repository`            | Agent Sidecar image repository.                                                              | `overops/agent-sidecar`           |
| `overops.agentSidecar.pullPolicy`            | Agent Sidecar image pull policy.                                                             | `IfNotPresent`                    |
| `overops.agentSidecar.tag`                   | Agent Sidecar image tag.                                                                     | `latest`                          |

## Advanced

### Agent Properties
The helm chart allows for extra configuration changes to be added to the `agent.properties` file that will be used by the Overops Agent. More details
on advance agent settings (here)[https://doc.overops.com/docs/agent-properties]

The agent properties will be mounted as a file to: `/opt/overops/private/agent.properties`

```yaml
overops:
  agentProperties: |-
    MY_PROPERTY1=A
    MY_PROPERTY2=B
    MY_PROPERTY3=C
```