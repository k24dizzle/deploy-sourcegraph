package base

deployment: "lsif-server": {
	metadata: {
		annotations: description: "LSIF HTTP server for code intelligence."
	}
	spec: {
		minReadySeconds:      10
		revisionHistoryLimit: 10
		selector: matchLabels: app: "lsif-server"
		strategy: {
			rollingUpdate: {
				maxSurge:       1
				maxUnavailable: 1
			}
			type: "RollingUpdate"
		}
		template: {
			spec: {
				containers: [{
					env: [{
						name:  "LSIF_STORAGE_ROOT"
						value: "/lsif-storage"
					}, {
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}]
					image:                    "index.docker.io/sourcegraph/lsif-server:3.12.6@sha256:357ed0f415665b13ef5d9fdb51167b1a6c2d7edca9ed023a42592f141ea76591"
					terminationMessagePolicy: "FallbackToLogsOnError"
					livenessProbe: {
						httpGet: {
							path:   "/ping"
							port:   "server"
							scheme: "HTTP"
						}
						initialDelaySeconds: 60
						timeoutSeconds:      5
					}
					readinessProbe: {
						httpGet: {
							path:   "/ping"
							port:   "server"
							scheme: "HTTP"
						}
						periodSeconds:  5
						timeoutSeconds: 5
					}
					ports: [{
						containerPort: 3186
						name:          "server"
					}, {
						containerPort: 3187
						name:          "worker"
					}]
					resources: {
						limits: {
							cpu:    "2"
							memory: "2G"
						}
						requests: {
							cpu:    "500m"
							memory: "500M"
						}
					}
					volumeMounts: [{
						mountPath: "/lsif-storage"
						name:      "lsif-storage"
					}]
				}]
				volumes: [{
					name: "lsif-storage"
					persistentVolumeClaim: claimName: "lsif-server"
				}]
			}
		}
	}
}