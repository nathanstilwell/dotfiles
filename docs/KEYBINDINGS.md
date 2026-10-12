# Keybinding Audit

Single reference for every keyboard shortcut currently configured across the terminal stack —
including the OS/tty-level reserved keys and Fish's own built-in bindings, not just what this repo
adds on top — so a new binding (e.g. `Ctrl+T`) can be checked against what already exists before
it's added.

Layers, in the order a keystroke actually passes through them:

**OS/TTY driver → Terminal emulator → Zellij or Herdr (multiplexer) → Fish/fzf (shell) or Neovim
(editor)**

Neovim is treated as a leaf, not a stacking layer: it never hosts a shell underneath it in this
workflow, so nothing below it in the stack risks being shadowed by an Nvim binding, and Nvim itself
just gets whatever bytes make it past the multiplexer — the same way Fish does. The multiplexer
layer (Zellij or Herdr, whichever currently owns the pane) is where permanent, always-on shadowing
actually happens, so that's the layer worth cross-referencing against Fish and the tty driver.

Whenever you add or change a binding, update this file in the same change.

## OS / TTY driver (line discipline — the true foundation layer)

These are the terminal's own reserved control characters, handled by the kernel's tty driver
before any application (Fish, Nvim, Zellij) sees the keystroke. Verified via `stty -a` on this
Mac:

| Key | tty function | Default meaning |
|---|---|---|
| `Ctrl+C` | `intr` | Send `SIGINT` to the foreground process group |
| `Ctrl+\` | `quit` | Send `SIGQUIT` (with core dump) to the foreground process |
| `Ctrl+Z` | `susp` | Send `SIGTSTP` — suspend the foreground process group |
| `Ctrl+D` | `eof` | Signal end-of-file on stdin (exits shell if the input line is empty) |
| `Ctrl+S` | `stop` | Suspend terminal output (XOFF) |
| `Ctrl+Q` | `start` | Resume terminal output (XON) |
| `Ctrl+U` | `kill` | Erase the entire input line |
| `Ctrl+W` | `werase` | Erase the previous word |
| `Ctrl+V` | `lnext` | Treat the next character literally |
| `Ctrl+O` | `discard` | Toggle discarding of output |
| `Ctrl+T` | `status` | Print a process status line |
| `Ctrl+Y` | `dsusp` | Delayed suspend (BSD/macOS only) |
| `Ctrl+R` | `reprint` | Redraw the current input line (BSD/macOS only) |
| `Backspace`/`Delete` | `erase` | Erase the previous character |

In practice you rarely see these meanings directly, because Fish, Nvim, and Zellij each put the
terminal into "raw" mode and take most of these characters over for their own line-editing/UI (see
the Fish table below, and the Gotchas section for how `Ctrl+C`/`Ctrl+Z` differ depending on what
currently owns the terminal). The raw tty meaning mainly resurfaces when a plain foreground child
process is blocking and none of the higher layers are intercepting — e.g. `Ctrl+C` to kill a stuck
`curl`, or `Ctrl+Z` to suspend a long `npm run build` back to Fish's job list.

## Terminal emulator (intercepts next, before Zellij/Fish/Nvim see the key)

| Key | Action | Source |
|---|---|---|
| `Cmd+Ctrl+F` | Toggle fullscreen | `wezterm/wezterm.lua.dotfile` |
| `Cmd+Ctrl+X` | Activate copy mode | `wezterm/wezterm.lua.dotfile` |
| `Cmd+Ctrl+U` | Character select | `wezterm/wezterm.lua.dotfile` |
| `Cmd+Ctrl+P` | Command palette | `wezterm/wezterm.lua.dotfile` |
| `Cmd+Shift+D` | Split vertical | `wezterm/wezterm.lua.dotfile` |
| `Cmd+D` | Split horizontal | `wezterm/wezterm.lua.dotfile` |
| `Cmd+[` / `Cmd+]` | Activate pane next/prev | `wezterm/wezterm.lua.dotfile` |
| `Alt+Enter` | Disabled (no-op override) | `wezterm/wezterm.lua.dotfile` |
| `Shift+Enter` | Insert literal newline | `ghostty/config` |

WezTerm and Ghostty are both configured; only one is the live terminal at a time. Ghostty
currently defines almost no custom bindings beyond the one above.

## Zellij (multiplexer — wraps Fish/Nvim panes)

All mode-switching lives behind one prefix, `Ctrl+Alt+D` — the same chord as Herdr's, since
they're alternatives that never wrap the same pane. This repurposes Zellij's built-in `tmux` mode
(a single-prefix, flat-keytable mode meant for exactly this) as the dispatch hub, instead of its
stock tmux-emulation bindings (`"`/`%` split, `Ctrl+b`-twice passthrough for a *nested* real tmux
session, etc.) — not needed here since nothing else multiplexes inside a Zellij pane. See Resolved.

