# Future Work

## Overview

The Proof of Concept demonstrated that Kubernetes-based development environments can be integrated into existing Active Directory classrooms while preserving the existing Windows infrastructure.

Although the proposed architecture achieved its primary objectives, several improvements could further simplify deployment, administration and scalability.

---

## Automatic WSL2 Initialization

The current implementation requires manually opening the Ubuntu WSL2 distribution before starting a classroom session.

Future work should investigate mechanisms that allow the Linux environment and the Kubernetes services to start automatically after Windows startup, eliminating the remaining manual step required by the instructor.

---

## Simplified Deployment Workflow

One of the objectives of the project was to minimize the technical knowledge required by instructors.

Future versions could replace the manual configuration of deployment parameters with a graphical interface allowing instructors to:

* Select the development environment.
* Specify the number of students.
* Deploy the complete classroom with a single action.
* Automatically remove classroom resources when the session finishes.

---

## Improved Student Access

Student access could be simplified by automatically assigning each student to the corresponding development environment.

Possible improvements include:

* Automatic URL generation.
* Automatic environment assignment.
* Classroom dashboard for instructors.
* Integration with existing classroom authentication mechanisms.

---

## Networking Improvements

Networking was identified as one of the most challenging aspects of the project.

Future work should evaluate newer WSL2 networking capabilities and alternative Kubernetes networking solutions that could reduce or eliminate the need for Windows port forwarding while maintaining compatibility with existing classroom infrastructures.

---

## Scalability

The architecture was validated using a virtualized environment consisting of one teacher workstation and two student workstations.

Future work should evaluate larger deployments involving complete classrooms in order to analyse:

* Resource distribution across additional worker nodes.
* Performance under higher workloads.
* Scheduling efficiency.
* Resource utilization as additional computers join the cluster.

The distributed nature of Kubernetes makes it possible to increase the available computing capacity by incorporating additional classroom workstations into the cluster.

---

## Security

A production deployment would require additional security mechanisms beyond those implemented in the Proof of Concept.

Future improvements may include:

* HTTPS for browser access.
* Role-Based Access Control (RBAC).
* Kubernetes Network Policies.
* Secure secret management.
* Enhanced authentication mechanisms.

---

## Additional Educational Environments

Although VS Code Server was used during the Proof of Concept, the proposed architecture is not limited to a single application.

Future work could evaluate additional educational environments such as:

* JupyterLab.
* Moodle.
* Apache or Nginx web servers.
* Database servers for practical exercises.
* Other containerized educational applications.

---

## Final Consideration

The current implementation should be regarded as a validated Proof of Concept rather than a production-ready platform.

Nevertheless, the project demonstrates that existing Active Directory classrooms can successfully adopt container-based development environments while reusing their current infrastructure, opening the possibility of progressively introducing cloud-native technologies into educational environments without requiring a complete infrastructure replacement.
