#!/bin/bash
# Coffee Break — finisher.
# Wired to Claude Code's Stop hook. Writes "done"; the open game window
# polls this file and closes itself a few seconds later.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "done" > "$DIR/STATUS"
