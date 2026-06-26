# Architecture

## Overview

This document describes the architecture of the Proof of Concept developed to evaluate the integration of Kubernetes-based development environments into existing Active Directory classrooms.

The proposed architecture reuses the existing classroom infrastructure while introducing containerized development environments with minimal changes to the traditional management model.

The architecture consists of three main components:

- Active Directory infrastructure
- Teacher workstation (Kubernetes Control Plane)
- Student workstations (Worker Nodes)

## Architecture Diagram

![Architecture](../images/architecture-overview.png)

### 1. Active Directory Infrastructure

The existing Active Directory Domain Services (AD DS) infrastructure remains unchanged.

It continues to provide:

- User authentication.
- Group Policy management.
- User and computer administration.

The Proof of Concept does not replace or modify the existing Active Directory environment. Instead, it integrates Kubernetes-based development environments while preserving the traditional classroom management model.

2. Teacher PC

3. Student PCs

4. Persistent Storage

5. Containerized Development Environment