**Heads up:** Zellij rewrites `config.kdl` in its own canonical form whenever its in-app
Configuration or Plugin-manager UI is used — it reformats shared binds into
`shared_among`/`shared_except` blocks, strips hand-written comments above the `keybinds` block, and
appends its full settings reference as comments. The keybinding *semantics* survive (confirmed via
diff against a Zellij-made `.bak` after this happened once), but if you hand-edit this file again
after using one of those UIs, diff first — your edits may be reformatted out from under you.

| Key | Action | Mode |
|---|---|---|
| `Ctrl+Alt+D` | Enter the hub | any (except locked) |
| `Esc` | Back to Normal mode | any (except normal/locked) |
| `Enter` | Back to Normal mode (no-op) | hub |
| `p` | Enter Pane mode | hub |
| `t` | Enter Tab mode | hub |
| `r` | Enter Resize mode | hub |
| `m` | Enter Move mode | hub |
| `o` | Enter Session mode | hub |
| `[` | Enter Scroll mode | hub |
| `Q` | Quit | hub |
| `h/l`, `Left/Right` | Prev/next tab, move tab | Tab mode |
| `n` | New tab | Tab mode |
| `1`–`9` | Go to tab N | Tab mode |
| `r` | Rename tab | Tab mode |
| `h/j/k/l` | Move focus | Pane mode |
| `n/d/r` | New pane / down / right | Pane mode |
| `x` | Close focused pane | Pane mode |
| `f` | Toggle fullscreen focus | Pane mode |
| `z` | Toggle pane frames | Pane mode |
| `w` | Toggle floating panes | Pane mode |
| `e` | Toggle embed/floating | Pane mode |
| `c` | Rename pane | Pane mode |
| `n/Tab` | Move pane (cycle placement) | Move mode |
| `p` | Move pane backwards | Move mode |
| `h/j/k/l`, arrows | Move pane in direction | Move mode |
| `h/j/k/l` (+ Shift) | Resize increase/decrease | Resize mode |
| `=`/`+` / `-` | Resize increase/decrease | Resize mode |
| `d` | Detach session | Session mode |
| `[` | Enter Scroll mode | Session mode |
| `w` | Launch session-manager plugin | Session mode |
| `j/k`, `Down/Up` | Scroll down/up | Scroll mode |
| `f/l`, `b/h` | Page scroll down/up | Scroll mode |
| `d/u` | Half-page scroll down/up | Scroll mode |
| `e` | Edit scrollback in `$EDITOR` | Scroll mode |
| `s` | Enter search | Scroll mode |
| `n/p` | Next/prev search match | Search mode |
| `c/w/o` | Toggle case/wrap/whole-word | Search mode |

`move` mode is new to this config — it wasn't bound to anything before, so nothing was lost, only
gained (moves a pane's *position* in the layout, distinct from Pane mode's `MoveFocus`, which just
changes which pane is focused).

## Herdr (multiplexer — alternative to Zellij, for shells + agent harnesses)

