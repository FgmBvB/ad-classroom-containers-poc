# Implementation Challenges

## Overview

This document describes the main technical challenges encountered during the implementation of the Proof of Concept.

Rather than only presenting the final solution, this document records the engineering process followed to investigate, understand, and solve the problems that appeared while integrating Kubernetes, WSL2, Hyper-V, VMware, and Windows-based educational environments.

The documented challenges represent real implementation issues encountered during the project.

## Challenges

---

## Challenge 1 – WSL2 initialization after Windows startup

### Problem

The original objective was for every student workstation to automatically start WSL2 and immediately join the Kubernetes cluster after Windows boot.

However, this behavior could not be achieved reliably.

### Investigation

Several approaches were evaluated in order to automatically initialize the Linux environment during system startup.

Among the tested approaches were:

- Windows startup scripts.
- Scheduled Tasks.
- Linux startup scripts.
- Cron jobs inside WSL2.

Although these methods successfully launched different processes, none of them consistently initialized the complete WSL2 environment required by k3s.

As a result, the Kubernetes agent did not always start correctly after Windows boot.

### Adopted Workaround

The adopted solution was to manually open the Ubuntu WSL2 distribution after Windows startup.

Once Ubuntu was started, the Linux environment initialized correctly and the k3s agent automatically joined the Kubernetes cluster without requiring additional user interaction.

### Lessons Learned

WSL2 does not currently provide a completely reliable mechanism for automatically initializing complex Linux services immediately after Windows startup in every environment.

For the purposes of this Proof of Concept, a manual initialization step was considered acceptable because it does not affect the technical feasibility of the proposed architecture.

2. WSL2 mirrored networking limitations
3. 
4. Hyper-V and VMware coexistence
5. 
6. Kubernetes service exposure (NodePort and port forwarding)
7. 
8. Persistent storage using Windows bind mounts
9. 
10. Deployment scalability
