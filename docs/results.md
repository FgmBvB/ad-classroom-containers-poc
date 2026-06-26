# Results

## Overview

This document summarizes the results obtained during the Proof of Concept.

The objective was not to build a production-ready platform, but to validate whether container-based development environments could be integrated into existing Active Directory classrooms using Windows, WSL2, Kubernetes and student workstations as worker nodes.

## Achieved Results

The Proof of Concept demonstrated that:

- A lightweight Kubernetes cluster can be deployed using k3s and WSL2.
- The teacher workstation can operate as the Kubernetes control plane.
- Student workstations can join the cluster as worker nodes.
- Development environments can be deployed as isolated Kubernetes pods.
- Students can access their environments through a web browser.
- Student data can persist using Windows bind mounts.
- Existing classroom infrastructure can be reused without replacing Active Directory.

## Validation Environment

The Proof of Concept was validated in a virtualized environment composed of:

- One Active Directory server.
- One teacher workstation.
- Two student workstations.

This environment was sufficient to validate the architecture and demonstrate the feasibility of the proposed approach.

## Key Outcome

The main result of the project is that the architecture is technically feasible as a Proof of Concept.

However, the implementation also showed that networking between Windows, WSL2 and Kubernetes is the most complex part of the solution.

## Not Production Ready

The current implementation should not be considered production-ready.

The main reasons are:

- Manual WSL2 initialization is still required.
- Service exposure depends on Windows port forwarding.
- Student access should be simplified.
- Additional security hardening would be required.
- Larger classroom deployments would require further validation.

## Conclusion

The Proof of Concept successfully validated the core idea: existing Windows classrooms managed through Active Directory can be extended with container-based development environments without replacing the current infrastructure.

At the same time, the project identified important limitations that should be addressed before considering a real deployment.