Config lives at `~/.config/herdr/config.toml`, outside this repo (like Nvim's config).

| Key | Action | Notes |
|---|---|---|
| `Alt+Ctrl+D` | Prefix (all other multiplexer commands are `prefix+<key>`) | `[keys]` / `prefix = "ctrl+alt+d"` |

Moved off Herdr's built-in default (`Ctrl+B`), which permanently shadowed Fish's `backward-char`
every time Herdr owned the pane — see the multiplexer-prefix section below the alphabetical index
for why `Alt+Ctrl+D` was picked.

## Fish shell + fzf.fish (Fish has focus, not "inside" Nvim)

All bound on `Alt+Ctrl+<letter>` rather than plain `Ctrl+<letter>`, specifically to stay out of
Fish's own default bindings (see Resolved). This matches `fzf_configure_bindings`'s own upstream
defaults, which already use `Alt+Ctrl+<letter>` for the same reason.

`fzf_configure_bindings` actually has **six** commands, not four — `git_status` and `variables`
are real, separate fzf pickers with their own plugin defaults (`Alt+Ctrl+S` and `Ctrl+V`
respectively). All six are now passed explicitly so none of them is silently running on an
unaccounted-for default (see Resolved):

| Key | Action | Source |
|---|---|---|
| `Alt+Ctrl+T` | fzf: search directory | `fzf/fzf.fish` |
| `Alt+Ctrl+G` | fzf: search git log | `fzf/fzf.fish` |
| `Alt+Ctrl+S` | fzf: search git status | `fzf/fzf.fish` |
| `Alt+Ctrl+R` | fzf: search history | `fzf/fzf.fish` |
| `Alt+Ctrl+P` | fzf: search processes | `fzf/fzf.fish` |
| `Alt+Ctrl+V` | fzf: search variables | `fzf/fzf.fish` |
| `Alt+Ctrl+A` | fzf: stage git files (git add) | `fzf/fzf.fish` |
| `Alt+Ctrl+B` | fzf: checkout git branch | `fzf/fzf.fish` |
| `Alt+Ctrl+N` | fzf: npm lifecycle scripts | `fzf/fzf.fish` |

`__fzf_vscode_open_files` (`vs-code/functions.fish`) is intentionally unbound — no longer needed
now that development happens in Nvim exclusively. The function itself is untouched and still
sourced, kept around for possible future reference; it's just not wired to a key anymore.

### Fish's own built-in bindings (not from this repo — shipped with Fish, always active)

Fish's emacs-mode defaults (confirmed against this machine's `fish_default_key_bindings.fish` /
`__fish_shared_key_bindings.fish`, Fish 4.7.1). None of these are shadowed by `fzf.fish` anymore —
moving fzf's bindings to `Alt+Ctrl+<letter>` freed the plain `Ctrl+<letter>` space back to Fish,
including `Ctrl+V` (paste), which `fzf.fish`'s `variables` search had also been silently sitting
on top of — see Resolved.

