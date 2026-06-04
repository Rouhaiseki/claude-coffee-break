#!/bin/bash
# Coffee Break — launcher.
# Wired to Claude Code's UserPromptSubmit hook. Marks the task "working",
# makes sure a tiny local server is up, waits a bit, and only pops the
# game window if the task is still running (short tasks are never disturbed).
#
# Env overrides:  COFFEE_PORT (default 8765)   COFFEE_DELAY seconds (default 10)
# Pass "now" as $1 to open immediately (used by the /coffee-break skill).

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT="${COFFEE_PORT:-8765}"
DELAY="${COFFEE_DELAY:-10}"
[ "$1" = "now" ] && DELAY=0

echo "working" > "$DIR/STATUS"

# Start the static server once; reuse it afterwards.
if ! curl -s -o /dev/null "http://localhost:$PORT/" 2>/dev/null; then
  (cd "$DIR" && nohup python3 -m http.server "$PORT" >/dev/null 2>&1 &)
fi

# Only interrupt for tasks that actually take a while.
sleep "$DELAY"
[ "$(cat "$DIR/STATUS" 2>/dev/null)" != "working" ] && exit 0

URL="http://localhost:$PORT/index.html"
if [ "$(uname)" = "Darwin" ] && [ -d "/Applications/Google Chrome.app" ]; then
  # App-mode window: no tabs/URL bar, and it can close itself when done.
  open -na "Google Chrome" --args --app="$URL" --new-window
elif command -v google-chrome >/dev/null 2>&1; then
  google-chrome --app="$URL" --new-window >/dev/null 2>&1 &
elif command -v chromium >/dev/null 2>&1; then
  chromium --app="$URL" --new-window >/dev/null 2>&1 &
elif [ "$(uname)" = "Darwin" ]; then
  open "$URL"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$URL"
fi
