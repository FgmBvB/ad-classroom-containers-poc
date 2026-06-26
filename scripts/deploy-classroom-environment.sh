#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Classroom Deployment Script
#
# Deploys one or more isolated development environments for students.
#
# The script:
# - Creates the Kubernetes namespace.
# - Creates persistent Windows folders for each student.
# - Deploys a Kubernetes Deployment and Service per student.
# - Exposes each environment through a NodePort.
# - Displays the access URL and password.
# -----------------------------------------------------------------------------

NAMESPACE="aula1-informatica"
HOST_PROFESOR="<teacher-ip>"
TOTAL=1

kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

for i in $(seq 1 "$TOTAL"); do
  PORT=$((32100+i))
  USER="alumno$i"
  APP="vscode-$USER"
  RUTA_DATOS="/mnt/c/K3/aula1/vscode/$USER"

  mkdir -p "$RUTA_DATOS"

  kubectl delete deployment "$APP" -n "$NAMESPACE" --ignore-not-found=true
  kubectl delete svc "$APP" -n "$NAMESPACE" --ignore-not-found=true

  cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $APP
  namespace: $NAMESPACE
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $APP
  template:
    metadata:
      labels:
        app: $APP
    spec:
      containers:
      - name: code-server
        image: codercom/code-server:latest
        ports:
        - containerPort: 8080
        env:
        - name: PASSWORD
          value: "$USER"
        resources:
          requests:
            memory: "200Mi"
            cpu: "100m"
          limits:
            memory: "400Mi"
            cpu: "400m"
        volumeMounts:
        - name: trabajo
          mountPath: /home/coder/project
      volumes:
      - name: trabajo
        hostPath:
          path: $RUTA_DATOS
          type: DirectoryOrCreate
---
apiVersion: v1
kind: Service
metadata:
  name: $APP
  namespace: $NAMESPACE
spec:
  type: NodePort
  selector:
    app: $APP
  ports:
  - port: 8080
    targetPort: 8080
    nodePort: $PORT
EOF

  echo "$USER -> http://$HOST_PROFESOR:$PORT  contraseña: $USER"
  echo "Datos: C:\\K3\\aula1\\vscode\\$USER"
done