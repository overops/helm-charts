{{/*
Expand the name of the chart.
*/}}
{{- define "overops-java-bullshifier.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "overops-java-bullshifier.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "overops-java-bullshifier.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "overops-java-bullshifier.labels" -}}
helm.sh/chart: {{ include "overops-java-bullshifier.chart" . }}
{{ include "overops-java-bullshifier.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "overops-java-bullshifier.selectorLabels" -}}
app.kubernetes.io/name: {{ include "overops-java-bullshifier.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "overops-java-bullshifier.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "overops-java-bullshifier.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Hostname used for a server running in the same namespace.
*/}}
{{- define "overops-event-generator.collectorEndpoint" -}}
{{- if .Values.overops.collectorHost }}
{{- .Values.overops.collectorHost | quote }}
{{- else }}
{{- printf "%s-overops-collector" .Release.Name }}
{{- end }}
{{- end }}