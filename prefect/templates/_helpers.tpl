{{/*
  orion.postgres-connstr:
    Generates the connection string for the postgresql service
*/}}
{{- define "orion.postgres-connstr" -}}
{{- $user := .Values.postgresql.auth.username -}}
{{- $pass := .Values.postgresql.auth.password -}}
{{- $host := .Values.postgresql.auth.host     -}}
{{- $port := .Values.postgresql.auth.port | toString -}}
{{- $db := .Values.postgresql.auth.database   -}}
{{- printf "postgresql+asyncpg://%s:%s@%s:%s/%s" $user $pass $host $port $db -}}
{{- end -}}
