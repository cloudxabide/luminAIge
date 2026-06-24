# 

# Overview
This project will involve stakeholders from the customer (GOV analyst org) and ISV (Rancher Government Solutions).

## Customer

Product Manager | Owns Solutions, drives requirements, gauges success
Finance | Consulted
Data Scientist | Builds and maintains AI environment
System Administrator | 
Data Analyst

## ISV
The ISV resources will all be "senior level" - capable of understanding business needs and processes in addition to technical demands.
Account Executive | Owns the customer relationship; ensures customer is heard and scope is protected
Customer Success Manager | Assesses customer technical maturity; identifies training, PS, and enablement needs
Solutions Architect | Owns the technical design; ensures all components integrate coherently
Software Engineer | Implements the architecture; surfaces implementation risks and timeline impacts

# Requirements, Goals, and Constraints (RGC)

Inference Hosting (Containers and VMs)
Testing Workflow
Documentation Repo
Container Registry, File Server
Model registry
Software transport mechanim to acquire software from "external sources"
Artifact Scanning
Software Bill of Materials (SBOM) — generated and maintained for all deployed components
Security is paramount

* Open Source Software (OSS) and Free Open Source Software (FOSS) are permissible but not required; commercial software is equally acceptable.
* Generally the hardware for this project should be considered "Edge" or "Tactical Edge" - meaning, we won't have a Server Rack, there will be reasonable "domestic power" available (120 volt, 20 amp circut)

# Rules and Guidance for engagment
Each person and role needs to focus on this challenge from their own perspective and domain.  I.e. finance should always be questioning the cost and value, the architect needs to be considering how all the things work together (when someone might propose a single component of the entire stack)

# Questions for Claude

* What are the phases of this engagement? 
  * Discovery Session to gather and document requirements, determine "success criteria" (cost, technical objectives)
  * Review proposal
  * POC (Technical Validation)
  * Discuss lessons learned and determine feasiblity (Business Validation)
  * Assess results against "success criteria" metrics
* What does success look like?
  * Define goals and objectives to be measured against (this will be reviewd in the Discovery Session)
* What other things need to be considered?
  * Do we need additional people in the project?
  * What technical pieces are missing from (RGC)


* Should we build "Claude Skills" for each stakeholder that represents their "persona"

# Hints
We have the NVIDIA DGX Spark, 1 x NUC bastion node, 3 x NUC Harvester Cluster, RGS Carbide subscription, Internet connectivity for Bastion (constant)