| Key | Action |
|---|---|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line |
| `Ctrl+K` | Kill to end of line |
| `Ctrl+U` | Kill to beginning of line (Fish's own take on the tty `kill` char) |
| `Ctrl+W` | Kill previous path component (Fish's own take on the tty `werase` char) |
| `Ctrl+Y` | Yank last kill |
| `Ctrl+L` | Clear screen |
| `Ctrl+X` | Copy commandline to system clipboard |
| `Ctrl+V` | Paste system clipboard into commandline |
| `Ctrl+D` | Delete char under cursor, or exit shell if the line is empty |
| `Ctrl+C` | Clear/cancel the current commandline (no signal — see Gotchas) |
| `Ctrl+Z` | Undo last line edit (not job-control suspend — see Gotchas) |
| `Alt+E` / `Alt+V` | Open the current commandline in `$EDITOR` (i.e. Nvim) |
| `Alt+B` / `Alt+F` | Move backward/forward one word |
| `Alt+.` | Recall last argument of the previous command |
| `Ctrl+T` | Transpose two characters |
| `Ctrl+B` | Backward char (move cursor left) |
| `Ctrl+P` / `Ctrl+N` | Previous/next history line |
| `Ctrl+R` | History pager |

## Neovim (editor focus, typically inside a Zellij pane)

`leader` = `Space`

| Key | Action | Source |
|---|---|---|
| `Esc` (normal) | Clear search highlight | `remap.lua` |
| `<leader>e` | Open netrw (`:Ex`) | `remap.lua` |
| `<leader>bn` / `<leader>bp` | Next/prev buffer | `remap.lua` |
| `<leader>w` | Close buffer | `remap.lua` |
| `<leader>c0` | Quickfix first | `remap.lua` |
| `<leader>co` / `<leader>cc` | Quickfix open/close | `remap.lua` |
| `<leader>cn` / `<leader>cp` / `<leader>cl` | Quickfix next/prev/last | `remap.lua` |
| `<leader>c[` | Clear quickfix | `remap.lua` |
| `J` / `K` (visual) | Move selected lines down/up | `remap.lua` |
| `J` (normal) | Join line, keep cursor | `remap.lua` |
| `Ctrl+D` / `Ctrl+U` (normal) | Scroll half-page, recenter | `remap.lua` |
| `n` / `N` | Next/prev search, recentered | `remap.lua` |
| `<leader>p` (visual) | Paste without clobbering register | `remap.lua` |
| `<leader>y` / `<leader>Y` | Yank to system clipboard | `remap.lua` |
| `cp` / `cP` | Copy relative/absolute file path | `remap.lua` |
| `Q` (normal) | Disabled | `remap.lua` |
| `<leader>ob/os/od/oc/ou` | Insert task-list glyphs | `remap.lua` |
| `<leader>d` | LSP: go to definition | `nvim-lspconfig.lua` |
| `<leader>ref` | LSP: references | `nvim-lspconfig.lua` |
| `<leader>fs` | LSP: signature help | `nvim-lspconfig.lua` |
| `<leader>r` | LSP: rename | `nvim-lspconfig.lua` |
| `<leader>eo` | LSP: open diagnostic float | `nvim-lspconfig.lua` |
| `<leader>ca` (n/v) | LSP: code action | `nvim-lspconfig.lua` |
| `<leader>cf` | Format file/range | `conform.lua` |
| `Ctrl+P` | Telescope: find files | `telescope.lua` |
| `<leader>tg` | Telescope: git files | `telescope.lua` |
| `<leader>tgs` | Telescope: git status | `telescope.lua` |
| `<leader>tgc` | Telescope: git commits | `telescope.lua` |
| `<leader>ts` | Telescope: grep string | `telescope.lua` |
| `<leader>tq` | Telescope: quickfix list | `telescope.lua` |
| `<leader><leader>` | Telescope: buffers | `telescope.lua` |
| `Ctrl+B` (Telescope buffer picker, insert mode) | Delete buffer | `telescope.lua` |
| `dd` (Telescope buffer picker, normal mode) | Delete buffer | `telescope.lua` |
| `<leader>ha` / `<leader>hr` | Harpoon add/remove | `harpoon.lua` |
| `<leader>h1`–`<leader>h4` | Harpoon go to slot 1–4 | `harpoon.lua` |
| `<leader>hp` / `<leader>hn` | Harpoon prev/next | `harpoon.lua` |
| `<leader>hh` | Harpoon list via Telescope | `harpoon.lua` |
| `Enter` / `Ctrl+Space` (insert, completion menu) | Confirm / trigger completion | `nvim-cmp.lua` |
| `Ctrl+U` / `Ctrl+D` (insert, completion menu) | Scroll docs up/down | `nvim-cmp.lua` |

## Legacy / inactive (present in repo, not part of the live workflow)

| Tool | Notes |
|---|---|
| `tmux/tmux.conf.dotfile` | Full config: `Ctrl+A` prefix, vi copy-mode binds, `Alt+H`/`Alt+L` window switching. No alias launches it — Zellij is the active multiplexer. `Ctrl+A` has the same shadowing problem Herdr's default `Ctrl+B` had (shadows Fish's beginning-of-line) — if this ever comes back into use, move it to `Alt+Ctrl+D` too, matching Herdr (see below the alphabetical index). |
| `screen/screenrc.dotfile` | No custom key rebinds. The `s` alias for it is explicitly commented `# deprecated` in `aliases/aliases.fish`. |

## Gotchas

1. **`Ctrl+C` and `Ctrl+Z` mean different things depending on who currently owns the terminal:**
   - At an idle Fish prompt: `Ctrl+C` clears the commandline and `Ctrl+Z` undoes the last edit —
     Fish's line editor intercepts both before they become signals.
   - While a plain foreground child process is running (e.g. `curl`, `npm run build`): the tty
     driver's real `intr`/`susp` behavior applies — `Ctrl+C` sends `SIGINT` (kills it), `Ctrl+Z`
     sends `SIGTSTP` (suspends it back to Fish's job list, resume with `fg`).
   - Inside Nvim or Zellij: both programs put the terminal in raw mode and read the raw bytes
     themselves instead of receiving a signal — `Ctrl+C` behaves like a soft interrupt/Esc, and
     Nvim's default `Ctrl+Z` still suspends Nvim itself (`:sus`) back to the shell, since this repo
     doesn't remap it. Zellij doesn't bind `Ctrl+C` at all in Normal mode, so it passes straight
     through to whatever's running in the focused pane.

### Resolved

- `<leader>cf` used to be double-bound in Neovim (`remap.lua`'s quickfix-first vs. `conform.lua`'s
  format-file). Quickfix-first was moved to `<leader>c0`; `<leader>cf` now unambiguously formats.
- The `Ctrl+S` comment in `fzf/fzf.fish` said "search git status" but the binding actually stages
  files (`__fzf_git_stage_files`); the comment now matches the binding.
- `fzf.fish` used to bind directly on plain `Ctrl+T`/`Ctrl+B`/`Ctrl+P`/`Ctrl+N`/`Ctrl+R`/`Ctrl+S`,
  shadowing Fish's own defaults for all six (transpose-chars, backward-char, history back/forward,
  history-pager, pager-toggle-search) and colliding with the tty's `Ctrl+S` XOFF flow control.
  Moved all eight fzf bindings — including `Ctrl+G`/`Ctrl+O`, which had no Fish default but moved
  too for consistency — onto `Alt+Ctrl+<same letter>`, matching `fzf_configure_bindings`'s own
  upstream defaults. Fish's built-ins are fully restored.
- `fzf_configure_bindings` has six commands, but `fzf/fzf.fish` only ever passed flags for four
  (`directory`/`git_log`/`history`/`processes`). The other two — `git_status` and `variables` —
  were never disabled, so they silently ran on the plugin's own defaults (`Alt+Ctrl+S` and
  `Ctrl+V`) the whole time, undocumented and unaudited. Worse, the first pass at the `Ctrl+T`/etc.
  fix above put the manual git-stage binding directly on `Alt+Ctrl+S`, clobbering the pre-existing
  git-status search. Fixed by passing all six flags explicitly: `git_status` stays at its own
  `Alt+Ctrl+S` default, `variables` moves to `Alt+Ctrl+V` (freeing plain `Ctrl+V` back to Fish's
  paste), and git-stage moved to `Alt+Ctrl+A` (git *a*dd).
