{{/*
Expand the name of the chart.
*/}}
{{- define "overops-collector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "overops-collector.fullname" -}}
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
URL used for a backend server running in the same namespace.
Either use the current release name or one from the values.
*/}}
{{- define "overops-collector.hostedBackendURL" -}}
{{- if .Values.overops.backendReleaseName }}
{{- printf "http://%s-overops-server:8080" .Values.overops.backendReleaseName }}
{{- else if .Values.global.deployAsStack }}
{{- printf "http://%s-overops-server:8080" .Release.Name }}
{{- else }}
{{- printf "https://backend.overops.com" }}
{{- end }}
{{- end }}

{{/*
URL used for a storage server running in the same namespace.
Either use the current release name or one from the values.
*/}}
{{- define "overops-collector.hostedStorageURL" -}}
{{- if .Values.overops.storageReleaseName }}
{{- printf "http://%s-overops-storage-server:8080" .Values.overops.storageReleaseName }}
{{- else }}
{{- printf "http://%s-overops-storage-server:8080" .Release.Name }}
{{- end }}
{{- end }}

{{/*
URL used for a storage server s3 running in the same namespace.
Either use the current release name or one from the values.
*/}}
{{- define "overops-collector.hostedStorageS3URL" -}}
{{- if .Values.overops.storageReleaseName }}
{{- printf "http://%s-overops-storage-server-s3:8080" .Values.overops.storageReleaseName }}
{{- else }}
{{- printf "http://%s-overops-storage-server-s3:8080" .Release.Name }}
{{- end }}
{{- end }}

{{/*
Full Storage Test URL to be used in the collector.properties. Defaults to the SaaS url.
*/}}
{{- define "overops-collector.storageTestURL" -}}
{{- if or (.Values.global.enableStorageServer) (.Values.overops.storageReleaseName) }}
{{- printf "%s/storage/v1/diag/ping" (include "overops-collector.hostedStorageURL" .) }}
{{- else if .Values.global.enableStorageServerS3 }}
{{- printf "%s/storage/v1/diag/ping" (include "overops-collector.hostedStorageS3URL" .) }}
{{- else if or (.Values.global.deployAsStack) (.Values.overops.backendReleaseName) }}
{{- printf "%s/service/png" (include "overops-collector.hostedBackendURL" .) }}
{{- else }}
{{- printf "https://s3.amazonaws.com/app-takipi-com/ConnectionTest" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "overops-collector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "overops-collector.labels" -}}
helm.sh/chart: {{ include "overops-collector.chart" . }}
{{ include "overops-collector.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "overops-collector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "overops-collector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "overops-collector.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "overops-collector.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
