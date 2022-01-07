# Overops Event Generator
This is the helm chart for [OverOps](https://www.overops.com/) event generator. It is based on the Overops Event Generator docker release found [here](https://hub.docker.com/r/overops/event-generator).

The event generator is an test / demonstration tool as described [here](https://github.com/takipi-field/overops-event-generator) As part of the helm chart it can be configured to
communicate with an overops collector in the same k8s cluster.

The event-generator can also be configured to use the OverOps agent-sidecar rather than the embedded agent. This can be useful example to demostrate the side-car use case which uses an init container. More info on the agent-sidecar can be found [here](https://hub.docker.com/r/overops/agent-sidecar)

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

## Executing Event Generator as a Job
By default the Event Generator will run indefinitely and must be scaled down or up to control execution. Alternatively, Event Generator supports running as a K8S Job.

To execute this use the `overops.job.enabled` value to enable this feature:

```console
# Note that replicaCount is set to 0 to ensure that no deployment Pods are created only the Job.
# Also can change the number of Events using --set overops.job.numberOfEvents
$ helm upgrade --install -n overops --set overops.collectorHost=[YOUR-COLLECTOR-HOSTNAME]  --set overops.job.enabled=true --set replicaCount=0 myoverops overops/overops-event-generator
```

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
| `overops.collectorURL`                       | Collector URL i.e. http://overops-collector:6070                                             | `nil`                             |
| `overops.collectorKeyID`                     | Collector Key ID used with MEC                                                               | `nil`                             |
| `overops.applicationName`                    | Application Name to display on OverOps (Automatically detected if not set)                   | `nil`                             |
| `overops.deploymentName`                     | Deployment Name to display on OverOps (Automatically detected if not set)                    | `nil`                             |
| `overops.serverName`                         | Server Name to display on OverOps (Automatically detected if not set)                        | `nil`                             |
| `overops.environmentName`                    | Environment Name to display on OverOps (Automatically detected if not set)                   | `nil`                             |
| `overops.randomSeed`                         | Seed value to use when randomizing the events for K8s Deployment                             | `nil`                             |
| `overops.sourceAttach.enabled`               | Adds Source Attach settings to the `agent.properties` file                                   | `false`                           |
| `overops.sourceAttach.credToken`             | Adds Source Attach Token to  `agent.properties` file                                         | `nil`                             |
| `overops.sourceAttach.repoRef`               | Adds Source Attach repository reference ( Branch, Tag, SHA )                                 | `master`                          |
| `overops.agentProperties`                    | Extended configuration settings to be added to `agent.properties` file                       | see [values](values.yaml)         |
| `overops.job.enabled`                        | Enables a k8s Job Workload for the Event Generator                                           | `false`                           |
| `overops.job.activeDeadlineSeconds`          | Job Deadline to force completion of the Job.                                                 | `600`                             |
| `overops.job.numberOfEvents`                 | Number of Events the Job should send before terminating                                      | `100`                             |
| `overops.job.randomSeed`                     | Seed value to use when randomizing the events for K8s Job.                                   | `123`                             |
| `image.repository`                           | `overops-event-generator` image repository.                                                  | `overops/event-generator`         |
| `image.tag`                                  | `overops-event-generator` image tag.                                                         |  Pulled from chart.yaml           |
| `image.pullPolicy`                           | Image pull policy                                                                            | `IfNotPresent`                    |
| `overops.agentSidecar.enabled`               | Enable the use of agent-sidecar init container instead of embedded agent.                    | `false`                           |
| `overops.agentSidecar.repository`            | Agent Sidecar image repository.                                                              | `overops/agent-sidecar`           |
| `overops.agentSidecar.pullPolicy`            | Agent Sidecar image pull policy.                                                             | `IfNotPresent`                    |
| `overops.agentSidecar.tag`                   | Agent Sidecar image tag.                                                                     | `latest`                          |

## Advanced
### Source Attach

Overops supports source attach using a git repository, this is described in the [overops documentation](https://doc.overops.com/docs/attaching-git-repository). The `event-generator`
supports source attach using the public github [repo](https://github.com/takipi-field/overops-event-generator). To enable Source Attach and Git Blame data, you must add a
security token on the Overops Management site that is a valid Github API Key, see docs site for more info. This security token must be set in the `overops.sourceAttach.credToken`,
additionally the `overops.deploymentName` will be ignored and the `overops.sourceAttach.repoRef` (Github branch / tag) will be used instead.
Below is an example values.yaml:

```yaml
overops:
  collectorHost: collector-overops-collector

  sourceAttach:
    enabled: true
    # Where my-token is added to the Overops Server's Settings page, referencing a Github API-TOKEN.
    credToken: my-token
```

### Agent Properties
The helm chart allows for extra configuration changes to be added to the `agent.properties` file that will be used by the Overops Agent. More details
on advance agent settings (here)[https://doc.overops.com/docs/agent-properties]

The agent properties will be mounted as a file to: `/opt/takipi/private/agent.properties`

```yaml
overops:
  agentProperties: |-
    MY_PROPERTY1=A
    MY_PROPERTY2=B
    MY_PROPERTY3=C
```