- `Alt+Ctrl+O` (open files in VS Code) was removed — no longer needed with Nvim as the exclusive
  editor. `__fzf_vscode_open_files` (`vs-code/functions.fish`) is left in place and still sourced,
  just unbound, in case it's wanted again later.
- Zellij's `Alt+C`/`Alt+O`/`Alt+P`/`Alt+T` mode-switches permanently shadowed Fish's
  capitalize-word, preview-file, paginate, and transpose-words. Rather than relocate each one to a
  separate letter, all of Zellij's mode-switching (plus the `Alt+X` quit and `Alt+R` resize entries,
  which weren't conflicts but were folded in for consistency) was consolidated behind one prefix,
  `Ctrl+Alt+D`, matching Herdr's. This repurposes Zellij's built-in `tmux` mode — a single-prefix,
  flat-keytable mode meant for exactly this — as a plain dispatch hub instead of its stock
  tmux-emulation bindings (nested-multiplexer passthrough isn't needed here). All four shadowed
  Fish bindings are now fully reachable again, and the bare `Alt+<letter>` tier belongs to Fish
  alone. Session mode's internal `Alt+S` → Scroll shortcut was also changed to `[` (matching the
  hub's own Scroll-entry key and real tmux's copy-mode convention), resolving its narrow shadow of
  Fish's `sudo`-prepend too. Validated with `zellij setup --check` before and after.
- Added Zellij's `move` mode (pane-repositioning, distinct from Pane mode's focus-switching),
  entirely new — nothing previously bound it — reachable via the `Ctrl+Alt+D` hub's `m` key.

## Alphabetical index (by chord)

Everything above, flattened into one A–Z pass per modifier chord so a gap (nothing bound) or a
collision (more than one non-`—` cell in a row) is visible at a glance. `—` means nothing claims
that combo in this repo/machine. Leader sequences (`<leader>x…`) and bare letters (`dd`, `n`, `j`)
are left out — this is only single-keystroke chords.

### `Ctrl+<letter>`

`fzf.fish` no longer appears in this table — it moved to `Alt+Ctrl+<letter>` (see below) precisely
to get out of this space. Neovim isn't a column here either: it's a leaf, not a permanent stacking
layer (see the note at the top of this file), so it doesn't shadow anything and nothing shadows it
the way the multiplexer layer does. The multiplexer column covers whichever of Zellij/Herdr
currently owns the pane — they're alternatives, never simultaneous.

