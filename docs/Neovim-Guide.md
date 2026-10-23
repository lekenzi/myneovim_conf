# Neovim + AstroNvim: Learning Guide

A practical path from zero to fast, built for **your** setup (AstroNvim v6 on Neovim 0.12, with Go, Rust, C/C++, Python, JS/TS/React, Vue, Java, Bash and Terraform/HCL).
Every keybinding here was checked against your installed config.

> **Open this file in Neovim and practise on it:** `nvim ~/Desktop/Neovim-Guide.md`
> Nothing you do here can break anything. If you get lost, press `Esc` a few times, then type `:q!` and `Enter` to quit without saving.

---

## 0. How to learn this efficiently

Most people fail at Vim by trying to memorise everything at once. Don't. Do this instead:

1. **Day 1:** Run `nvim +Tutor` (the built-in 30-minute interactive tutorial). Do it all. This is the highest-value 30 minutes you will spend.
2. **Days 2–7:** Use Neovim for real work, but only learn **Level 1** and **Level 2** below. Accept being slow.
3. **Week 2:** Add **Level 3** (the AstroNvim layer: files, search, buffers).
4. **Week 3:** Add **Level 4** (coding: LSP, diagnostics, debugging).
5. **After that:** Pick **one** new trick from Level 5 each day, use it on purpose until it's automatic, then pick the next.

**Rules that make it stick:**
- **Whenever you do something slowly or repeatedly, stop and look it up.** That is the trigger to learn the next thing.
- **Press `Space` and wait.** A menu (which-key) shows every command you can run next. You never need to remember the whole map, only the first letter.
- **`Space fk` searches all keybindings by description.** Type "rename", "comment", "split", etc.
- Avoid the arrow keys and the mouse. They work, but they stop you building the habits.

---

## 1. The mental model (read this once, carefully)

### Modes
Neovim has modes. The key you press means different things in each.

| Mode | What it's for | How to enter | How to leave |
|---|---|---|---|
| **Normal** | Moving and running commands (you live here) | `Esc` (or `jk` / `jj`, see below) | - |
| **Insert** | Typing text | `i`, `a`, `o`, … | `Esc` or `jk` |
| **Visual** | Selecting text | `v` (chars), `V` (lines), `Ctrl-v` (block) | `Esc` |
| **Command** | `:` commands like save/quit | `:` | `Enter` / `Esc` |

**Your setup has `jk` and `jj` mapped to Escape in Insert mode.** Type `j` then `k` quickly to get back to Normal mode without reaching for Esc.

### The grammar: this is why Vim is fast
Commands are sentences: **verb + (count) + noun**.

```
d    w        → delete a word
c    i "      → change inside quotes
y    2 j      → yank (copy) this line and 2 below
d    i f      → delete inside function   (works in your setup via treesitter)
```

Learn ~5 verbs and ~10 nouns and you get 50 commands for free. That multiplication is the whole trick.

---

## 2. Level 1: Survive (Day 1–3)

### Save / quit
| Keys | Action |
|---|---|
| `Space w` | Save |
| `Space q` | Quit window |
| `Space Q` | Quit Neovim |
| `:wq` / `:q!` | Save & quit / quit and discard changes |
| `Ctrl-s` | Force save |

### Enter Insert mode
| Keys | Where the cursor goes |
|---|---|
| `i` / `a` | Before / after cursor |
| `I` / `A` | Start / end of line |
| `o` / `O` | New line below / above |

### Basic movement (Normal mode)
| Keys | Move |
|---|---|
| `h j k l` | ← ↓ ↑ → |
| `w` / `b` | Next word / back a word |
| `e` | End of word |
| `0` / `^` / `$` | Line start / first non-blank / line end |
| `gg` / `G` | Top / bottom of file |
| `Ctrl-d` / `Ctrl-u` | Half page down / up |
| `42G` or `:42` | Go to line 42 |

### Basic editing
| Keys | Action |
|---|---|
| `x` | Delete character |
| `dd` | Delete (cut) line |
| `yy` | Yank (copy) line |
| `p` / `P` | Paste after / before |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `.` | **Repeat last change** (incredibly useful) |

**Practice:** On this file, delete 3 lines with `3dd`, undo with `u`, then copy a line with `yy` and paste it 5 times with `5p`.

---

## 3. Level 2: Speak Vim (Day 3–7)

### Verbs (operators)
| Verb | Meaning |
|---|---|
| `d` | Delete |
| `c` | Change (delete + enter Insert) |
| `y` | Yank (copy) |
| `>` / `<` | Indent / un-indent |
| `gc` | Toggle comment |

Doubling a verb acts on the whole line: `dd`, `cc`, `yy`, `>>`, `gcc`.

### Nouns: motions
`w`, `b`, `e`, `$`, `0`, `gg`, `G`, `}` (next paragraph/block), `{`, and:

| Motion | Meaning |
|---|---|
| `f x` / `F x` | Jump **to** next/previous character `x` on the line |
| `t x` / `T x` | Jump to just **before** `x` |
| `;` / `,` | Repeat last `f`/`t` forward / back |
| `%` | Jump to matching bracket |

Example: `dt)` deletes everything up to the next `)`. `cf,` changes up to and including the next comma.

### Nouns: text objects (the real power)
Use with `i` (inside) or `a` (around, which includes the surroundings):

| Object | Meaning | Example |
|---|---|---|
| `w` | word | `ciw`: change the word under the cursor |
| `"` `'` `` ` `` | quotes | `ci"`: rewrite a string |
| `(` `[` `{` `<` | brackets | `di(`: clear function arguments |
| `t` | HTML/JSX tag | `cit`: change a tag's content |
| `p` | paragraph | `yap`: copy a paragraph |
| **`f`** | **function** (treesitter) | `daf`: delete a whole function |
| **`c`** | **class** | `vac`: select a class |
| **`a`** | **argument** | `cia`: change one argument |
| **`k`** | **block** | `yik`: copy a block body |
| **`o`** | **loop** | `dao`: delete a loop |
| **`?`** | **conditional** | `ci?`: change an if-body |

The **bold** ones come from your treesitter setup and understand real code structure in all your languages.

### Search
| Keys | Action |
|---|---|
| `/text` then `Enter` | Search forward |
| `n` / `N` | Next / previous match |
| `*` | Search the word under the cursor |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all, confirming each |

### Visual mode
`v` then move to select, then apply a verb: `d`, `y`, `c`, `>`, `gc`. In visual mode `Tab` / `Shift-Tab` indent and un-indent.
`Ctrl-v` gives **block selection**: select a column, press `I`, type text, `Esc`, and it's inserted on every line.

---

## 4. Level 3: The AstroNvim layer (Week 2)

`Space` is your **leader** key. Press it and **wait** to see the menu. The groups:

| Prefix | Group |
|---|---|
| `Space f` | **Find** (files, text, everything) |
| `Space b` | Buffers (open files) |
| `Space l` | LSP / language tools |
| `Space d` | Debugger |
| `Space g` | Git |
| `Space t` | Terminals |
| `Space u` | UI toggles |
| `Space S` | Sessions |
| `Space p` | Plugins / Mason |
| `Space x` | Quickfix / location lists |

### Finding things (use these constantly)
| Keys | Action |
|---|---|
| `Space ff` | **Find files** by name (fuzzy) |
| `Space fw` | **Find words**: live grep across the project |
| `Space fc` | Find the word under the cursor across the project |
| `Space fb` | Find open buffers |
| `Space fo` | Recently opened files |
| `Space fs` | Buffers + recent + files combined |
| `Space f Enter` | Resume your last search |
| `Space fk` | Find keymaps (forgot a binding? search here) |
| `Space fh` | Search help docs |
| `Space fT` | Find TODO/FIXME comments |
| `Space fu` | Undo history (browse old versions!) |
| `Space fp` | Switch between projects |
| `Space ft` | Try colour themes |

Inside a picker: type to filter, `Ctrl-j` / `Ctrl-k` to move, `Enter` to open, `Esc` to close.

### File explorer (Neo-tree)
| Keys | Action |
|---|---|
| `Space e` | Toggle explorer |
| `Space o` | Jump focus between explorer and code |

Inside the explorer: `a` add file (end with `/` for a folder), `d` delete, `r` rename, `m` move, `c` copy, `H` toggle hidden files, `?` **show all explorer keys**.

**Tip:** once you're comfortable, prefer `Space ff` over the tree. It's much faster.

### Buffers (open files) and tabs along the top
| Keys | Action |
|---|---|
| `]b` / `[b` | Next / previous buffer |
| `Space bb` | Pick a buffer by letter |
| `Space c` | Close current buffer |
| `Space bc` | Close all except current |
| `>b` / `<b` | Move buffer tab right / left |

