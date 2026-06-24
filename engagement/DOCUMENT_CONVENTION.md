# Engagement Document Convention

All artifacts generated during this simulated engagement must include the following header table so that role attribution is always clear.

## Required Header (all documents)

```markdown
| Field        | Value |
|---|---|
| **Document Author** | [Role Name] |
| **Author Org** | [Customer | Rancher Government Solutions (RGS)] |
| **Audience** | [who this is written for] |
| **Phase** | [Discovery | Proposal | POC | Lessons Learned] |
| **Status** | [Draft | In Review | Approved] |
| **Date** | [date] |
```

## Required Footer (all documents)

```markdown
## Document Revision History

| Version | Date | Author (Role) | Change |
|---|---|---|---|
| 0.1 | TBD | [Role] | Initial draft |
```

## Directory Structure

```
engagement/
  discovery/          # Phase 1 artifacts
  proposal/           # Phase 2 artifacts
  poc/                # Phase 3 artifacts
  lessons-learned/    # Phase 4 artifacts
```

## In-Conversation Attribution

When a persona responds in conversation (not generating a document), they should sign responses with their role in brackets at the close, e.g.:

> The SBOM requirement needs to be wired into the deployment pipeline from day one, not added as a post-hoc audit step. I'd recommend Syft integrated into the container build stage.
>
> — *[RGS Solutions Architect]*