| Key | tty driver | Fish (built-in) | Zellij / Herdr |
|---|---|---|---|
| `Ctrl+A` | — | Beginning of line | — |
| `Ctrl+B` | — | Backward char | — |
| `Ctrl+C` | `intr`→SIGINT | Clear/cancel commandline | Zellij: only in EnterSearch mode → Scroll |
| `Ctrl+D` | `eof` | Delete char / exit if empty | — |
| `Ctrl+E` | — | End of line | — |
| `Ctrl+F` | — | Forward char | — |
| `Ctrl+G` | — | — | — |
| `Ctrl+H` | ≈`erase` (Backspace byte) | — | — |
| `Ctrl+I` | — | ≈Tab: complete | — |
| `Ctrl+K` | — | Kill to end of line | — |
| `Ctrl+L` | — | Clear screen | — |
| `Ctrl+N` | — | Down line (history) | — |
| `Ctrl+O` | `discard` | — | — |
| `Ctrl+P` | — | Up line (history) | — |
| `Ctrl+Q` | `start`→XON | — | — |
| `Ctrl+R` | `reprint` (BSD) | History pager | — |
| `Ctrl+S` | `stop`→XOFF | Pager-toggle-search | — |
| `Ctrl+T` | `status` | Transpose chars | — |
| `Ctrl+U` | `kill` (erase line) | Kill to beginning of line | — |
| `Ctrl+V` | `lnext` | Paste system clipboard | — |
| `Ctrl+W` | `werase` | Kill previous path component | — |
| `Ctrl+X` | — | Copy commandline to clipboard | — |
| `Ctrl+Y` | `dsusp` (BSD) | Yank last kill | — |
| `Ctrl+Z` | `susp`→SIGTSTP | Undo last edit | — |
| `Ctrl+\` | `quit`→SIGQUIT | — | — |

**Free:** `Ctrl+G` and `Ctrl+H` are the only bare `Ctrl+<letter>` combos nothing in this stack
claims (`Ctrl+H` still overlaps conceptually with the Backspace/`erase` byte). Every other letter
is spoken for by the tty driver or a Fish default — `Ctrl+` is inherently tight real estate, which
is why `fzf.fish`, Herdr's prefix, and Zellij's mode-switching were all moved off it entirely
rather than picked around.

### `Alt+Ctrl+<letter>`

Deliberately kept near-empty — this is where `fzf.fish` and the shared multiplexer prefix live,
and it's the safest chord family in the whole stack (the tty driver has no reserved meanings here,
and WezTerm's `Cmd+Ctrl+` combos are a different modifier entirely).

| Key | Fish (built-in) | fzf.fish | Multiplexer |
|---|---|---|---|
| `Alt+Ctrl+A` | — | Stage git files (git add) | — |
| `Alt+Ctrl+B` | — | Checkout git branch | — |
| `Alt+Ctrl+D` | — | — | Zellij hub entry + Herdr prefix (`config.toml`); tmux, if revived, should match |
| `Alt+Ctrl+G` | — | Search git log | — |
| `Alt+Ctrl+H` | Backward-kill-word (`ctrl-alt-h`, per-OS preset) | — | — |
| `Alt+Ctrl+N` | — | npm lifecycle scripts | — |
| `Alt+Ctrl+P` | — | Search processes | — |
| `Alt+Ctrl+R` | — | Search history | — |
| `Alt+Ctrl+S` | — | Search git status | — |
| `Alt+Ctrl+T` | — | Search directory | — |
| `Alt+Ctrl+V` | — | Search variables | — |

**Free:** `C, E, F, I, J, K, L, M, O, Q, U, W, X, Y, Z`. `O` (open in VS Code) was freed up when
that binding was removed — the function (`__fzf_vscode_open_files`) still exists unbound, kept for
possible future use. If you ever need a new fzf-style global shortcut, this is the family to reach
for.

### `Alt+<letter>`

Zellij no longer appears in this table — its mode-switching moved entirely behind `Ctrl+Alt+D` (see
Resolved), so the bare `Alt+<letter>` tier is now Fish's alone.

| Key | Fish (built-in) | Notes |
|---|---|---|
| `Alt+B` | Backward word (`prevd-or-backward-word`) | |
| `Alt+C` | Capitalize word | |
| `Alt+D` | Kill word / dirhistory | |
| `Alt+E` | Open commandline in `$EDITOR` | |
| `Alt+F` | Forward word (`nextd-or-forward-word`) | |
| `Alt+H` | Open man page for current command | (tmux legacy: previous window — inactive) |
| `Alt+L` | List current token | (tmux legacy: next window — inactive) |
| `Alt+O` | Preview current file | |
| `Alt+P` | Paginate current command's output | |
| `Alt+S` | Prepend `sudo`/`doas`/etc. | |
| `Alt+T` | Transpose words | |
| `Alt+U` | Upcase word | |
| `Alt+V` | Open commandline in `$EDITOR` (same as `Alt+E`) | |
| `Alt+W` | Explain current token (`whatis`) | |
| `Alt+Y` | Yank-pop | |
| `Alt+.` | Recall last argument | |
| `Alt+#` | Toggle comment on commandline | |
| `Alt+Enter` | Expand abbreviation / insert line (default) | WezTerm disables its own default action for this combo so it reaches Fish |

