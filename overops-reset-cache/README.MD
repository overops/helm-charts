# Overops Reset Cache Job
This is the helm chart for [OverOps](https://www.overops.com/) to reset the V5 external cache (REDIS).

It deploys an redis client in order to run the flush command against the cache used by the namespace.

## Prerequisites

* Currently tested against Kubernetes v1.18+ using helm3. Other version combinations use at your own risk!


## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console

# Helm 3
$ helm show values overops-v5/overops-reset-cache
```

The following table lists the configurable parameters of the OverOps chart and their default values.

| Parameter                      | Description                                           | Default                                              |
| ------------------------------ | ----------------------------------------------------- | ---------------------------------------------------- |
| `cache.host`                   | Redis cache hostname                                  | `nil`                                                |
| `cache.port`                   | Redis cache port                                      | `6379`                                               |
| `image.repository`             | `redis` image repository.                             | `redis`                                              |
| `image.tag`                    | `redis` image tag.                                    | `6.2-alpine`                                         |
| `image.pullPolicy`             | Image pull policy                                     | `IfNotPresent`                                       |
