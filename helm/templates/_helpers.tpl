{{- define "python-app.labels" -}}
app.kubernetes.io/name: python-app
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}