**Free:** `Alt+A`, `Alt+G`, `Alt+I`, `Alt+J`, `Alt+K`, `Alt+M`, `Alt+N`, `Alt+Q`, `Alt+R`, `Alt+X`,
`Alt+Z` — nothing claims these. `Alt+R` and `Alt+X` are newly free: Zellij used to hold them for
Resize and Quit, now both live in the `Ctrl+Alt+D` hub instead.

### `Cmd+…` combos (WezTerm only — macOS/system Cmd shortcuts outside this repo aren't tracked here)

| Key | Action |
|---|---|
| `Cmd+D` | Split horizontal |
| `Cmd+[` / `Cmd+]` | Activate pane prev/next |
| `Cmd+Shift+D` | Split vertical |
| `Cmd+Ctrl+F` | Toggle fullscreen |
| `Cmd+Ctrl+P` | Command palette |
| `Cmd+Ctrl+U` | Character select |
| `Cmd+Ctrl+X` | Activate copy mode |

**Free (within this repo's WezTerm config):** every other `Cmd+<letter>`, `Cmd+Shift+<letter>`,
and `Cmd+Ctrl+<letter>` combo is unclaimed by `wezterm.lua.dotfile`. Treat "free" loosely here,
though — macOS and other apps own plenty of `Cmd+`/`Cmd+Shift+` shortcuts (copy, paste, new tab,
quit, …) that this file doesn't track since they're OS/app conventions, not something configured
in dotfiles.

*Not included above: arrow-key and bracket/backslash combos already covered inline elsewhere
(`Ctrl+Left/Right`, `Alt+Up/Down/Left/Right`, `Ctrl+\`, `Cmd+[`/`Cmd+]`) — listed here only where
they don't fit the A–Z scan.*

## Decision: shared multiplexer-prefix chord — `Ctrl+Alt+D`

Herdr's default `Ctrl+B`, tmux's configured `Ctrl+A`, and (originally) Zellij's scattered
`Alt+C`/`O`/`P`/`T` mode-switches all permanently shadowed a Fish default — worse than a normal
shadow, since these keys get pressed on every single multiplexer command, not occasionally.

Standardized on **`Ctrl+Alt+D`** across all three multiplexers, since they're alternatives you'd
never run in the same pane at once — one shared prefix means one muscle-memory habit regardless of
which one is active. `Ctrl+Alt+<letter>` was chosen as the family because it's the one proven
collision-free tier in this stack (nothing in the tty driver or WezTerm/Ghostty claims it, and only
`Ctrl+Alt+H` is claimed in Fish) — the same reason `fzf.fish` lives there too. A prefix key is
followed by a separate unmodified keystroke (`prefix` then `p`, `c`, `%`, etc.), so sharing the
first chord with fzf.fish's one-shot `Ctrl+Alt+<letter>` bindings doesn't create any new collision.

- **Herdr:** done — `~/.config/herdr/config.toml`'s `[keys]` table now has `prefix = "ctrl+alt+d"`,
  applied live via `herdr server reload-config` (confirmed via `herdr.dev/docs/configuration/`).
- **Zellij:** done — `Ctrl+Alt+D` enters Zellij's built-in `tmux` mode (repurposed as a generic
  dispatch hub, not its stock tmux-emulation bindings), from which single unmodified letters pick
  Pane/Tab/Resize/Move/Session/Scroll. See the Zellij section above and Resolved below.
- **tmux:** not yet touched, since it's inactive — if it ever comes back into use, set
  `set-option -g prefix M-C-d` plus `bind M-C-d send-prefix` in `tmux/tmux.conf.dotfile` to match.
