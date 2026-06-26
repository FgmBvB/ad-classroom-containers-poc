# Proof of Concept for Integrating Container-Based Development Environments into Existing Active Directory Classrooms
A final degree project exploring the feasibility of integrating container-based development environments into traditional Windows classrooms managed by Active Directory Domain Services (AD DS).

## Overview

Many educational institutions, particularly those offering technology-related programs, rely on Windows-based computer labs managed through Active Directory Domain Services (AD DS). This infrastructure provides centralized authentication, user management, and policy enforcement, but it was not originally designed for container-based development workflows.

As container technologies have become increasingly common in modern software development, integrating them into existing educational infrastructures without disrupting established IT environments remains a significant challenge.

This project explores the feasibility of integrating container-based development environments into traditional Active Directory classrooms through a Proof of Concept.

**Research Question**

> Can container-based development environments be integrated into existing Active Directory classrooms without replacing the existing infrastructure?

## Key Features

- Proof of Concept for integrating containerized development environments into existing Active Directory classrooms.
- Kubernetes (k3s) running on WSL2.
- Automated deployment and provisioning using PowerShell.
- Browser-based development environment using VS Code Server.
- Persistent storage for each student.
- Investigation of networking issues in a WSL2 and VMware environment.
- Documentation of implementation challenges, design decisions, workarounds, and identified limitations.

## Problem Statement

Many educational institutions offering technology-related programs rely on Windows-based computer labs managed through Active Directory Domain Services (AD DS). This infrastructure simplifies user authentication, centralized management, and policy enforcement, making it a common choice for educational environments.

However, modern software development increasingly relies on containerized environments to ensure consistency, isolation, and reproducibility. Integrating these technologies into existing Active Directory classrooms presents several challenges, including deployment complexity, infrastructure compatibility, networking, and persistent storage.

Replacing an existing classroom infrastructure is often impractical due to financial, administrative, and operational constraints. Therefore, educational institutions require solutions capable of introducing modern development environments while preserving their current infrastructure and management model.

This project investigates whether a Kubernetes-based container platform can be integrated into an existing Active Directory classroom through a Proof of Concept, minimizing infrastructure changes while providing isolated development environments for students.

## Objectives
The main objective of this Proof of Concept is to evaluate the feasibility of integrating container-based development environments into existing Active Directory classrooms without replacing the existing infrastructure.

To achieve this goal, the project pursues the following objectives:

- Design a container-based development environment using Kubernetes (k3s) and WSL2.
- Provide isolated development environments for multiple students.
- Automate the deployment process using PowerShell.
- Provide persistent storage for each student environment.
- Minimize changes to the existing Active Directory infrastructure.
- Evaluate networking compatibility between Windows, WSL2, Hyper-V, and VMware.
- Identify implementation challenges and document the adopted workarounds.

## Proposed Architecture

The proposed architecture is based on a Windows workstation running WSL2 and a lightweight Kubernetes (k3s) cluster. Student development environments are deployed as isolated containers running VS Code Server, with persistent storage mapped to the Windows host.

The following diagram illustrates the overall architecture of the Proof of Concept.

<p align="center">
  <img src="images/architecture-overview.png" width="1000">
</p>

## Proof of Concept

This project implements a Proof of Concept (PoC) demonstrating that modern container-based development environments can be integrated into existing Active Directory classrooms without replacing the current infrastructure.

The implementation was designed for educational environments where Windows-based workstations are already managed through Active Directory Domain Services (AD DS). Instead of introducing dedicated servers, the existing classroom computers participate in a lightweight Kubernetes cluster.

### Main Characteristics

- Teacher workstation acts as the Kubernetes control plane.
- Student workstations join the cluster as worker nodes using WSL2.
- Development environments are deployed as isolated Kubernetes pods.
- Student files are stored in Windows host folders using bind mounts.
- Existing Active Directory authentication and classroom management remain unchanged.
- The solution reuses the hardware resources already available in the classroom.

### Demonstrated Features

The Proof of Concept successfully demonstrated:

- Automated deployment of development environments.
- Multi-student isolated workspaces.
- Persistent storage across sessions.
- Browser-based access to development tools.
- Centralized management through Kubernetes and Portainer.
- Compatibility with existing Windows classroom infrastructure.

This repository documents both the implementation process and the technical challenges encountered while integrating Kubernetes, WSL2, Hyper-V, and VMware into an educational environment.

## Implementation Challenges

During the implementation of this Proof of Concept, several technical challenges were identified. These challenges were mainly related to the interaction between Windows, WSL2, Kubernetes, VMware, and the networking model required to expose services across the classroom.

Rather than hiding these issues, this project documents them as part of the engineering process. The goal was not only to build a working prototype, but also to understand the limitations, workarounds, and design trade-offs involved in running container-based development environments on top of an existing Windows and Active Directory infrastructure.

The main challenges identified were:

- WSL2 initialization during system startup.
- Networking behavior between WSL2, Hyper-V, and VMware.
- Limitations encountered while testing WSL2 mirrored networking.
- Service exposure using NodePort and port forwarding.
- Use of Windows bind mounts for persistent student storage.
- Operational complexity when scaling the deployment to multiple students.


## Results

## Limitations

## Future Work

## Technologies Used

## License
