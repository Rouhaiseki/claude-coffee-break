#!/bin/bash
# Coffee Break — uninstaller. Removes only the hooks that point at this folder.
set -e
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETTINGS="${CLAUDE_SETTINGS:-$HOME/.claude/settings.json}"
[ -f "$SETTINGS" ] || { echo "No settings.json found, nothing to do."; exit 0; }

python3 - "$SETTINGS" "$DIR" <<'PY'
import json, sys
path, d = sys.argv[1], sys.argv[2]
with open(path) as f: cfg = json.load(f)
hooks = cfg.get("hooks", {})
for event in list(hooks.keys()):
    groups = []
    for grp in hooks[event]:
        kept = [h for h in grp.get("hooks", []) if d not in h.get("command", "")]
        if kept:
            grp["hooks"] = kept
            groups.append(grp)
    if groups:
        hooks[event] = groups
    else:
        del hooks[event]
if not hooks:
    cfg.pop("hooks", None)
with open(path, "w") as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
PY

echo "Coffee Break hooks removed. Restart Claude Code to apply."
