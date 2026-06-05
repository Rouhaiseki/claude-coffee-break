---
name: coffee-break
description: Play relaxing mini-games while Claude Code works on long tasks. A 10-game arcade (a 14-level Sokoban campaign, a raise-'em-up Claude pet, Flappy Bird, Timberman, 2048, memory, sliding puzzle, brain-teaser riddles, guess-the-number, reaction test) with an achievement system, in English / 中文 / 日本語. It auto-opens during long runs and closes itself when the AI finishes. Use when the user wants to take a break, play a game while waiting for a long task, or asks to open/install the Coffee Break arcade.
---

# Coffee Break

A tiny offline arcade to play while Claude Code grinds through a long task. One
self-contained HTML file, no dependencies, no network. It can run fully
automatically (opens on long tasks, closes itself when the AI is done) or be
opened on demand.

## Open the arcade right now

Run the launcher in "now" mode (skips the wait and opens immediately):

```bash
bash "$CLAUDE_SKILL_DIR/launch.sh" now    # or use the folder where this skill lives
```

This opens a clean Chrome app-window arcade. The user plays while you keep
working. When you finish the task, signal completion so the window closes
itself:

```bash
bash "$CLAUDE_SKILL_DIR/done.sh"
```

## Enable full-auto (recommended)

Wire it into Claude Code's hooks once, and it works on every future task with no
prompting — the arcade pops up for tasks longer than ~10s and vanishes when you
stop:

```bash
bash "$CLAUDE_SKILL_DIR/install.sh"
```

Then the user restarts Claude Code (or approves the new hooks via `/hooks`).

## How it works

- `launch.sh` (UserPromptSubmit hook) — marks the task running, serves the game
  locally, waits ~10s, and only opens the window if the task is still going.
- `done.sh` (Stop hook) — marks the task done; the page polls this and
  auto-closes the window after a short countdown.

## Notes

- Requires `python3` (built-in on macOS) and, for the self-closing window,
  Google Chrome / Chromium. Falls back to the default browser otherwise.
- Change the "long task" threshold via `COFFEE_DELAY` in `launch.sh`.
- Progress and achievements are stored in the browser's localStorage.
