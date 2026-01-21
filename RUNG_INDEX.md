# Rung Index

**Concept-Tag:** NA0-RUNG-INDEX

Map of the verification ladder (R04–R10).

| Rung | Name | Establishes | Does NOT Claim | Directory | Verifier |
|------|------|-------------|----------------|-----------|----------|
| R04 | Source Snapshot | LaTeX source digest at release | Correctness of content | `proof_artifacts/R04_SOURCE_SNAPSHOT/` | (TODO) |
| R05 | NA0 Definition | Algebraic definition recorded | Novelty or correctness | `proof_artifacts/R05_NA0_DEFINITION/` | (TODO) |
| R06 | Ledger Example Linear | Linear debt example documented | Physical applicability | `proof_artifacts/R06_LEDGER_EXAMPLE_LINEAR/` | (TODO) |
| R07 | Seam Example Projection | Seam projection example documented | Completeness of classification | `proof_artifacts/R07_SEAM_EXAMPLE_PROJECTION/` | (TODO) |
| R08 | Determinism Report | Computational artifacts deterministic | Absence of all nondeterminism | `proof_artifacts/R08_DETERMINISM_REPORT/` | (TODO) |
| R10 | Redaction Scan | No machine paths or tokens tracked | Complete security audit | `proof_artifacts/R10_REDACTION_SCAN/` | VERIFY.sh steps 7-8 |

## Verification Steps (8 total)

1. Git status (clean tree check)
2. Remote URL verification
3. Remote HEAD comparison
4. Required files present
5. Required directories present
6. Forbidden artifacts not tracked
7. Redaction scan (machine paths)
8. Token safety scan

## Notes

- R04–R08 are content rungs with TODO verifiers (manual inspection required)
- R10 is automated via VERIFY.sh
- Rung numbers deliberately do not match RH-debt-ledger-paper (different domain)
- R09 reserved for future assembly receipt
