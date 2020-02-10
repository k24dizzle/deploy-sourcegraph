package base

deployment: pgsql: {
	metadata: {
		annotations: description: "Postgres database for various data."
	}
	spec: {
		minReadySeconds:      10
		revisionHistoryLimit: 10
		selector: matchLabels: app: "pgsql"
		strategy: {
			rollingUpdate: {
				maxSurge:       1
				maxUnavailable: 1
			}
			type: "RollingUpdate"
		}
		template: {
			metadata: labels: {
				group: "backend"
			}
			spec: {
				containers: [{
					env:                      null
					image:                    "index.docker.io/sourcegraph/postgres-11.4:19-11-14_b084311b@sha256:072481559d559cfd9a53ad77c3688b5cf583117457fd452ae238a20405923297"
					terminationMessagePolicy: "FallbackToLogsOnError"
					readinessProbe: exec: command: [
						"/ready.sh",
					]
					livenessProbe: {
						initialDelaySeconds: 15
						exec: command: [
							"/liveness.sh",
						]
					}
					ports: [{
						containerPort: 5432
						name:          "pgsql"
					}]
					resources: {
						limits: {
							cpu:    "4"
							memory: "2Gi"
						}
						requests: {
							cpu:    "4"
							memory: "2Gi"
						}
					}
					volumeMounts: [{
						mountPath: "/data"
						name:      "disk"
					}, {
						mountPath: "/conf"
						name:      "pgsql-conf"
					}]
				}, {
					env: [{
						name:  "DATA_SOURCE_NAME"
						value: "postgres://sg:@localhost:5432/?sslmode=disable"
					}]
					image:                    "wrouesnel/postgres_exporter:v0.5.1@sha256:b9bad0d21bcb73b347ab75add47fd024d5ff82718b9369457591243dff26cc09"
					terminationMessagePolicy: "FallbackToLogsOnError"
					name:                     "pgsql-exporter"
					resources: {
						limits: {
							cpu:    "10m"
							memory: "50Mi"
						}
						requests: {
							cpu:    "10m"
							memory: "50Mi"
						}
					}
				}]
				securityContext: fsGroup: 999
				volumes: [{
					name: "disk"
					persistentVolumeClaim: claimName: "pgsql"
				}, {
					name: "pgsql-conf"
					configMap: {
						defaultMode: 0o777
						name:        "pgsql-conf"
					}
				}]
			}
		}
	}
}