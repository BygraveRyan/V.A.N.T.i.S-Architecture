#!/bin/bash

# V.A.N.T.i.S. OpenRouter Build Wrapper
# Usage: ./openrouter-build.sh --plan [plan_file] [--profile continuity|cheap|build] [--model model_id]

# Backward-compatible default:
# preserve the existing low-cost build path unless a profile/model is specified.
DEFAULT_BUILD_MODEL="${OPENROUTER_DEFAULT_MODEL:-deepseek/deepseek-chat}"
MODEL="$DEFAULT_BUILD_MODEL"
PLAN_FILE=""
FORCE=false
PROFILE="build"
# Try both common variable names
OR_KEY="${OPENROUTER_API_KEY:-$OPEN_ROUTER_API}"

profile_to_model() {
    case "$1" in
        continuity)
            echo "${OPENROUTER_CONTINUITY_MODEL:-anthropic/claude-sonnet-4}"
            ;;
        cheap)
            echo "${OPENROUTER_CHEAP_MODEL:-qwen/qwen3-coder-next}"
            ;;
        build)
            echo "$DEFAULT_BUILD_MODEL"
            ;;
        *)
            return 1
            ;;
    esac
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --profile) PROFILE="$2"; shift ;;
        --model) MODEL="$2"; shift ;;
        --plan) PLAN_FILE="$2"; shift ;;
        --force) FORCE=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ -z "$PLAN_FILE" ]; then
    echo "Error: --plan [plan_file] is required."
    exit 1
fi

if ! PROFILE_MODEL=$(profile_to_model "$PROFILE"); then
    echo "Error: Unsupported --profile value '$PROFILE'. Use continuity, cheap, or build."
    exit 1
fi

if [[ "$MODEL" == "$DEFAULT_BUILD_MODEL" ]] && [[ "$PROFILE" != "build" ]]; then
    MODEL="$PROFILE_MODEL"
fi

if [ -z "$OR_KEY" ]; then
    echo "Error: OpenRouter API key is not set (checked OPENROUTER_API_KEY and OPEN_ROUTER_API)."
    exit 1
fi

# 1. SECURITY GATE: DeepSeek / Tencent / Offshore Warning
if [[ $MODEL == *"deepseek"* ]] || [[ $MODEL == *"tencent"* ]] || [[ $MODEL == *"hunyuan"* ]]; then
    if [ "$FORCE" = true ]; then
        echo "⚠️  ZERO-TRUST SECURITY GATE BYPASSED (--force active)"
    else
        echo "----------------------------------------------------------------"
        echo "⚠️  ZERO-TRUST SECURITY ALERT (Offshore/Chinese Model Detected)"
        echo "----------------------------------------------------------------"
        echo "Target Model: $MODEL"
        echo "Ensure your payload contains NO:"
        echo " - Plain-text API keys"
        echo " - Naked URLs or PII"
        echo " - Proprietary IP or Financial Data"
        echo ""

        # Check if we are in an interactive terminal
        if [ -t 0 ]; then
            read -p "Confirm payload is scrubbed? (y/n) " -n 1 -r
            echo ""
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "Aborting build."
                exit 1
            fi
        else
            echo "Error: Non-interactive environment detected. Use --force to bypass the security gate."
            exit 1
        fi
    fi
fi

# 2. CONTEXT AGGREGATION
DATE_DIR=$(date +%Y-%m-%d)
LOG_DIR="logs/$DATE_DIR"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/openrouter-build-$(date +%H%M%S).md"

echo "Aggregating V.A.N.T.i.S. context..."

# Core rules and state
RULES_FILE="03_SYSTEM/Protocols/Universals/Rules/SHARED_RULES.md"
STATE_FILE="02_MACHINE/State/session-state_LATEST.md"
GEMINI_RULES="GEMINI.md"

# Build the system message
SYSTEM_PROMPT=$(cat <<EOF
You are the V.A.N.T.i.S. Build Agent. You are specialized in high-volume logic and scripting.
You must adhere to the Karpathy Protocol: Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution.

CORE CONTEXT:
$(cat "$RULES_FILE" 2>/dev/null || echo "No SHARED_RULES found")

CURRENT STATE:
$(cat "$STATE_FILE" 2>/dev/null || echo "No session state found")

OPERATING RULES:
$(cat "$GEMINI_RULES" 2>/dev/null || echo "No GEMINI rules found")

Your task is defined in the provided HANDOFF PLAN.
EOF
)

# Read the handoff plan
USER_PROMPT=$(cat "$PLAN_FILE")

# 3. CALL OPENROUTER API
echo "Calling OpenRouter ($MODEL)..."

# Construct JSON manually (using jq would be safer but curl + HEREDOC works for simple strings)
# To handle potential special characters in prompts, we should use a temporary JSON file or jq if available.
# Let's try to use jq if it exists, otherwise use a basic approach.

if command -v jq >/dev/null 2>&1; then
    PAYLOAD=$(jq -n \
        --arg model "$MODEL" \
        --arg sys "$SYSTEM_PROMPT" \
        --arg user "$USER_PROMPT" \
        '{model: $model, messages: [{role: "system", content: $sys}, {role: "user", content: $user}]}')
else
    # Fallback basic JSON (risky with quotes)
    PAYLOAD="{\"model\": \"$MODEL\", \"messages\": [{\"role\": \"system\", \"content\": \"$(echo "$SYSTEM_PROMPT" | sed 's/"/\\"/g' | tr -d '\n')\"}, {\"role\": \"user\", \"content\": \"$(echo "$USER_PROMPT" | sed 's/"/\\"/g' | tr -d '\n')\"}]}"
fi

# Execute Request
RESPONSE=$(curl -s https://openrouter.ai/api/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OR_KEY" \
  -d "$PAYLOAD")

# 4. OUTPUT & AUDIT
# Check for error in response
ERROR=$(echo "$RESPONSE" | grep -o '"error":{[^}]*}')
if [ -n "$ERROR" ]; then
    echo "API Error: $ERROR"
    exit 1
fi

CONTENT=$(echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin)['choices'][0]['message']['content'])")

echo "----------------------------------------------------------------"
echo "BUILD RESULTS:"
echo "----------------------------------------------------------------"
echo "$CONTENT"

# Write to log
{
    echo "# OpenRouter Build Log: $(date)"
    echo "- **Profile**: $PROFILE"
    echo "- **Model**: $MODEL"
    echo "- **Plan File**: $PLAN_FILE"
    echo ""
    echo "## Response"
    echo "$CONTENT"
} > "$LOG_FILE"

echo "----------------------------------------------------------------"
echo "Log saved to: $LOG_FILE"
