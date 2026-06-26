# Deployment

## Overview

This document describes the deployment process used during the Proof of Concept.

The deployment was designed to reuse an existing Active Directory classroom without requiring additional server infrastructure.

## Deployment Process

The deployment consists of the following steps:

1. Start the teacher workstation.
2. Initialize the WSL2 environment.
3. Start the k3s control plane.
4. Verify that the Kubernetes cluster is available.
5. Student workstations initialize WSL2.
6. Each student workstation automatically joins the Kubernetes cluster as a worker node.
7. Development containers are deployed from the teacher workstation using PowerShell automation.
8. Students access their isolated development environment through a web browser.

## Automation

The deployment process was partially automated using PowerShell scripts.

The automation was responsible for:

* Creating Kubernetes resources.
* Deploying development containers.
* Creating persistent storage folders.
* Configuring Kubernetes Services.
* Assigning ports for browser access.

  ## Instructor-Oriented Design

One of the design goals of the Proof of Concept was to reduce the need for instructors to interact directly with Kubernetes commands.

The deployment workflow was designed so that the instructor could launch classroom environments through scripts instead of manually creating Kubernetes resources.

The deployment process was designed so that instructors would not need to manually create Kubernetes resources. The instructor only needed to select the desired container image, adjust the number of students if required, and execute the deployment script.

In the implemented version, some values still had to be adjusted in the deployment script, such as the number of students or the selected container image. This was identified as a limitation of the Proof of Concept rather than a final design objective.

## Persistent Storage

Each student environment stores its data using Windows bind mounts.

Instead of storing project files inside the Linux filesystem used by WSL2, persistent directories are created on the Windows host.

This approach allows files to remain accessible from Windows while preserving data after container recreation.

## Deployment Limitations

The deployment achieved the objectives of the Proof of Concept.

However, several limitations were identified:

* Manual WSL2 initialization.
* Manual service exposure.
* Limited deployment scalability.
* Networking issues related to WSL2 and virtualization.

These limitations are discussed in detail in the Implementation Challenges documentation.