### Windows (splits)
| Keys | Action |
|---|---|
| Pipe key (`Shift` + `\`) | Vertical split |
| `\` | Horizontal split |
| `Ctrl-h/j/k/l` | Move between splits |
| `Ctrl-arrows` | Resize splits |
| `Space q` | Close split |

### Terminal
| Keys | Action |
|---|---|
| `Ctrl-'` or `F7` | Toggle floating terminal |
| `Space th` / `Space tv` | Terminal in horizontal / vertical split |
| `Space tp` / `Space tn` | Python / Node REPL |
| `Space tt` | System monitor (btm) |
| `Space tu` | Disk usage (gdu) |

Inside a terminal, `Ctrl-h/j/k/l` moves to other windows. To scroll the terminal, press `Ctrl-\` then `Ctrl-n` (Normal mode), then move as usual.

### Sessions (reopen your workspace)
| Keys | Action |
|---|---|
| `Space Sl` | Load last session |
| `Space S.` | Load session for current directory |
| `Space Ss` | Save session |

Your session is auto-saved on exit, so `Space Sl` after starting `nvim` restores everything.

---

## 5. Level 4: Coding (Week 3)

These work the same in **every language** you have set up.

### Navigate code
| Keys | Action |
|---|---|
| `gd` | **Go to definition** |
| `gy` | Go to type definition |
| `gI` | Go to implementation |
| `grr` or `Space lR` | **Find all references** |
| `K` | **Hover docs** for the thing under the cursor (press twice to enter the popup) |
| `gK` / `Space lh` | Signature help (function arguments) |
| `Ctrl-o` / `Ctrl-i` | **Jump back / forward** (after `gd`, this returns you) |
| `Space ls` | Search symbols in this file |
| `Space lG` | Search symbols in the whole project |
| `Space lS` | Symbols outline sidebar |
| `]f` / `[f` | Next / previous function |
| `]k` / `[k` | Next / previous block |
| `]r` / `[r` | Next / previous reference to the symbol under the cursor |

### Change code
| Keys | Action |
|---|---|
| `Space lr` | **Rename** symbol (everywhere, safely) |
| `Space la` | **Code actions** (quick fixes, imports, refactors) |
| `Space lf` | Format file (also happens automatically on save) |
| `Space /` | Toggle comment (line or selection) |
| `>a` / `<a` | Swap argument with the next / previous one |
| `>f` / `<f` | Swap function with the next / previous one |

### Errors and warnings (diagnostics)
| Keys | Action |
|---|---|
| `]d` / `[d` | Next / previous diagnostic |
| `]e` / `[e` | Next / previous **error** only |
| `]w` / `[w` | Next / previous warning |
| `gl` / `Space ld` | Show the full message |
| `Space lD` | Search all diagnostics |

Workflow: `]e`, then `Space la` picks a fix, repeat.

### Completion (popup while typing)
| Keys | Action |
|---|---|
| `Tab` / `Shift-Tab` | Next / previous item (also jumps through snippet fields) |
| `Ctrl-j` / `Ctrl-k` | Next / previous item |
| `Enter` | Accept |
| `Ctrl-e` | Close the popup |
| `Ctrl-Space` | Open the popup manually / toggle docs |
| `Ctrl-u` / `Ctrl-d` | Scroll the docs window |

### Debugging
Set a breakpoint, start, step. Same keys in every language (Go/delve, Rust & C/C++/codelldb, Python/debugpy, JS/TS, Java, Bash).

| Keys | Action |
|---|---|
| `F9` / `Space db` | Toggle breakpoint |
| `F5` / `Space dc` | Start / continue |
| `F10` / `Space do` | Step over |
| `F11` / `Space di` | Step into |
| `Space dO` | Step out |
| `Space ds` | Run to cursor |
| `Space dh` | Inspect the value under the cursor |
| `Space du` | Toggle debugger UI |
| `Space dQ` | Stop |

> On a Mac, F-keys may control brightness and volume. Use the `Space d…` versions or hold `fn`.

### Git
| Keys | Action |
|---|---|
| `Space gg` | **Lazygit**: a full git UI (stage, commit, push, branches, rebase) |
| `Space gt` | Git status picker |
| `Space gc` / `Space gC` | Commits (repo / current file) |
| `Space gb` | Branches |
| `Space go` | Open the file on GitHub |

Lazygit basics: `Space` stage file, `c` commit, `P` push, `p` pull, arrow keys or `h/l` to switch panels, `?` help, `q` quit.

---

## 6. Language-specific extras

| Language | Extras |
|---|---|
| **Go** | `:GoTagAdd json` (struct tags), `:GoIfErr` (insert `if err != nil`), `:GoImpl` (implement an interface), `:GoTestAdd`. Imports are fixed on save. |
| **Rust** | `:RustLsp runnables` (run main/tests), `:RustLsp expandMacro`, `:RustLsp explainError`, `:RustLsp openCargo`. In `Cargo.toml`, crate versions show inline. |
| **C / C++** | Needs a `compile_commands.json` for accurate results (CMake: `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`). `:ClangdSwitchSourceHeader` jumps between `.h` and `.c/.cpp`. CMake commands: `:CMakeGenerate`, `:CMakeBuild`, `:CMakeRun`. |
| **Python** | Ruff lints and formats on save; basedpyright checks types. Activate your venv **before** launching `nvim` (`source .venv/bin/activate`) so imports resolve. |
| **JS / TS / React / Vue** | Prettier formats on save. JSX/HTML tags auto-close and auto-rename. `:TSC` type-checks the whole project. In `package.json`, package versions show inline. |
| **Java** | Open a folder that has `pom.xml` or `build.gradle`. The first start takes a minute while jdtls indexes. |
| **Terraform / HCL** | Formats on save; tflint and tfsec flag mistakes and security issues inline. |
| **Bash** | shellcheck warnings inline, shfmt formats on save. |

Check which tools are attached to the current file: `Space li`. Install or update tools: `Space pm` (Mason).

---

## 7. Level 5: Power moves (one per day)

| Move | What it does |
|---|---|
| `ciw` then `.` | Change a word, then `n` to the next match and `.` to repeat |
| `*` then `cgn` then `.` `.` `.` | Change the word, then repeat on each next occurrence (a safer multi-cursor) |
| `qa` … `q`, then `@a`, `@@` | Record a macro to register `a`, play it, replay it. `10@a` runs it 10 times. |
| `:g/pattern/d` | Delete every line matching a pattern |
| `:norm A;` (in Visual) | Append `;` to every selected line |
| `ma` then `` `a `` | Set mark `a`, jump back to it later (`Space f'` lists marks) |
| `"ayy` then `"ap` | Copy into named register `a`, paste from it (`Space fr` lists registers) |
| `Ctrl-a` / `Ctrl-x` | Increment / decrement the number under the cursor |
| `gv` | Reselect the last selection |
| `zz` / `zt` / `zb` | Scroll so the cursor line is centred / at the top / at the bottom |
| `za` / `zR` / `zM` | Toggle fold / open all / close all |
| `J` | Join the line below onto this one |
| `~` | Toggle case |
| `xp` | Swap two characters |
| `ddp` | Swap two lines |
| `Space uZ` | Zen mode (distraction-free) |
| `Space uw` | Toggle word wrap |
| `Space uh` | Toggle inlay hints (types shown inline) |
| `Space ud` | Toggle diagnostics |

