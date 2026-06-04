#!/bin/bash
# Coffee Break — installer.
# Wires the launcher/finisher into Claude Code's global hooks so the arcade
# opens automatically on long tasks and closes itself when Claude finishes.
# Safe to re-run: it merges into your existing settings.json and never duplicates.
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
chmod +x "$DIR/launch.sh" "$DIR/done.sh"

SETTINGS="${CLAUDE_SETTINGS:-$HOME/.claude/settings.json}"
mkdir -p "$(dirname "$SETTINGS")"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"
cp "$SETTINGS" "$SETTINGS.coffeebreak.bak"

python3 - "$SETTINGS" "$DIR" <<'PY'
import json, sys
path, d = sys.argv[1], sys.argv[2]
with open(path) as f: cfg = json.load(f)
hooks = cfg.setdefault("hooks", {})
launch = f'nohup "{d}/launch.sh" >/dev/null 2>&1 &'
done   = f'"{d}/done.sh"'
def ensure(event, cmd):
    arr = hooks.setdefault(event, [])
    for grp in arr:
        for h in grp.get("hooks", []):
            if h.get("command") == cmd:
                return
    arr.append({"hooks": [{"type": "command", "command": cmd}]})
ensure("UserPromptSubmit", launch)
ensure("Stop", done)
with open(path, "w") as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
PY

echo ""
echo "  Coffee Break installed."
echo "  Backup saved to: $SETTINGS.coffeebreak.bak"
echo ""
echo "  -> Restart Claude Code (or review with /hooks) to activate."
echo "  -> Long tasks (>${COFFEE_DELAY:-10}s) will pop the arcade; it closes when the AI is done."
echo "  -> Change the threshold:  edit COFFEE_DELAY in launch.sh"
echo "  -> Remove everything:     ./uninstall.sh"
echo ""
