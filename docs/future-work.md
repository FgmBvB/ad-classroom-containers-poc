# Future Work

## Overview

The Proof of Concept successfully demonstrated the feasibility of integrating Kubernetes-based development environments into existing Active Directory classrooms.

However, several improvements could be implemented before considering a production deployment.

## Planned Improvements

### Automatic WSL2 Initialization

The current implementation requires manually opening the Ubuntu distribution after Windows startup.

A future version should automatically initialize the WSL2 environment without requiring user interaction.

---

### Improved Networking

The networking architecture should be simplified by eliminating the need for Windows port forwarding.

Future work should investigate whether newer WSL2 networking features or alternative Kubernetes networking solutions can provide a cleaner implementation.

---

### Simplified Student Access

Students should be able to access their assigned development environment without manually entering URLs or ports.

Possible improvements include:

* Automatic login.
* Web portal.
* Classroom dashboard.
* Automatic environment assignment.

---

### Deployment Automation

Although the deployment process is already partially automated using PowerShell scripts, additional automation could simplify classroom preparation.

Future improvements may include:

* One-click classroom deployment.
* Automatic student registration.
* Automatic Kubernetes resource generation.
* Automatic cleanup after each session.

---

### Scalability

The current Proof of Concept validates the architecture using a small virtualized environment.

Future work should evaluate:

* Larger classroom deployments.
* Higher numbers of simultaneous students.
* Performance under heavier workloads.
* Multi-classroom deployments.

---

### Security

A production deployment would require additional security mechanisms such as:

* Authentication integration.
* HTTPS.
* Role-Based Access Control (RBAC).
* Network policies.
* Secret management.

## Final Consideration

The current implementation should be considered a Proof of Concept rather than a production-ready platform.

Nevertheless, the project demonstrates that existing Windows classrooms can successfully adopt container-based development environments while preserving their current infrastructure.
