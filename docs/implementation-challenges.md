# Implementation Challenges

## Overview

This document describes the main technical challenges encountered during the implementation of the Proof of Concept.

Rather than only presenting the final solution, this document records the engineering process followed to investigate, understand, and solve the problems that appeared while integrating Kubernetes, WSL2, Hyper-V, VMware, and Windows-based educational environments.

The documented challenges represent real implementation issues encountered during the project.

## Challenges

1. WSL2 initialization after Windows startup
2. WSL2 mirrored networking limitations
3. Hyper-V and VMware coexistence
4. Kubernetes service exposure (NodePort and port forwarding)
5. Persistent storage using Windows bind mounts
6. Deployment scalability