---

## 8. Customising (when you're ready)

Your config lives in `~/.config/nvim` (`Space fa` searches it).

| File | Purpose |
|---|---|
| `lua/community.lua` | Language packs and extras from [AstroCommunity](https://github.com/AstroNvim/astrocommunity) |
| `lua/plugins/astrocore.lua` | Options and your own keymaps |
| `lua/plugins/astroui.lua` | Theme and UI |
| `lua/plugins/astrolsp.lua` | Language server settings |
| `lua/plugins/user.lua` | Add any plugin |
| `lua/polish.lua` | Runs last; small one-off tweaks |

**Important:** most template files start with `if true then return {} end`. **Delete that line** to turn the file on.

Maintenance:
| Keys | Action |
|---|---|
| `Space pa` | Update plugins + Mason tools |
| `Space ps` | Plugin status |
| `:checkhealth` | Diagnose problems |

---

## 9. One-page cheat sheet

```
MODES         i a o  insert │ v V ^v visual │ Esc / jk  back to normal │ : command
MOVE          hjkl │ w b e │ 0 ^ $ │ gg G │ ^d ^u │ f/t<char> ; , │ % │ { }
EDIT          x dd yy p P u ^r . │ verb+noun: d c y > gc  +  w $ iw i" i( it if ic ia
SEARCH        /text n N * │ :%s/a/b/gc
FILES         ␣ff files │ ␣fw grep │ ␣fc word │ ␣fo recent │ ␣e tree │ ␣fk keymaps
BUFFERS       ]b [b │ ␣bb pick │ ␣c close        SPLITS  | \ │ ^h^j^k^l │ ␣q
CODE          gd gy gI grr K │ ^o back │ ␣lr rename │ ␣la action │ ␣lf format │ ␣/ comment
ERRORS        ]e [e ]d [d │ gl show │ ␣lD all
COMPLETE      Tab S-Tab │ Enter accept │ ^e close │ ^Space open
DEBUG         F9/␣db break │ F5/␣dc go │ F10/␣do over │ F11/␣di into │ ␣du UI
GIT           ␣gg lazygit │ ␣gc commits │ ␣go GitHub
TERMINAL      ^' or F7 │ ␣th ␣tv │ ␣tp python │ ␣tn node
SAVE / QUIT   ␣w │ ␣q │ ␣Q │ :q!
LOST?         Esc Esc, then press Space and read the menu
```

---

## Further resources
- `nvim +Tutor`: the built-in interactive tutorial (start here)
- `:help` + topic, e.g. `:help text-objects`, `:help motion.txt`
- AstroNvim docs: https://docs.astronvim.com
- AstroCommunity packs: https://github.com/AstroNvim/astrocommunity
- *Practical Vim* by Drew Neil: the best book on thinking in Vim
- https://vim-adventures.com: a game for learning the motions

---

*Written by Claude (Claude Opus 5.5, Anthropic) via Claude Code, 2026-10-23. Every keybinding was checked against this config.*
