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

![Architecture overview](images/architecture-overview.png)

## Proof of Concept

## Implementation Challenges

## Results

## Limitations

## Future Work

## Technologies Used

## License
