# 🧭 Complete Neovim Configuration Guide

> A beginner-friendly walkthrough of every file, every plugin, and every keybinding in this config.

---

## Table of Contents

- [How This Config is Organized](#how-this-config-is-organized)
- [The Entry Point — init.lua](#the-entry-point--initlua)
- [Core Settings](#core-settings)
  - [Plugin Manager (lazy.nvim)](#1-plugin-manager--lazylua)
  - [Editor Options](#2-editor-options--optionslua)
  - [Keymaps](#3-keymaps--keymapslua)
  - [File Templates](#4-file-templates--templateslua)
- [Plugins](#plugins)
  - [🎨 Colorschemes](#-colorschemes)
  - [📂 File Tree (nvim-tree)](#-file-tree--nvim-tree)
  - [🔍 Fuzzy Finder (fzf-lua)](#-fuzzy-finder--fzf-lua)
  - [🧠 LSP (Language Server Protocol)](#-lsp--language-server-protocol)
  - [✨ Autocompletion (blink.cmp)](#-autocompletion--blinkcmp)
  - [🌳 Treesitter (Syntax Highlighting & More)](#-treesitter--syntax-highlighting--more)
  - [🧩 Treesitter Text Objects](#-treesitter-text-objects)
  - [🧹 Code Formatting (conform.nvim)](#-code-formatting--conformnvim)
  - [📝 Markdown Rendering](#-markdown-rendering)
  - [📁 Project Management (neovim-project)](#-project-management--neovim-project)
  - [🔗 Surround (nvim-surround)](#-surround--nvim-surround)
  - [⌨️ Show Keys](#️-show-keys)
  - [📊 Statusline (mini.statusline)](#-statusline--ministatusline)
  - [📐 Code Folding (nvim-ufo)](#-code-folding--nvim-ufo)
  - [❓ Which Key](#-which-key)
  - [🪟 Dressing.nvim](#-dressingnvim)
- [Complete Keybinding Cheat Sheet](#-complete-keybinding-cheat-sheet)
- [Quick-Start FAQ](#-quick-start-faq)

---

## How This Config is Organized

```
~/.config/nvim/
├── init.lua                  ← The starting point; Neovim reads this first
├── lazy-lock.json            ← Auto-generated lockfile for plugin versions
├── templates/                ← Skeleton files auto-inserted into new files
│   ├── skeleton.html
│   ├── skeleton.cpp
│   ├── skeleton.java
│   └── skeleton.css
└── lua/
    ├── core/                 ← Core editor settings (not plugins)
    │   ├── lazy.lua          ← Plugin manager bootstrap & setup
    │   ├── options.lua       ← Editor behavior (tabs, line numbers, etc.)
    │   ├── keymaps.lua       ← Custom keyboard shortcuts
    │   └── templates.lua     ← Auto-inserts skeleton code into new files
    └── plugins/              ← One file per plugin (or plugin group)
        ├── blink-cmp.lua
        ├── colorscheme.lua
        ├── conform.lua
        ├── dressing.lua
        ├── filetree.lua
        ├── fzflua.lua
        ├── lsp.lua
        ├── markdown-nvim.lua
        ├── nvim-project.lua
        ├── nvim-surround.lua
        ├── showkeys.lua
        ├── statusline.lua
        ├── treesitter-nvim.lua
        ├── treesitter-textobjects.lua
        ├── ufo.lua
        └── which-key.lua
```

> [!TIP]
> Each file inside `lua/plugins/` returns a Lua table that the plugin manager (**lazy.nvim**) reads automatically. You never need to manually register a plugin — just drop a new `.lua` file in `plugins/` and restart Neovim.

---

## The Entry Point — init.lua

**File:** [init.lua](file:///home/xandev/.config/nvim/init.lua)

This is the very first file Neovim runs. It does four things:

| Step | What it does |
|------|-------------|
| `require("core.lazy")` | Loads the plugin manager and all plugins |
| `require("core.keymaps")` | Loads custom keyboard shortcuts |
| `require("core.options")` | Loads editor settings (tabs, numbers, etc.) |
| `fzf-lua register_ui_select` | Makes Neovim's built-in selection prompts (like "pick a code action") use the fuzzy finder instead of a plain list |
| `require("core.templates")` | Loads the file templates system — auto-inserts boilerplate when creating new files |

**Transparency setup:** The file also loops through a list of highlight groups (Normal, StatusLine, Pmenu, etc.) and sets their background to `none`. This makes the editor **transparent**, so your terminal's wallpaper or background shows through.

**Markdown tweaks:** Sets `conceallevel = 2` (hides markdown syntax like `**bold**` and shows it rendered) and makes bold text actually bold in markdown files.

---

## Core Settings

### 1. Plugin Manager — [lazy.lua](file:///home/xandev/.config/nvim/lua/core/lazy.lua)

**What is lazy.nvim?** It's the most popular Neovim plugin manager. It automatically downloads, updates, and loads plugins for you. Think of it like `npm` or `pip`, but for Neovim plugins.

**What this file does:**

1. **Bootstrap:** If lazy.nvim isn't installed yet, it clones it from GitHub automatically. This means on a fresh machine you just open Neovim and everything installs itself.
2. **Leader key:** Sets the **leader key** to `Space`. The leader key is a prefix for custom shortcuts — when you see `<leader>ff`, it means press `Space` then `f` then `f`.
3. **Plugin loading:** Tells lazy.nvim to load every file from the `lua/plugins/` directory.
4. **Colorscheme:** Sets the active colorscheme to **Vesper** (a warm, dark theme with transparent background).
5. **ShowKeys:** Auto-enables the ShowKeys display on startup.
6. **Markdown code block colors:** Sets a custom dark green-tinted background (`#1d2523`) for rendered markdown code blocks.

> [!NOTE]
> You can see commented-out lines for other colorschemes (`mellow`, `melange`). To switch themes, uncomment one and comment out the current one.

---

### 2. Editor Options — [options.lua](file:///home/xandev/.config/nvim/lua/core/options.lua)

These are the "settings" of Neovim itself — no plugins involved.

| Setting | Value | What it means in plain English |
|---------|-------|-------------------------------|
| `expandtab` | `true` | Pressing Tab inserts **spaces** instead of a tab character |
| `shiftwidth` | `2` | Indenting (with `>>` or auto-indent) uses **2 spaces** |
| `tabstop` | `2` | A tab character looks **2 spaces** wide |
| `softtabstop` | `2` | Pressing Tab inserts **2 spaces** |
| `smarttab` | `true` | Tab at the beginning of a line inserts the right amount of spaces |
| `smartindent` | `true` | Neovim guesses the correct indent for new lines (e.g., after `{`) |
| `autoindent` | `true` | New lines copy the indent of the current line |
| `breakindent` | `true` | When a long line wraps, the wrapped portion stays indented |
| `number` | `true` | Shows **line numbers** in the left gutter |
| `relativenumber` | `true` | Line numbers are **relative** to your cursor (helps with motions like `5j`) |
| `cursorline` | `true` | Highlights the entire line where your cursor is |
| `undofile` | `true` | Saves undo history to disk — you can undo changes even after closing and reopening a file |
| `mouse` | `"a"` | Mouse works in **all modes** (clicking, scrolling, selecting) |
| `showmode` | `false` | Hides the `-- INSERT --` text at the bottom (the statusline already shows this) |
| `ignorecase` | `true` | Searches are **case-insensitive** by default |
| `smartcase` | `true` | …unless you type an uppercase letter, then it becomes **case-sensitive** |
| `signcolumn` | `"yes"` | Always shows the sign column (left gutter for error/warning icons) — prevents the text from jumping |
| `splitright` | `true` | New vertical splits open to the **right** |
| `splitbelow` | `true` | New horizontal splits open **below** |
| `scrolloff` | `5` | Keeps **5 lines** visible above/below your cursor when scrolling |

---

### 3. Keymaps — [keymaps.lua](file:///home/xandev/.config/nvim/lua/core/keymaps.lua)

Custom keyboard shortcuts defined outside of any plugin. The **leader key is Space**.

#### General

| Keybinding | Mode | Action |
|-----------|------|--------|
| `Space` `e` | Normal | Toggle the file tree sidebar |
| `Space` `h` | Normal | Clear search highlights |

#### Fuzzy Finding (fzf-lua)

| Keybinding | Mode | Action |
|-----------|------|--------|
| `Space` `f` `f` | Normal | **Find files** — search for any file in your project |
| `Space` `f` `g` | Normal | **Live grep** — search for text inside all files |
| `Space` `g` `b` | Normal | **Git branches** — list and switch git branches |
| `Space` `f` `b` | Normal | **Builtins** — show all fzf-lua picker commands |
| `Space` `f` `h` | Normal | **Help tags** — search Neovim's help documentation |
| `Space` `f` `k` | Normal | **Keymaps** — search all keybindings |
| `Space` `f` `w` | Normal | **Find word** — search for the word under your cursor |
| `Space` `f` `W` | Normal | **Find WORD** — search for the WORD under your cursor (includes punctuation) |
| `Space` `f` `d` | Normal | **Diagnostics** — show all errors/warnings in the current file |
| `Space` `f` `r` | Normal | **Resume** — reopen the last fuzzy finder you used |
| `Space` `f` `o` | Normal | **Old files** — recently opened files |
| `Space` `Space` | Normal | **Buffers** — switch between open files |
| `Space` `/` | Normal | **Grep current buffer** — search text within the current file |

#### Formatting

| Keybinding | Mode | Action |
|-----------|------|--------|
| `Space` `c` `f` | Normal | **Format current file** using conform.nvim (falls back to LSP) |

---

### 4. File Templates — [templates.lua](file:///home/xandev/.config/nvim/lua/core/templates.lua)

**What is it?** When you create a **brand-new file** (e.g., `:e NewPage.html`), Neovim automatically fills it with a starter template so you don't have to type boilerplate from scratch. This is *not* a plugin — it's a custom feature built with a Neovim autocommand.

**How it works:** When a `BufNewFile` event fires (i.e., you open a file that doesn't exist yet), the script checks the file extension, finds the matching skeleton template in `~/.config/nvim/templates/`, and inserts it into the buffer.

#### Supported Templates

| Extension | Template File | What you get |
|-----------|--------------|-------------|
| `.html` | [skeleton.html](file:///home/xandev/.config/nvim/templates/skeleton.html) | Full HTML5 boilerplate with `<meta>` tags, a linked `style.css`, and a `script.js` |
| `.cpp` | [skeleton.cpp](file:///home/xandev/.config/nvim/templates/skeleton.cpp) | `#include <iostream>`, `using namespace std;`, and an empty `main()` function |
| `.java` | [skeleton.java](file:///home/xandev/.config/nvim/templates/skeleton.java) | A `public class` matching the filename with an empty `main()` method — cursor lands inside `main()` in insert mode |
| `.css` | [skeleton.css](file:///home/xandev/.config/nvim/templates/skeleton.css) | CSS reset (`margin: 0`, `padding: 0`, `box-sizing: border-box`) and a `body` rule with `system-ui` font |

#### Special Placeholders

Templates can contain special placeholders that get replaced automatically:

| Placeholder | What happens |
|------------|-------------|
| `%CLASS%` | Replaced with the filename (without extension). Used in Java templates so `MyApp.java` creates `public class MyApp` |
| `%CURSOR%` | The cursor jumps to this position and enters **insert mode**, so you can start typing immediately. The placeholder text is removed |

> [!TIP]
> To add a new template, create a `skeleton.{ext}` file in `~/.config/nvim/templates/` and add a mapping in [templates.lua](file:///home/xandev/.config/nvim/lua/core/templates.lua#L6-L11). For example, to add a Python template, create `skeleton.py` and add `py = "skeleton.py"` to the `template_map` table.

---

## Plugins

### 🎨 Colorschemes

**File:** [colorscheme.lua](file:///home/xandev/.config/nvim/lua/plugins/colorscheme.lua)

**What are colorschemes?** They control the colors of everything you see — code syntax, UI elements, backgrounds. This config installs **5 themes** but only uses one at a time.

| Plugin | Theme Style | Notes |
|--------|------------|-------|
| [Catppuccin](https://github.com/catppuccin/nvim) | Pastel, modern | Configured with transparent background and nvim-tree integration |
| [Gruvbox](https://github.com/ellisonleao/gruvbox.nvim) | Retro, warm browns/greens | Classic, highly readable |
| [Melange](https://github.com/savq/melange-nvim) | Warm, earthy tones | |
| [**Vesper**](https://github.com/datsfilipe/vesper.nvim) | Dark, warm gold accents | **← Currently active**, configured with transparency |
| [Mellow](https://github.com/mellow-theme/mellow.nvim) | Soft, muted tones | |

> [!TIP]
> To switch themes, edit the `vim.cmd.colorscheme("vesper")` line in [lazy.lua](file:///home/xandev/.config/nvim/lua/core/lazy.lua#L39). All five themes are already installed and ready.

---

### 📂 File Tree — nvim-tree

**File:** [filetree.lua](file:///home/xandev/.config/nvim/lua/plugins/filetree.lua)  
**Plugin:** [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

**What is it?** A sidebar that shows your project's files and folders — like the left panel in VS Code.

**Toggle it:** Press `Space` `e`

**Configuration details:**

| Setting | Value | Meaning |
|---------|-------|---------|
| `dotfiles` | `false` | **Shows** dotfiles (like `.gitignore`, `.env`) — they are NOT hidden |
| `git.ignore` | `false` | **Shows** git-ignored files (like `node_modules`) — they are NOT hidden |
| `update_focused_file` | `true` | When you switch to a file, the tree automatically highlights it |
| `update_root` | `true` | The tree root updates when you move to a file in a different directory |
| `group_empty` | `true` | Collapses empty single-child directories into one line (e.g., `src/components/` instead of showing `src/` → `components/` separately) |

**Dependencies:**
- **nvim-web-devicons** — adds file-type icons (e.g., 🟦 for `.ts`, 🟨 for `.js`)

---

### 🔍 Fuzzy Finder — fzf-lua

**File:** [fzflua.lua](file:///home/xandev/.config/nvim/lua/plugins/fzflua.lua)  
**Plugin:** [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua)

**What is it?** A lightning-fast fuzzy finder. Type a few characters and it narrows down files, text, commands — anything. Think of it like `Ctrl+P` in VS Code, but much more powerful.

**Config:** Uses default settings — the heavy customization is in the keymaps (see [keymaps.lua](file:///home/xandev/.config/nvim/lua/core/keymaps.lua)).

This plugin is used **everywhere** in this config:
- **File finding** (`Space ff`) — all the keymaps in `keymaps.lua`
- **LSP navigation** — go-to-definition, find references, code actions (configured in `lsp.lua`)
- **UI select** — replaces Neovim's built-in selection menus (registered in `init.lua`)
- **Project picker** — the project management plugin uses it

See the [Keymaps section](#3-keymaps--keymapslua) for all fzf-lua shortcuts.

---

### 🧠 LSP — Language Server Protocol

**File:** [lsp.lua](file:///home/xandev/.config/nvim/lua/plugins/lsp.lua)  
**Plugin:** [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

**What is LSP?** Language Server Protocol is a standard that gives your editor IDE-like superpowers: go-to-definition, autocomplete, error checking, rename across files, etc. Each programming language has its own "language server" — a background process that understands that language.

**This is the largest and most important config file.** Here's what it sets up:

#### Language Servers Installed

These are the language servers that get **automatically installed** via Mason:

| Server | Language / Purpose |
|--------|--------------------|
| `bashls` | Bash / Shell scripts |
| `marksman` | Markdown |
| `clangd` | C / C++ |
| `tailwindcss` | Tailwind CSS classes |
| `cssls` | CSS |
| `css_variables` | CSS custom properties |
| `cssmodules_ls` | CSS Modules |
| `html` | HTML |
| `hyprls` | Hyprland config files |
| `jsonls` | JSON |
| `ruff` | Python (linting/formatting) |
| `stylua` | Lua formatting |
| `pyright` | Python (type checking & intellisense) |
| `ts_ls` | TypeScript / JavaScript |
| `lua_ls` | Lua |

#### Additional Tools Installed

These are **formatters and linters** (not language servers) also auto-installed via Mason:

| Tool | Purpose |
|------|---------|
| `stylua` | Lua formatter |
| `ruff` | Python linter/formatter |
| `prettierd` | Fast Prettier daemon for web files |
| `prettier` | Fallback web formatter |
| `clang-format` | C/C++ formatter |

#### Dependencies (other plugins that LSP relies on)

| Plugin | What it does |
|--------|-------------|
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Package manager that auto-installs language servers, linters, and formatters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridges Mason and lspconfig so installed servers auto-configure |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Ensures specific tools are installed on startup |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | Shows a small spinner/progress indicator when a language server is loading |

#### LSP Keybindings

These shortcuts **only work** when a language server is attached to the current file:

| Keybinding | Action | Description |
|-----------|--------|-------------|
| `g` `d` | Go to Definition | Jump to where a function/variable was defined |
| `g` `r` | Go to References | Find every place a function/variable is used |
| `g` `I` | Go to Implementation | Jump to the actual implementation (useful for interfaces) |
| `g` `D` | Go to Declaration | Jump to the declaration (e.g., C header files) |
| `Space` `D` | Type Definition | See the type definition of the symbol under cursor |
| `Space` `d` `s` | Document Symbols | List all functions, variables, etc. in the current file |
| `Space` `w` `s` | Workspace Symbols | Search symbols across the entire project |
| `Space` `c` `r` | Rename | Rename a variable/function across all files |
| `Space` `c` `a` | Code Action | Show suggested fixes and refactors (via fzf-lua) |
| `Space` `t` `h` | Toggle Inlay Hints | Show/hide inline type annotations |

#### Diagnostics Configuration

The file configures how errors and warnings appear:

| Feature | Setting |
|---------|---------|
| Underlines | Only for **errors** (not warnings/hints) |
| Sign column icons | 󰅚 Error, 󰀪 Warning, 󰋽 Info, 󰌶 Hint |
| Virtual text | Shows error messages inline at the end of the line |
| Floating windows | Rounded borders, shows source when there are multiple |
| Sorting | Sorted by severity (errors first) |

#### Cursor Highlight

When you rest your cursor on a symbol, all other uses of that symbol in the file get **highlighted**. Move your cursor away, and the highlights clear. This works automatically when the language server supports it.

---

### ✨ Autocompletion — blink.cmp

**File:** [blink-cmp.lua](file:///home/xandev/.config/nvim/lua/plugins/blink-cmp.lua)  
**Plugin:** [saghen/blink.cmp](https://github.com/saghen/blink.cmp)

**What is it?** The autocompletion engine — it shows a dropdown of suggestions as you type, pulling from multiple sources.

#### Completion Sources

| Source | What it provides |
|--------|-----------------|
| `lsp` | Suggestions from the language server (function names, variables, types) |
| `path` | File path completions (type `./` and see files) |
| `snippets` | Code snippets from **friendly-snippets** (e.g., type `for` → get a full for-loop) |
| `buffer` | Words already in the current file |
| `emoji` | Emoji completions (only in **markdown** and **git commit** files) |
| `sql` | SQL keyword completions (only in **.sql** files) |

#### Keybindings

| Keybinding | Action |
|-----------|--------|
| `Ctrl` `Space` | Open the completion menu (or open docs if menu is visible) |
| `Ctrl` `n` / `Ctrl` `p` | Navigate down/up through suggestions |
| `Ctrl` `y` | Accept the selected suggestion (default preset) |
| `Ctrl` `Z` | Alternative accept (custom binding) |
| `Ctrl` `e` | Close the completion menu |
| `Ctrl` `k` | Toggle function signature help |

#### Other Settings

| Setting | Value | Meaning |
|---------|-------|---------|
| `documentation.auto_show` | `true` | Docs popup appears automatically when you highlight a completion |
| `signature.enabled` | `true` | Shows function parameter hints as you type arguments |
| `nerd_font_variant` | `"mono"` | Icons use Nerd Font Mono spacing (for proper alignment) |
| `fuzzy.implementation` | `"prefer_rust_with_warning"` | Uses a fast Rust-based fuzzy matcher for better performance and typo tolerance |

#### Dependencies

| Plugin | Purpose |
|--------|---------|
| [blink.compat](https://github.com/saghen/blink.compat) | Compatibility layer to use nvim-cmp sources inside blink.cmp |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Large collection of pre-made code snippets for many languages |
| [blink-emoji.nvim](https://github.com/moyiz/blink-emoji.nvim) | Emoji completion source |
| [cmp-sql](https://github.com/ray-x/cmp-sql) | SQL keyword completion source (adapted via blink.compat) |

---

### 🌳 Treesitter — Syntax Highlighting & More

**File:** [treesitter-nvim.lua](file:///home/xandev/.config/nvim/lua/plugins/treesitter-nvim.lua)  
**Plugin:** [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

**What is Treesitter?** It builds a real **syntax tree** of your code (like a compiler does), enabling extremely accurate syntax highlighting, smart indentation, and features like "select the entire function." Traditional highlighting uses simple regex patterns — Treesitter actually *understands* your code's structure.

#### Installed Parsers

A "parser" is a language-specific module that Treesitter downloads to understand that language:

| Parser | Language |
|--------|----------|
| `lua` | Lua |
| `vim`, `vimdoc` | Vim script & help files |
| `c`, `cpp` | C / C++ |
| `git_config` | Git config files |
| `html`, `css` | Web markup & styles |
| `java` | Java |
| `javascript`, `typescript` | JS / TS |
| `json` | JSON |
| `luadoc` | Lua documentation comments |
| `python` | Python |
| `php` | PHP |
| `rust` | Rust |
| `sql` | SQL |
| `yaml` | YAML |
| `markdown`, `markdown_inline` | Markdown |

#### Features Enabled

- **Syntax highlighting** — via `vim.treesitter.start()`, automatically activated for any file type with an installed parser
- **Smart indentation** — `indentexpr` is set to use Treesitter's understanding of code structure

#### Incremental Selection (treesitter-modules.nvim)

**Plugin:** [MeanderingProgrammer/treesitter-modules.nvim](https://github.com/MeanderingProgrammer/treesitter-modules.nvim)

This restores a removed Treesitter feature: **smart selection expansion**.

| Keybinding | Action |
|-----------|--------|
| `Enter` | Start a selection / expand it to the next larger syntax node |
| `Backspace` | Shrink the selection back to the previous smaller node |

**Example:** Cursor on a variable → press Enter → selects the variable → press Enter → selects the expression → press Enter → selects the whole statement → press Enter → selects the function body → and so on.

---

### 🧩 Treesitter Text Objects

**File:** [treesitter-textobjects.lua](file:///home/xandev/.config/nvim/lua/plugins/treesitter-textobjects.lua)  
**Plugin:** [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

**What are text objects?** In Vim, you can say things like `diw` (delete inside word) or `ci"` (change inside quotes). Text objects are the "targets" — `iw` means "inside word", `i"` means "inside quotes". This plugin adds **code-aware** text objects.

#### Selection Text Objects

Use these with operators like `d` (delete), `c` (change), `y` (yank/copy), `v` (visual select):

| Text Object | What it selects | Example use |
|-------------|----------------|-------------|
| `af` | **Around function** — the entire function including signature | `daf` = delete entire function |
| `if` | **Inside function** — just the function body | `vif` = select function body |
| `ac` | **Around class** — entire class | `yac` = copy entire class |
| `ic` | **Inside class** — class body only | `dic` = delete class body |
| `ao` | **Around comment** — entire comment block | `dao` = delete comment |
| `ah` | **Around heading** — markdown heading with content | |
| `ih` | **Inside heading** — markdown heading content only | |
| `al` | **Around list** — markdown list | |
| `il` | **Inside list** — markdown list items | |
| `as` | **Around scope** — language scope (block, module) | |

#### Selection Modes

| Text object target | Visual mode used |
|--------------------|-----------------|
| `@parameter.outer` | `v` (character-wise) |
| `@function.outer` | `V` (line-wise — selects whole lines) |
| `@class.outer` | `Ctrl+v` (block-wise) |

#### Swap (Reorder Parameters)

| Keybinding | Action |
|-----------|--------|
| `Space` `a` | Swap the current parameter with the **next** one |
| `Space` `A` | Swap the current parameter with the **previous** one |

**Example:** In `function(a, b, c)` with cursor on `b`, pressing `Space` `a` changes it to `function(a, c, b)`.

---

### 🧹 Code Formatting — conform.nvim

**File:** [conform.lua](file:///home/xandev/.config/nvim/lua/plugins/conform.lua)  
**Plugin:** [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)

**What is it?** Automatically formats your code when you save, or on demand with `Space cf`. It runs external formatters (like Prettier, stylua, clang-format) on your code.

#### Format on Save

- **Enabled** — every time you save (`:w`), your code is automatically formatted
- **Timeout:** 500ms — if the formatter takes too long, it's skipped
- **LSP fallback:** If no formatter is configured for a file type, it falls back to the language server's formatting

#### Formatters by File Type

| File type | Formatter(s) | Behavior |
|-----------|-------------|----------|
| Lua | `stylua` | Single formatter |
| Python | `ruff` | Single formatter |
| JavaScript | `prettierd` → `prettier` | Tries the faster daemon first; falls back to regular prettier |
| TypeScript | `prettierd` → `prettier` | Same as above |
| JSX (React) | `prettierd` → `prettier` | Same |
| TSX (React) | `prettierd` → `prettier` | Same |
| HTML | `prettierd` → `prettier` | Same |
| CSS | `prettierd` → `prettier` | Same |
| SCSS | `prettierd` → `prettier` | Same |
| JSON | `prettierd` → `prettier` | Same |
| C / C++ | `clang-format` | Single formatter |
| Markdown | `prettierd` → `prettier` | Same fallback pattern |
| YAML | `prettierd` → `prettier` | Same |

> [!NOTE]
> `stop_after_first = true` means it tries `prettierd` first, and only runs `prettier` if `prettierd` isn't available. It does **not** run both.

---

### 📝 Markdown Rendering

**File:** [markdown-nvim.lua](file:///home/xandev/.config/nvim/lua/plugins/markdown-nvim.lua)  
**Plugin:** [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)

**What is it?** Renders markdown beautifully **inside Neovim** — headings get colored bars, code blocks get backgrounds, tables get borders, lists get nice bullets. No need to switch to a browser to preview.

**Config:** Uses defaults. The custom code block background color (`#1d2523`) is set in [lazy.lua](file:///home/xandev/.config/nvim/lua/core/lazy.lua#L44-L45).

**Dependencies:**
- **nvim-treesitter** — for parsing markdown syntax
- **mini.nvim** — for icons

---

### 📁 Project Management — neovim-project

**File:** [nvim-project.lua](file:///home/xandev/.config/nvim/lua/plugins/nvim-project.lua)  
**Plugin:** [coffebar/neovim-project](https://github.com/coffebar/neovim-project)

**What is it?** Remembers your projects and their sessions (open files, cursor positions, window layouts). Switch between projects seamlessly.

#### Project Roots

The plugin looks for projects in these directories:

| Path | What it finds |
|------|--------------|
| `~/coding` | Projects directly in the coding folder |
| `~/.config/*` | Each config directory (like this Neovim config) |
| `~` | Home directory as a fallback |

#### Session Management

| Setting | Value | Meaning |
|---------|-------|---------|
| Auto-suppress directories | `~/scratch`, `/tmp`, `~/` | These directories won't create sessions (to avoid clutter) |
| Session saving | `globals` appended to `sessionoptions` | Saves plugin state (like nvim-tree) across sessions |

#### Picker

Uses **fzf-lua** for the project selection interface.

#### Dependencies

| Plugin | Purpose |
|--------|---------|
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Utility library (many plugins depend on this) |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Project picker UI |
| [neovim-session-manager](https://github.com/Shatur/neovim-session-manager) | Handles saving/restoring sessions |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File tree state is included in sessions |

---

### 🔗 Surround — nvim-surround

**File:** [nvim-surround.lua](file:///home/xandev/.config/nvim/lua/plugins/nvim-surround.lua)  
**Plugin:** [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)

**What is it?** Lets you quickly add, change, or delete "surrounding" characters — quotes, brackets, HTML tags, etc.

**Config:** Uses all defaults. Loaded lazily (only when first needed).

#### How to Use

| Action | Keybinding | Example | Result |
|--------|-----------|---------|--------|
| **Add** surrounding | `ys{motion}{char}` | `ysiw"` (cursor on `hello`) | `"hello"` |
| **Change** surrounding | `cs{old}{new}` | `cs"'` (on `"hello"`) | `'hello'` |
| **Delete** surrounding | `ds{char}` | `ds"` (on `"hello"`) | `hello` |
| **Add** in visual mode | Select text, then `S{char}` | Select `hello`, press `S)` | `(hello)` |

> [!TIP]
> This works with any pair: `()`, `[]`, `{}`, `""`, `''`, `` ` ` ``, HTML tags (`t`), and more.

---

### ⌨️ Show Keys

**File:** [showkeys.lua](file:///home/xandev/.config/nvim/lua/plugins/showkeys.lua)  
**Plugin:** [nvzone/showkeys](https://github.com/nvzone/showkeys)

**What is it?** Displays your keypresses in a small floating window. Useful for screencasts, demos, or learning what keys you're pressing.

**Config:**
- `maxkeys = 5` — shows the last 5 keypresses
- Auto-enabled on startup via `ShowkeysToggle` in [lazy.lua](file:///home/xandev/.config/nvim/lua/core/lazy.lua#L43)

---

### 📊 Statusline — mini.statusline

**File:** [statusline.lua](file:///home/xandev/.config/nvim/lua/plugins/statusline.lua)  
**Plugin:** [echasnovski/mini.statusline](https://github.com/echasnovski/mini.statusline)

**What is it?** The bar at the very bottom of your editor. It shows the current mode (NORMAL/INSERT/VISUAL), file name, file type, cursor position, git branch, diagnostics count, etc.

**Config:** Uses all defaults — mini.statusline is designed to look good out of the box with minimal config.

---

### 📐 Code Folding — nvim-ufo

**File:** [ufo.lua](file:///home/xandev/.config/nvim/lua/plugins/ufo.lua)  
**Plugin:** [kevinhwang91/nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)

**What is it?** Advanced code folding — collapse and expand functions, classes, or code blocks. Uses Treesitter for smart fold detection.

**Config:**

| Setting | Value | Meaning |
|---------|-------|---------|
| `foldcolumn` | `"1"` | Shows a thin fold column on the left (fold markers) |
| `foldlevel` | `99` | All folds start **open** (nothing is collapsed by default) |
| `foldlevelstart` | `99` | Same as above — for new buffers |
| `foldenable` | `true` | Folding is enabled |
| Fold provider | `treesitter` → `indent` | Uses Treesitter to find fold points; falls back to indentation |

**Dependencies:**
- [promise-async](https://github.com/kevinhwang91/promise-async) — async utilities required by nvim-ufo

#### How to Use

| Keybinding | Action |
|-----------|--------|
| `za` | Toggle fold under cursor |
| `zo` | Open fold under cursor |
| `zc` | Close fold under cursor |
| `zR` | Open all folds |
| `zM` | Close all folds |

---

### ❓ Which Key

**File:** [which-key.lua](file:///home/xandev/.config/nvim/lua/plugins/which-key.lua)  
**Plugin:** [folke/which-key.nvim](https://github.com/folke/which-key.nvim)

**What is it?** A popup that shows you all available keybindings when you start pressing a key combination. If you press `Space` and pause, a window appears listing every `Space + ...` shortcut. **Invaluable for learning the config.**

**Config:**
- Uses defaults
- `Space` `?` — shows **buffer-local** keymaps only (keybindings specific to the current file type)

---

### 🪟 Dressing.nvim

**File:** [dressing.lua](file:///home/xandev/.config/nvim/lua/plugins/dressing.lua)  
**Plugin:** [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)

**What is it?** Makes Neovim's built-in input prompts and selection menus look beautiful. Instead of a plain text input at the bottom of the screen, you get a nicely styled floating window. Works automatically — no keybindings needed.

**Config:** Uses all defaults.

---

## 🗺 Complete Keybinding Cheat Sheet

> **Leader key = `Space`**. When you see `<leader>`, press `Space`.

### General

| Key | Mode | Action |
|-----|------|--------|
| `Space` `e` | Normal | Toggle file tree |
| `Space` `h` | Normal | Clear search highlights |
| `Space` `?` | Normal | Show buffer keymaps (which-key) |

### Finding Things (fzf-lua)

| Key | Mode | Action |
|-----|------|--------|
| `Space` `f` `f` | Normal | Find files |
| `Space` `f` `g` | Normal | Live grep (search text in all files) |
| `Space` `f` `b` | Normal | fzf-lua builtins |
| `Space` `f` `h` | Normal | Search help tags |
| `Space` `f` `k` | Normal | Search keymaps |
| `Space` `f` `w` | Normal | Grep word under cursor |
| `Space` `f` `W` | Normal | Grep WORD under cursor |
| `Space` `f` `d` | Normal | Document diagnostics |
| `Space` `f` `r` | Normal | Resume last search |
| `Space` `f` `o` | Normal | Recently opened files |
| `Space` `Space` | Normal | Switch buffers |
| `Space` `/` | Normal | Grep in current buffer |
| `Space` `g` `b` | Normal | Git branches |

### LSP (only active with a language server)

| Key | Mode | Action |
|-----|------|--------|
| `g` `d` | Normal | Go to definition |
| `g` `r` | Normal | Go to references |
| `g` `I` | Normal | Go to implementation |
| `g` `D` | Normal | Go to declaration |
| `Space` `D` | Normal | Type definition |
| `Space` `d` `s` | Normal | Document symbols |
| `Space` `w` `s` | Normal | Workspace symbols |
| `Space` `c` `r` | Normal | Rename symbol |
| `Space` `c` `a` | Normal, Visual | Code action |
| `Space` `t` `h` | Normal | Toggle inlay hints |

### Formatting

| Key | Mode | Action |
|-----|------|--------|
| `Space` `c` `f` | Normal | Format current file |

### Treesitter Selection

| Key | Mode | Action |
|-----|------|--------|
| `Enter` | Normal/Visual | Start / expand selection |
| `Backspace` | Visual | Shrink selection |

### Text Objects (use with `d`, `c`, `y`, `v`)

| Object | What it targets |
|--------|----------------|
| `af` / `if` | Around / inside function |
| `ac` / `ic` | Around / inside class |
| `ao` | Around comment |
| `ah` / `ih` | Around / inside heading |
| `al` / `il` | Around / inside list |
| `as` | Around scope |

### Swapping

| Key | Mode | Action |
|-----|------|--------|
| `Space` `a` | Normal | Swap parameter with next |
| `Space` `A` | Normal | Swap parameter with previous |

### Autocompletion (in insert mode)

| Key | Action |
|-----|--------|
| `Ctrl` `Space` | Open completion / docs |
| `Ctrl` `n` / `Ctrl` `p` | Next / previous suggestion |
| `Ctrl` `y` | Accept suggestion |
| `Ctrl` `Z` | Accept suggestion (alternative) |
| `Ctrl` `e` | Close menu |
| `Ctrl` `k` | Toggle signature help |

### Folding

| Key | Action |
|-----|--------|
| `za` | Toggle fold |
| `zo` / `zc` | Open / close fold |
| `zR` / `zM` | Open all / close all folds |

### Surround

| Key | Action | Example |
|-----|--------|---------|
| `ys{motion}{char}` | Add surrounding | `ysiw"` → wrap word in quotes |
| `cs{old}{new}` | Change surrounding | `cs"'` → change `"` to `'` |
| `ds{char}` | Delete surrounding | `ds"` → remove quotes |
| `S{char}` (visual) | Surround selection | Select + `S)` → wrap in `()` |

---

## 🔰 Quick-Start FAQ

### How do I open a file?
Press `Space` `f` `f`, start typing the filename, press `Enter`.

### How do I search for text across my project?
Press `Space` `f` `g`, type your search term.

### How do I go to where a function is defined?
Put your cursor on the function name, press `g` `d`.

### How do I rename a variable everywhere?
Put your cursor on it, press `Space` `c` `r`, type the new name, press `Enter`.

### How do I format my code?
Press `Space` `c` `f`. Or just save the file — it auto-formats.

### How do I see all available shortcuts?
Press `Space` and wait — the which-key popup will show you everything.

### How do I switch between open files?
Press `Space` `Space` to see all open buffers.

### How do I toggle the file sidebar?
Press `Space` `e`.

### How do I switch colorschemes?
Edit [lazy.lua](file:///home/xandev/.config/nvim/lua/core/lazy.lua#L39) and change the `vim.cmd.colorscheme()` call. Available: `vesper`, `catppuccin-mocha`, `gruvbox`, `melange`, `mellow`.

### What if I can't remember a keybinding?
Press `Space` `f` `k` to fuzzy-search all keymaps, or press `Space` and wait for which-key.
