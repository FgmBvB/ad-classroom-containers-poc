# Implementation Challenges

## Overview

This document describes the main technical challenges encountered during the implementation of the Proof of Concept.

Rather than focusing only on the final solution, this document records the engineering decisions, observations, and limitations identified while integrating Kubernetes, WSL2, and Windows-based educational environments.

The objective is to document the real implementation experience, including both successful solutions and unresolved limitations.

---

# Challenge 1 – WSL2 Environment Initialization

## Background

One of the objectives of the project was to minimize the number of manual actions required before starting a classroom session.

Ideally, the Kubernetes environment should become available automatically after Windows startup.

## Observed Behavior

After Windows started, the Ubuntu WSL2 distribution was not automatically initialized.

As a consequence, the Kubernetes environment was not immediately available.

However, simply opening the Ubuntu distribution initialized WSL2 correctly. Once Ubuntu started, the k3s services automatically joined the Kubernetes cluster without requiring any additional commands or manual configuration.

## Investigation

Several approaches were explored to automate the initialization process, including Windows startup scripts and Linux startup mechanisms.

None of the evaluated approaches provided a startup sequence that was reliable enough for the purposes of this Proof of Concept.

## Adopted Workaround

The adopted solution consisted of manually opening the Ubuntu distribution before starting the classroom session.

This required only a single click and automatically restored the Kubernetes environment.

After that, the Portainer startup script could be executed and the cluster was ready for use.

## Lessons Learned

The project demonstrated that the proposed architecture works correctly once WSL2 has been initialized.

Automating the startup of the Linux environment remains an area for future improvement.

---

# Challenge 2 – Networking Between Windows and WSL2

## Background

The most significant challenge encountered during the project was networking.

Development environments executed inside Kubernetes pods running on WSL2, while students accessed them from Windows using a web browser.

This required reliable communication between the Windows host and the Linux networking environment.

## Expected Behavior

The initial objective was to simplify networking by using WSL2 Mirrored Networking.

The expected result was that Windows and Linux would share the same network, allowing Kubernetes services to become directly accessible without additional forwarding mechanisms.

## Observed Behavior

Under the testing environment, Mirrored Networking did not behave as expected.

The Linux environment displayed warning messages related to Mirrored Networking, and Kubernetes services were still not directly reachable from student workstations.

As a consequence, components such as NGINX and Traefik could not be used as originally planned.

Student requests reached the Windows host instead of the Linux networking environment where the Kubernetes pods were actually running.

## Adopted Solution

The final implementation exposed Kubernetes services through Windows using `netsh interface portproxy`.

Portproxy redirected incoming Windows connections to the services running inside WSL2.

Although this approach required additional configuration, it provided stable browser access throughout the validation of the Proof of Concept.

## Virtualization Considerations

During the investigation, a possible interaction between VMware Workstation and the Hyper-V technologies required by WSL2 was considered.

Nested virtualization was enabled during testing.

However, the project did not conclusively demonstrate that VMware was the root cause of the networking behavior.

Therefore, this should be regarded as a possible contributing factor rather than a confirmed conclusion.

## Lessons Learned

Networking between Windows and Linux virtualized environments proved to be considerably more complex than initially expected.

Adding multiple abstraction layers—including Windows networking, Hyper-V, WSL2, Kubernetes, browser access and virtualization—can significantly increase the complexity of service communication.

---

# Challenge 3 – Persistent Storage

## Background

Student work needed to remain available even if containers were recreated or the Kubernetes environment was restarted.

## Adopted Solution

Each student was assigned a dedicated Windows directory.

For example:

```text
C:\K3\aula1\vscode\alumno1
```

These directories were automatically created by the deployment script and mounted inside the corresponding Kubernetes container using bind mounts.

This approach ensured that project files remained available independently of the container lifecycle.

## Benefits

* Student work persists across container recreation.
* Files remain directly accessible from Windows.
* No interaction with the Linux filesystem is required.
* Existing Windows backup procedures can still be used.

## Lessons Learned

Separating application execution from data storage simplified classroom management while improving reliability.

---

# Challenge 4 – Deployment Scalability

## Background

The architecture was designed to support multiple students while reusing the existing classroom infrastructure.

Instead of executing every workload on the teacher workstation, student computers participate as Kubernetes worker nodes and contribute their own computing resources.

## Current Validation

The Proof of Concept was validated using:

* One teacher workstation.
* Two virtual student workstations.
* One Active Directory server.

Although the validation environment was intentionally small, the architecture was designed with larger classrooms in mind.

## Current Limitation

Students still need to manually access their assigned development environment.

Simplifying this process would improve usability in larger classroom deployments.

## Future Improvements

Possible future improvements include:

* Fully automated student access.
* Simplified deployment procedures.
* Load balancing across multiple teacher nodes if required.
* Additional automation of Kubernetes resource provisioning.

## Lessons Learned

The project demonstrates that containerized development environments can be distributed across existing classroom computers instead of relying exclusively on a dedicated central server.

This allows existing hardware resources to be reused while maintaining isolated development environments for every student.

The project also demonstrated that integrating multiple software abstraction layers is technically feasible, but considerably increases the complexity of service communication and infrastructure management.



