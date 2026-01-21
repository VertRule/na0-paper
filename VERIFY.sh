#!/bin/sh
# VERIFY.sh - Deterministic verification script for na0-paper
# Checks: clean state, remote alignment, required files, forbidden artifacts, redaction
#
# Environment variables:
#   VR_STRICT=1  - Treat dirty working tree as error (default: warning only)
set -e

EXPECTED_REMOTE_SSH="git@github.com:VertRule/na0-paper.git"
EXPECTED_REMOTE_HTTPS="https://github.com/VertRule/na0-paper"
ERRORS=0
DIRTY_TREE=0

error() {
    echo "ERROR: $1" >&2
    ERRORS=$((ERRORS + 1))
}

warn() {
    echo "WARNING: $1" >&2
}

echo "=== NA0 Paper Verification ==="
echo ""

# 1) Check git clean status
echo "[1/8] Checking git status..."
if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
    warn "Working tree is dirty (uncommitted changes present)"
    DIRTY_TREE=1
fi
if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
    warn "Untracked or modified files present"
    DIRTY_TREE=1
fi
if [ "$DIRTY_TREE" -eq 0 ]; then
    echo "  OK: Working tree is clean"
else
    echo "  OK (warnings above)"
fi

# 2) Verify remote URL (accept SSH or HTTPS)
echo "[2/8] Checking remote URL..."
ACTUAL_REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
if [ "$ACTUAL_REMOTE" = "$EXPECTED_REMOTE_SSH" ] || [ "$ACTUAL_REMOTE" = "$EXPECTED_REMOTE_HTTPS" ]; then
    echo "  OK: $ACTUAL_REMOTE"
else
    error "Remote mismatch: got '$ACTUAL_REMOTE'"
fi

# 3) Verify local HEAD equals origin/main (soft check)
echo "[3/8] Fetching and comparing with origin/main..."
git fetch origin main --quiet 2>/dev/null || warn "Could not fetch origin/main"
LOCAL_HEAD=$(git rev-parse HEAD 2>/dev/null || echo "")
REMOTE_HEAD=$(git rev-parse origin/main 2>/dev/null || echo "")
if [ -z "$LOCAL_HEAD" ] || [ -z "$REMOTE_HEAD" ]; then
    warn "Could not compare HEAD with origin/main"
elif [ "$LOCAL_HEAD" != "$REMOTE_HEAD" ]; then
    warn "HEAD ($LOCAL_HEAD) differs from origin/main ($REMOTE_HEAD)"
else
    echo "  OK: HEAD matches origin/main"
fi

# 4) Verify required tracked files exist
echo "[4/8] Checking required files..."
REQUIRED_FILES="README.md STATUS.md RUNG_INDEX.md na0-paper.tex na0-paper.pdf LICENSE .gitignore"
for f in $REQUIRED_FILES; do
    if [ ! -f "$f" ]; then
        error "Required file missing: $f"
    fi
done
echo "  OK: All required files present"

# 5) Verify required directories exist
echo "[5/8] Checking required directories..."
REQUIRED_DIRS="proof_artifacts/R04_SOURCE_SNAPSHOT proof_artifacts/R05_NA0_DEFINITION proof_artifacts/R06_LEDGER_EXAMPLE_LINEAR proof_artifacts/R07_SEAM_EXAMPLE_PROJECTION proof_artifacts/R08_DETERMINISM_REPORT proof_artifacts/R10_REDACTION_SCAN"
for d in $REQUIRED_DIRS; do
    if [ ! -d "$d" ]; then
        error "Required directory missing: $d"
    fi
done
echo "  OK: All required directories present"

# 6) Verify forbidden artifacts are NOT tracked
echo "[6/8] Checking forbidden artifacts are not tracked..."
FORBIDDEN_PATTERNS="operator_private/ .env credentials secrets"
TRACKED_FILES=$(git ls-files 2>/dev/null)
for pattern in $FORBIDDEN_PATTERNS; do
    if echo "$TRACKED_FILES" | grep -q "$pattern"; then
        error "Forbidden artifact is tracked: $pattern"
    fi
done
echo "  OK: No forbidden artifacts tracked"

# 7) Paranoia grep for machine-specific paths (redaction scan)
# Note: patterns are split to avoid self-matching
echo "[7/8] Running redaction scan..."
USERS_PATTERN="/Us""ers/"
MACBOOK_PATTERN="Davids""-MacBook"
MATCHES=$(git ls-files | xargs grep -l -i "$USERS_PATTERN" 2>/dev/null | grep -v 'VERIFY' || true)
if [ -n "$MATCHES" ]; then
    echo "$MATCHES"
    error "Found '$USERS_PATTERN' path in tracked files (redaction failure)"
fi
MATCHES=$(git ls-files | xargs grep -l -i "$MACBOOK_PATTERN" 2>/dev/null | grep -v 'VERIFY' || true)
if [ -n "$MATCHES" ]; then
    echo "$MATCHES"
    error "Found '$MACBOOK_PATTERN' in tracked files (redaction failure)"
fi
echo "  OK: No machine-specific paths found"

# 8) Token safety scan
echo "[8/8] Running token safety scan..."
TOKEN_PATTERNS="sk-ant- ANTHROPIC_API_KEY Bearer.*[a-zA-Z0-9]{20}"
for pattern in $TOKEN_PATTERNS; do
    MATCHES=$(git ls-files | xargs grep -l -E "$pattern" 2>/dev/null | grep -v 'VERIFY' || true)
    if [ -n "$MATCHES" ]; then
        echo "$MATCHES"
        error "Found potential token pattern in tracked files"
    fi
done
echo "  OK: No token patterns found"

echo ""
if [ "$ERRORS" -gt 0 ]; then
    echo "=== VERIFICATION FAILED: $ERRORS error(s) ==="
    exit 1
fi

# In strict mode, dirty tree is an error
if [ "${VR_STRICT:-0}" = "1" ] && [ "$DIRTY_TREE" -eq 1 ]; then
    echo "=== VERIFICATION FAILED: Dirty tree in strict mode ==="
    exit 1
fi

echo "=== VERIFICATION PASSED (8/8) ==="
exit 0
