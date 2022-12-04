{{/* vim: set filetype=mustache: */}}
{{- define "glitchtip.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "glitchtip.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "labels" -}}
{{ include "selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}


{{- define "selectorLabels" -}}
app.kubernetes.io/name: {{ include "glitchtip.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "redis.fullname" -}}
{{- $name := default .Chart.Name -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}-redis-master
{{- else -}}
{{- printf "%s-%s" .Release.Name "redis-master" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "redis.host" -}}
{{- template "redis.fullname" . -}}-redis-master
{{- end -}}

{{- define "redis.url" -}}
redis://:{{ .Values.redis.auth.password }}@{{- template "redis.fullname" . -}}:{{- template "redis.port" . -}}/0
{{- end -}}

{{- define "redis.port" -}}
6379
{{- end -}}