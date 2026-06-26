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


---

## Challenge 3 – Hyper-V and VMware Coexistence

### Background

The Proof of Concept was developed and tested in a virtualized environment using VMware while simultaneously relying on Hyper-V technologies required by WSL2.

This introduced additional complexity because both virtualization platforms had to coexist correctly.

### Problem

Several networking and virtualization issues appeared during testing, making it difficult to obtain a stable environment for Kubernetes.

Some features behaved differently depending on the active virtualization configuration.

### Investigation

Different VMware and Hyper-V configurations were evaluated throughout the project.

Special attention was given to nested virtualization support, virtual network adapters, and the interaction between VMware virtual machines and the Hyper-V components used internally by WSL2.

The investigation confirmed that virtualization settings could directly affect the behavior of WSL2 networking and Kubernetes communication.

### Adopted Solution

The final implementation used a configuration that allowed VMware and Hyper-V to coexist while maintaining a stable Kubernetes environment for the Proof of Concept.

Although the configuration required careful setup, it provided reliable operation during the validation tests.

### Lessons Learned

Running VMware together with Hyper-V-based technologies is possible, but requires careful configuration and validation.

Virtualization should be considered an important factor when troubleshooting networking issues involving WSL2 and Kubernetes.

---

## Challenge 4 – Kubernetes Service Exposure (NodePort and Port Forwarding)

### Background

Student development environments needed to be accessible through a web browser from inside the classroom.

Since Kubernetes services were running inside WSL2, exposing them to other workstations required additional networking mechanisms.

### Problem

The default Kubernetes networking configuration was not sufficient to make the services directly reachable from other classroom computers.

Additional mechanisms were required to publish the services outside the WSL2 virtual network.

### Investigation

Several alternatives were evaluated during the project, including Kubernetes NodePort services and different Windows port forwarding approaches.

Each alternative was tested to determine its compatibility with the existing classroom infrastructure and the WSL2 networking model.

### Adopted Solution

The final implementation used Kubernetes services together with Windows port forwarding to expose the required development environments.

This solution provided stable browser access while preserving the existing classroom infrastructure.

### Lessons Learned

Exposing Kubernetes services from WSL2 requires additional networking configuration.

Although this increases deployment complexity, it allows containerized development environments to be integrated into traditional Windows classrooms without modifying the existing Active Directory infrastructure.

---

## Challenge 5 – Persistent Storage Using Windows Bind Mounts

### Background

Student development environments required persistent storage so that files would remain available after containers were restarted or recreated.

By default, storing project data inside the Linux filesystem of WSL2 would make access from Windows less convenient.

### Problem

Project files needed to remain available independently of the lifecycle of Kubernetes containers while also being easily accessible to students from Windows.

### Investigation

Different storage approaches were considered during the design phase.

The selected solution needed to satisfy the following requirements:

* Data persistence after container recreation.
* Easy access from Windows.
* Simple backup and file management.
* Compatibility with Kubernetes volumes.

### Adopted Solution

Persistent storage was implemented using Windows folders mapped into the containers through bind mounts.

Each student has an individual folder on the Windows host that is mounted inside the corresponding development container.

This approach separates application execution from data storage.

### Lessons Learned

Using Windows bind mounts proved to be a practical solution for educational environments.

Students can easily access their files without interacting with the Linux filesystem while preserving all the advantages of containerized development environments.

---

## Challenge 6 – Deployment Scalability

### Background

The Proof of Concept was designed for classroom environments where multiple students require isolated development environments.

As the number of students increases, deployment and management become more complex.

### Problem

Creating Kubernetes resources manually for every student is practical for demonstrations but becomes inefficient in larger classrooms.

Managing dozens of development environments requires automation.

### Investigation

The deployment process was designed with scalability in mind.

PowerShell scripts were developed to automate the creation of Kubernetes resources, persistent storage folders, and browser access configuration.

The architecture was also designed to distribute workloads across the available student workstations instead of relying on a single central server.

### Adopted Solution

The final implementation automates most deployment tasks while allowing each student workstation to contribute computing resources as a Kubernetes worker node.

This distributed approach reduces the hardware requirements of the teacher workstation and makes better use of the existing classroom infrastructure.

### Lessons Learned

Although additional automation would be desirable for large-scale deployments, the Proof of Concept demonstrates that the proposed architecture can be extended to support a greater number of students without fundamentally changing the system design.

Future improvements should focus on simplifying deployment and reducing manual configuration steps.

