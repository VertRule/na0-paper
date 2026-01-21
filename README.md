# Non-Atomic Zero: A Unified Theory of Projection-Honest Computation

**Status: pre-submission draft**

**[Read the paper (PDF)](na0-paper.pdf)**

## Verify

```bash
git clone https://github.com/VertRule/na0-paper
cd na0-paper
VR_STRICT=1 ./VERIFY.sh
```

Expected output: `=== VERIFICATION PASSED (8/8) ===`

## Build

Requires a LaTeX distribution with `latexmk`. Tested with TeX Live 2024+.

```bash
latexmk -pdf na0-paper.tex
```

Output: `na0-paper.pdf`

PDF is included for convenience; source is authoritative; rebuild via latexmk.

## Figures

All figures are pre-rendered PNGs in `figures/`. No additional scripts required to build the paper.

## Citation

Cite this repository by release tag + commit SHA until an arXiv ID is assigned.

See `CITATION.cff` for structured citation metadata.

## Issues

Report issues via GitHub Issues or email: Dave@vertrule.com

## Non-Claims

This paper and repository do **NOT** claim:

- **Not a proof of RH** — NA0 is a bookkeeping formalism, not a proof technique
- **Not a solution to any open problem** — we introduce notation, not theorems
- **Not a complete framework** — this is an initial presentation of the concept
- **Not peer reviewed** — preprint status, external review pending

NA0 is a formalism for tracking "projection debt" — information discarded by totalization operations. It makes no claims about resolving that debt.

## Artifact Map

- **Rung index:** [RUNG_INDEX.md](RUNG_INDEX.md) — R04 through R10
- **Status ledger:** [STATUS.md](STATUS.md) — paid/unpaid obligations
- **Proof artifacts:** `proof_artifacts/` — rung-specific verification data

## License

CC BY 4.0 — See [LICENSE](LICENSE)
