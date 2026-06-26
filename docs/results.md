# Results

## Overview

This document summarizes the outcomes of the Proof of Concept and evaluates whether the proposed architecture achieved its original objectives.

The goal of the project was not to build a production-ready platform, but to determine whether Kubernetes-based development environments could be integrated into existing Active Directory classrooms while preserving the existing Windows infrastructure.

---

## Achieved Objectives

The Proof of Concept successfully demonstrated that:

* A lightweight Kubernetes cluster can be deployed using k3s on top of WSL2.
* A teacher workstation can successfully operate as the Kubernetes control plane.
* Student workstations can join the cluster as Kubernetes worker nodes.
* Development environments can be deployed as isolated Kubernetes pods.
* Students can access their development environments through a standard web browser.
* Student files can persist independently of the container lifecycle by using Windows bind mounts.
* Existing Active Directory administration and classroom management can remain unchanged.

---

## Validation Environment

The proposed architecture was validated using a virtualized classroom environment consisting of:

* One Active Directory server.
* One teacher workstation.
* Two student workstations.

Although intentionally limited in size, this environment was sufficient to validate the proposed architecture, deployment workflow and communication between the different system components.

---

## Engineering Findings

Beyond validating the proposed architecture, the project provided several practical engineering observations.

The most significant challenges were not related to Kubernetes itself, but to the interaction between Windows, WSL2, networking and virtualization.

The investigation demonstrated that integrating multiple infrastructure layers can introduce unexpected complexity, particularly when exposing Kubernetes services running inside WSL2 to external Windows clients.

These findings influenced several implementation decisions, including the adoption of Windows port forwarding and deployment automation scripts.

---

## Current Limitations

Although the Proof of Concept successfully achieved its objectives, several limitations remain before the proposed solution could be considered for production environments.

The current implementation still requires:

* Manual initialization of the WSL2 environment.
* Windows port forwarding to expose Kubernetes services.
* Manual configuration of certain deployment parameters.
* Additional security hardening.
* Validation in larger classroom environments.

These limitations do not invalidate the proposed architecture but identify areas requiring further engineering work.

---

## Conclusion

The Proof of Concept successfully demonstrated that Kubernetes-based development environments can be integrated into existing Windows classrooms managed through Active Directory without replacing the existing infrastructure.

The project also highlighted the practical challenges involved in combining Windows, WSL2, Kubernetes and virtualization technologies within the same environment.

Overall, the results indicate that the proposed architecture is technically feasible while identifying the engineering improvements required before considering a production deployment.
