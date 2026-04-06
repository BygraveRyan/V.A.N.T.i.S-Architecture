#!/bin/bash
# V.A.N.T.i.S. System Diagnostic Hook
# Version: 1.1.0 (Hybrid Upgrade)
# Purpose: Identifies performance bottlenecks, protocol drift, and vault hygiene issues.

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== V.A.N.T.i.S. SYSTEM DIAGNOSTIC ===${NC}"
echo -e "Date: $(date +%Y-%m-%d)"
echo ""

# --- 1. PERFORMANCE & BLOAT (CONTEXT DEBT) ---
echo -e "${YELLOW}[1/5] AUDITING PERFORMANCE & BLOAT...${NC}"
CHECK_DIRS=("02_MACHINE" "logs" "06_OUTPUT")

for dir in "${CHECK_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        SIZE=$(du -sh "$dir" | cut -f1)
        FILE_COUNT=$(find "$dir" -type f | wc -l | xargs)
        echo -e "  [INFO] $dir: $SIZE ($FILE_COUNT files)"
        
        # Performance Warning Thresholds
        if [ "$dir" == "02_MACHINE" ] && [ "$FILE_COUNT" -gt 500 ]; then
            echo -e "  [${YELLOW}WARN${NC}] $dir is heavy. Consider archiving or compacting."
        fi
    fi
done

# --- 2. INTEGRITY & RESUMPTION (SYMLINKS) ---
echo ""
echo -e "${YELLOW}[2/5] VERIFYING SYSTEM INTEGRITY...${NC}"
LATEST_STATE="02_MACHINE/State/session-state_LATEST.md"
if [ -L "$LATEST_STATE" ]; then
    TARGET=$(readlink "$LATEST_STATE")
    if [ -f "02_MACHINE/State/$TARGET" ] || [ -f "$TARGET" ]; then
        echo -e "  [${GREEN}PASS${NC}] Resumption Symlink: Valid ($TARGET)"
    else
        echo -e "  [${RED}FAIL${NC}] Resumption Symlink: BROKEN (Points to $TARGET)"
    fi
else
    echo -e "  [${RED}FAIL${NC}] Resumption Symlink: MISSING ($LATEST_STATE)"
fi

# --- 3. PROTOCOL DRIFT (ASV REFLEX) ---
echo ""
echo -e "${YELLOW}[3/5] AUDITING PROTOCOL DRIFT...${NC}"
DIRTY_PROTOCOLS=$(git status --porcelain 03_SYSTEM/Protocols/ | wc -l | xargs)
if [ "$DIRTY_PROTOCOLS" -gt 0 ]; then
    echo -e "  [${YELLOW}WARN${NC}] $DIRTY_PROTOCOLS uncommitted changes in 03_SYSTEM/Protocols/."
    echo -e "         Ensure the 'ASV Reflex' (version increment) was applied."
else
    echo -e "  [${GREEN}PASS${NC}] Protocols are in sync with repository."
fi

# --- 4. CORE METADATA AUDIT ---
echo ""
echo -e "${YELLOW}[4/5] AUDITING CORE METADATA...${NC}"
CORE_FILES=("VAULT_MAP.md" "RULES.md" "03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md" "GEMINI.md" "CLAUDE.md" "AGENTS.md" "BOOT_IMAGE.md")
MISSING_METADATA=0

for file in "${CORE_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo -e "  [${RED}ERR${NC}] $file: File not found!"
        MISSING_METADATA=$((MISSING_METADATA + 1))
        continue
    fi
    
    VERSION=$(grep -Ei "Version: [0-9]+\.[0-9]+" "$file" || grep -Ei "v[0-9]+\.[0-9]+" "$file")
    if [ -z "$VERSION" ]; then
        echo -e "  [${RED}FAIL${NC}] $file: Missing Version metadata."
        MISSING_METADATA=$((MISSING_METADATA + 1))
    else
        echo -e "  [${GREEN}PASS${NC}] $file: $VERSION"
    fi
done

# --- 5. AUDIT TRAIL VERIFICATION ---
echo ""
echo -e "${YELLOW}[5/5] VERIFYING TODAY'S AUDIT TRAIL...${NC}"
TODAY=$(date +%Y-%m-%d)
LOG_DIR="logs/$TODAY"
if [ -d "$LOG_DIR" ]; then
    LOG_COUNT=$(ls -1 "$LOG_DIR"/*.md 2>/dev/null | wc -l | xargs)
    if [ "$LOG_COUNT" -gt 0 ]; then
        echo -e "  [${GREEN}PASS${NC}] Audit trail for today exists ($LOG_COUNT logs)."
    else
        echo -e "  [${RED}FAIL${NC}] No logs found in $LOG_DIR/."
    fi
else
    echo -e "  [${RED}FAIL${NC}] Log directory for today ($LOG_DIR) is missing."
fi

echo ""
echo -e "${BLUE}=== DIAGNOSTIC COMPLETE ===${NC}"
if [ $MISSING_METADATA -gt 0 ]; then
    echo -e "${RED}Result: $MISSING_METADATA protocol violations found.${NC}"
    exit 1
else
    echo -e "${GREEN}Result: System is Healthy (Infrastructure & Protocols compliant).${NC}"
    exit 0
fi
