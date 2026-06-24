# Discovery Session Agenda

---

| Field        | Value |
|---|---|
| **Document Author** | RGS Solutions Architect |
| **Author Org** | Rancher Government Solutions (RGS) |
| **Audience** | All project stakeholders |
| **Phase** | Discovery |
| **Status** | Draft — pending customer PM approval |
| **Date** | TBD |
| **Location / Format** | TBD |

---

## Purpose

The purpose of this Discovery Session is to gather, clarify, and document the customer's requirements, constraints, and success criteria in sufficient detail to produce a formal proposal. At the conclusion of this session, both RGS and the customer should have a shared, written understanding of what will be built, how success will be measured, and what constraints the solution must operate within.

---

## Attendees

| Role | Organization | Required |
|---|---|---|
| Product Manager | Customer | Yes |
| Data Scientist | Customer | Yes |
| System Administrator | Customer | Yes |
| Data Analyst | Customer | Recommended |
| Finance Representative | Customer | Recommended |
| Solutions Architect | RGS | Yes |
| Software Engineer | RGS | Yes |

---

## Agenda

### 1. Introductions and Rules of Engagement *(15 min)*
- Attendee introductions — role and area of responsibility
- Review of engagement model: each stakeholder is expected to speak from their domain
- Ground rules: no deferred questions, all concerns surfaced here are valid

**Owner:** RGS SA

---

### 2. Project Overview and Objectives *(20 min)*
- Review of the Project Charter (distributed in advance)
- Confirm the engagement phases: Discovery → Proposal Review → POC → Lessons Learned → Success Criteria Assessment
- Confirm the scope boundary: what is in scope for this engagement and what is explicitly out of scope
- Open discussion: does the charter reflect the customer's understanding?

**Owner:** RGS SA  
**Customer Lead:** Customer PM

---

### 3. Requirements Deep-Dive *(45 min)*
Walk through each item in the Requirements, Goals, and Constraints (RGC) section of the charter. For each item, document: current state, desired state, and any constraints.

| Requirement Area | Discussion Points |
|---|---|
| Inference Hosting | What models? What concurrency? Who accesses inference — analysts, automated pipelines, or both? |
| Testing Workflow | What does "tested" mean for this platform? Who runs tests and when? |
| Documentation Repository | Where does documentation live? Who maintains it post-handoff? |
| Container Registry / File Server | Air-gap or semi-air-gap? Pull-through cache from bastion? |
| Model Registry | What metadata must be tracked per model? Who approves models for production use? |
| Software Transport | What is the approved path from internet to the isolated environment? Bastion-only? |
| Artifact Scanning | What scanner(s) are acceptable? What is the policy for a scan failure? |
| SBOM | What format is required (CycloneDX, SPDX)? Who consumes the SBOM and for what purpose? |
| Security Baseline | Is there a required compliance framework (NIST 800-53, STIG)? What is the target classification level? |

**Owner:** RGS SA  
**Technical Lead:** RGS SE (implementation perspective), Customer Data Scientist (AI/ML perspective), Customer Sys Admin (operational/security perspective)

---

### 4. Hardware and Environment Review *(20 min)*
- Confirm available hardware: NVIDIA DGX Spark, 1x NUC bastion, 3x NUC Harvester cluster
- Power and space constraints: 120V/20A, no server rack — confirm no exceptions
- Network topology: document which nodes have internet access, which are isolated, and what the approved transport path is
- Confirm RGS Carbide subscription status and entitlements

**Owner:** RGS SA  
**Customer Lead:** Customer Sys Admin

---

### 5. Success Criteria Definition *(30 min)*
This is the most important section of the Discovery Session. We will collaboratively define the measurable outcomes that determine whether this engagement has succeeded.

Categories to define metrics for:

- **Technical Performance** — inference latency targets, concurrent user capacity, uptime/availability targets
- **Security Posture** — SBOM coverage, scan pass rate, hardening baseline achieved
- **Operability** — time to deploy from scratch, runbook completeness, staff able to operate without RGS involvement
- **Cost** — total engagement cost within approved budget, ongoing operational cost identified and documented
- **Timeline** — milestones met, POC completed within agreed window

**Owner:** RGS SA  
**Customer Leads:** Customer PM (business criteria), Customer Data Scientist (technical/AI criteria), Customer Finance (cost criteria)

---

### 6. Open Questions and Risk Identification *(20 min)*
- Surface any requirements not yet captured
- Identify risks: technical, schedule, budget, staffing, compliance
- Document assumptions being made by both sides
- Confirm: do we need additional stakeholders not present today?

**Owner:** RGS SA (facilitates), all attendees contribute

---

### 7. Next Steps and Close *(10 min)*
- RGS SA to circulate Discovery Session notes within [X] business days
- Customer PM to review and approve notes
- RGS to produce formal proposal within [X] business days of note approval
- Confirm date for Proposal Review session

**Owner:** RGS SA  
**Approver:** Customer PM

---

## Pre-Work (Distributed in Advance)

The following should be reviewed by all attendees before the session:

- [ ] Project Charter (`Project_Charter.md`)
- [ ] Hardware inventory confirmation (Customer Sys Admin to verify)
- [ ] Carbide subscription entitlements (Customer PM / RGS SA to confirm)

---

## Document Revision History

| Version | Date | Author (Role) | Change |
|---|---|---|---|
| 0.1 | TBD | RGS Solutions Architect | Initial draft |

---
