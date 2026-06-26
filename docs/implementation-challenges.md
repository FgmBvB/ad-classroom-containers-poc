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

---

## Challenge 2 – WSL2 Mirrored Networking Investigation

### Background

One of the main objectives of the Proof of Concept was to allow every workstation in the classroom to communicate directly through the existing network without requiring additional routing or complex network configuration.

Microsoft introduced **Mirrored Networking** for WSL2 to improve network integration between Windows and Linux. Initially, this appeared to be the ideal solution for the proposed architecture.

### Expected Behavior

The expected behavior was:

* WSL2 should obtain direct access to the classroom network.
* Kubernetes services should become directly reachable from other workstations.
* Port forwarding mechanisms should no longer be necessary.
* Deployment would become considerably simpler.

### Investigation

Several tests were performed using Mirrored Networking.

Although the Linux environment gained improved network integration with Windows, the expected communication between classroom workstations was not consistently achieved under the tested environment.

The behavior was also influenced by the interaction between:

* Hyper-V
* VMware
* Windows networking
* WSL2 virtualization

As a result, Mirrored Networking did not completely eliminate the networking limitations required by the Proof of Concept.

### Adopted Solution

Instead of relying on Mirrored Networking, the final implementation continued using the default WSL2 networking model together with manual service exposure techniques.

This solution provided stable and predictable behavior during testing.

### Lessons Learned

Although Mirrored Networking is a promising feature, its behavior may vary depending on the virtualization environment and network configuration.

For this Proof of Concept, the traditional WSL2 networking model provided more reliable results.


4. Hyper-V and VMware coexistence
5. 
6. Kubernetes service exposure (NodePort and port forwarding)
7. 
8. Persistent storage using Windows bind mounts
9. 
10. Deployment scalability
