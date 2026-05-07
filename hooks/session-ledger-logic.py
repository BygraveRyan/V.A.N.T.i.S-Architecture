import glob
import json
import os
import re
import sys

# V.A.N.T.i.S. Session Ledger Logic (Python)
# This script is called by session-ledger.sh to parse tool usage and update the ledger.

def detect_agent(payload):
    env = os.environ
    
    # 1. Explicit Session Markers (highest precision)
    session_markers = {
        "Gemini": env.get("GEMINI_SESSION_ID") or env.get("GEMINI_CLI") or env.get("GEMINI_CLI_NO_RELAUNCH"),
        "Claude": env.get("CLAUDE_SESSION_ID") or env.get("CLAUDE_CODE"),
        "Codex": env.get("CODEX_SESSION_ID"),
    }
    for name, value in session_markers.items():
        if value:
            return name

    # 2. Payload Inference (transcript paths)
    transcript = str(payload.get("transcript_path", ""))
    if ".gemini" in transcript:
        return "Gemini"
    if ".claude" in transcript:
        return "Claude"

    # 3. Model Name Inference (fallback)
    model = str(
        payload.get("model")
        or env.get("CODEX_MODEL")
        or env.get("CLAUDE_MODEL")
        or env.get("GEMINI_MODEL")
        or ""
    ).lower()
    
    if "claude" in model:
        return "Claude"
    if "gemini" in model:
        return "Gemini"
    if any(m in model for m in ["gpt", "codex", "o1", "o3"]):
        return "Codex"
        
    return "Unknown Agent"


def add_candidate(container, value):
    if not isinstance(value, str) or not value:
        return
        
    # Expand globs if present
    if any(c in value for c in "*?[]"):
        try:
            expanded = glob.glob(value, recursive=True)
            if expanded:
                for path in expanded:
                    container.add(path)
            else:
                # If glob doesn't match existing files (e.g. creating new ones),
                # keep the raw path as a candidate
                container.add(value)
        except Exception:
            container.add(value)
    else:
        container.add(value)


def process_candidates(container, value):
    if isinstance(value, str):
        add_candidate(container, value)
    elif isinstance(value, list):
        for item in value:
            process_candidates(container, item)
    elif isinstance(value, dict):
        # Scan common keys for file paths
        for key in ("file_path", "path", "target_file", "new_file", "old_file", "file", "files", "paths", "filePaths"):
            if key in value:
                process_candidates(container, value[key])


def main():
    if len(sys.argv) < 3:
        return
        
    timestamp = sys.argv[1]
    ledger_path = sys.argv[2]
    
    try:
        raw = sys.stdin.read().strip()
        if not raw:
            return
        data = json.loads(raw)
    except Exception:
        return

    tool_name = (
        data.get("tool_name")
        or data.get("tool")
        or data.get("name")
        or "unknown"
    )
    tool_input = data.get("tool_input") or data.get("input") or {}

    paths = set()

    # 1. Extract from standard tool input keys
    process_candidates(paths, tool_input)

    # 2. Heuristic extraction from shell commands
    command = ""
    if isinstance(tool_input, dict):
        command = str(tool_input.get("command") or "")

    if command:
        # Explicit V.A.N.T.i.S. mutation marker: # [FILE] path
        for match in re.findall(r"#\s*\[FILE\]\s*([^\s;&|<>#]+)", command):
            add_candidate(paths, match.strip())
            
        # Redirections: > file, >> file
        for match in re.findall(r"(?:>|>>)\s*([^\s;&|<>#]+)", command):
            add_candidate(paths, match.strip())
            
        # Common mutation tools (heuristic - looks for the last argument before a separator or EOL)
        # Matches tools like rm, mv, cp, sed -i, and custom ASV hook
        # Note: We look for the last token in the command segments
        for part in re.split(r"[;&|<>]+", command):
            # Strip comments (text after #)
            part = part.split('#')[0].strip()
            if any(tool in part for tool in ["rm", "mv", "cp", "sed -i", "version-incrementer.js"]):
                # Take the last whitespace-delimited token
                tokens = part.split()
                if tokens:
                    add_candidate(paths, tokens[-1])

    # 3. Extract from patch/content fields
    patch_blob = ""
    if isinstance(tool_input, dict):
        patch_blob = str(tool_input.get("patch") or tool_input.get("content") or "")
    elif isinstance(tool_input, str):
        patch_blob = tool_input

    for pattern in (
        r"^\*\*\* Update File: (.+)$",
        r"^\*\*\* Add File: (.+)$",
        r"^\*\*\* Delete File: (.+)$",
        r"^--- a/(.+)$",
        r"^\+\+\+ b/(.+)$",
    ):
        for match in re.findall(pattern, patch_blob, flags=re.MULTILINE):
            paths.add(match.strip())

    clean_paths = []
    for path in sorted(paths):
        normalized = str(path).strip()
        if not normalized or normalized == "/dev/null":
            continue
        # Strip common shell quoting characters
        normalized = normalized.strip("\"").strip("'")
        clean_paths.append(normalized)

    if not clean_paths:
        return

    agent = detect_agent(data)
    with open(ledger_path, "a", encoding="utf-8") as handle:
        for file_path in clean_paths:
            row = {
                "timestamp": timestamp,
                "agent": agent,
                "tool": tool_name,
                "file": file_path,
            }
            handle.write(json.dumps(row) + "\n")

if __name__ == "__main__":
    main()
