# Status Ledger

**Concept-Tag:** NA0-STATUS-LEDGER

## Current Rung

**R10** — Redaction scan + governance scaffold

## Paper Draft

Location: `na0-paper.tex`, `na0-paper.pdf`

The paper introduces NA0 (Non-Atomic Zero), a framework for projection-honest computation.

## Paid Obligations

| Lane | Status | Rung | Notes |
|------|--------|------|-------|
| Governance scaffold | PAID | R10 | VERIFY.sh + ladder map + status ledger |
| Redaction scan | PAID | R10 | No machine paths in tracked files |
| Token safety | PAID | R10 | No API tokens in tracked files |

## Remaining Obligations

| Item | Status | Notes |
|------|--------|-------|
| Source manifest | UNPAID | R04 digests not yet generated |
| NA0 definition extract | UNPAID | R05 formal definition not extracted |
| Ledger examples | UNPAID | R06/R07 examples not formalized |
| Determinism audit | UNPAID | R08 figure code not audited |
| arXiv submission | NOT DONE | Preprint not yet submitted |
| DOI assignment | NOT DONE | Zenodo/DOI pending |

## Verification Commands

**Baseline verification (8 steps):**
```bash
VR_STRICT=1 ./VERIFY.sh
```

## What This Repo Is

- LaTeX source for NA0 paper
- Governance scaffold with verification ladder
- Deterministically verifiable artifact chain (in progress)

## What This Repo Is NOT

- A proof of RH or any other conjecture
- A claim that NA0 solves any open problem
- A substitute for peer review
- A complete or final implementation
