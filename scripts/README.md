# Scripts

This directory contains the automation scripts developed during the Proof of Concept.

## deploy-classroom-environment.sh

Main deployment script executed inside WSL2.

It automatically:

* Creates the Kubernetes namespace.
* Creates the required Windows directories for persistent storage.
* Deploys one development environment per student.
* Creates the required Kubernetes Services.
* Displays the connection information for each student.

---

## deploy-classroom-environment.bat

Windows launcher used by the instructor.

It starts the deployment process without requiring the instructor to manually execute Linux commands.

---

## start-admin-panels.bat

Starts the administration tools used during the project, including Portainer and the Kubernetes Dashboard.

---

## update-portproxy-rules.bat

Updates Windows `portproxy` rules whenever the WSL2 IP address changes.

This was necessary because WSL2 could receive a different IP address after restarting, requiring the existing forwarding rules to be regenerated.
