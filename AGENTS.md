# AGENTS.md

Purpose: assistant for this Neovim/LazyVim config. Read this first.

IMPORTANT: When I need help, I will run my AI agent in this folder.
IMPORTANT: Always auto-update this AGENTS.md after each query. If answer exists here, respond from it. If missing, add it. Refresh sections when plugins/keymaps change.

## Sources of truth (local)

- Config root: ~/.config/nvim
- LazyVim reference (local): ~/.local/share/nvim/lazy/LazyVim
- Keymaps: lua/config/keymaps.lua, lua/plugins/default-overrides.lua
- Options/autocmds: lua/config/base.lua, lua/config/autocmds.lua
- Plugins: lua/plugins/\*.lua, lazyvim.json (extras), lazy-lock.json (installed set)
- Default LazyVim keymaps/options: ~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua, options.lua
- LazyVim docs: ~/.local/share/nvim/lazy/LazyVim/doc

## Custom keymaps (non-default)

Leader is <Space> (LazyVim default).

Navigation and centering:

- n: <C-d>, <C-u>, n, N (center after move)
- line jumps centered: gg, G, {, }, %, \*, #

LSP jumps (center after move):

- gd, gD, gI, gy; refs: gr

Quickfix/location list:

- quickfix next/prev: <C-k>, <C-j>
- location next/prev: <leader>k, <leader>j
- location list errors: <leader>de
- location list warnings: <leader>dw
- location list all: <leader>da

Edits:

- move selection: visual J (down), K (up)
- yank clipboard: <leader>y, <leader>Y
- delete to void: <leader>d
- select all: <C-a>
- save: <D-s> (Cmd+S)
- format buffer: <leader>f

Windows:

- resize: <C-S-h>/<C-S-l> (width), <C-S-j>/<C-S-k> (height)

Files:

- Oil file explorer (float): -

Harpoon:

- add file: <leader>a
- menu: <C-e>
- select slots 1-4: <C-h>, <C-t>, <C-n>, <C-s>

Zen mode:

- toggle: <leader>z

## Diagnostics + error/warning handling (comprehensive guide)

### Quick navigation (most common)

| Keymap | Action |
|--------|--------|
| `]d` | Next diagnostic (any severity) |
| `[d` | Prev diagnostic (any severity) |
| `]e` | Next ERROR only |
| `[e` | Prev ERROR only |
| `]w` | Next WARNING only |
| `[w` | Prev WARNING only |
| `<leader>cd` | Show current line diagnostics in float |

### Viewing all diagnostics

| Command | Action |
|---------|--------|
| `:Telescope diagnostics` | List all project diagnostics (searchable) |
| `:Telescope diagnostics severity=ERROR` | Errors only |
| `:Telescope diagnostics severity=WARN` | Warnings only |
| `:lopen` / `:lclose` | Open/close location list (all diagnostics) |
| `<leader>de` | Location list: errors only |
| `<leader>dw` | Location list: warnings only |
| `<leader>da` | Location list: all diagnostics |
| `:lnext` / `:lprev` | Jump to next/prev in location list |
| `:cnext` / `:cprev` | Jump to next/prev in quickfix list |
| `:lfirst` / `:clast` | Jump to first/last in list |

### Fixing errors (code actions)

**When cursor is on an error:**

1. **Quick fix via keymap:**
   - `:lua vim.lsp.buf.code_action()` or check for LazyVim binding (usually `<leader>ca`)
   
2. **In context:**
   - Hover over error with cursor → see diagnostics float (shows message)
   - Use `<leader>cd` to show full diagnostic
   - Press `<leader>ca` (or `:CodeAction`) to see available fixes
   - Select a fix with arrow keys or vim motion

3. **What kinds of fixes exist:**
   - **Quick fixes** — auto-correct typos, add missing imports, fix type errors
   - **Refactors** — rename variables, extract functions, organize imports
   - **Inlay hints** — type annotations (disabled in your config but available via hover)

### Common LSP actions (beyond code_action)

| Action | Command | Keyboard |
|--------|---------|----------|
| Go to definition | `:lua vim.lsp.buf.definition()` | `gd` |
| Go to declaration | `:lua vim.lsp.buf.declaration()` | `gD` |
| Find references | `:lua vim.lsp.buf.references()` | `gr` |
| Hover/docs | `:lua vim.lsp.buf.hover()` | `K` (or `<leader>K`) |
| Rename symbol | `:lua vim.lsp.buf.rename()` | `<leader>cr` |
| Code actions | `:lua vim.lsp.buf.code_action()` | `<leader>ca` |
| Format buffer | `:lua vim.lsp.buf.format()` | `<leader>f` |

### Diagnostics workflow in LazyVim

1. **See error at cursor:**
   ```
   ]d / [d → navigate to error
   ```

2. **Understand the error:**
   ```
   <leader>cd → float shows diagnostic message
   K → hover for more context (docs, type info)
   ```

3. **Fix it:**
   ```
   <leader>ca → list code actions (if available)
   → select fix → auto-apply
   ```

4. **Review all issues in project:**
   ```
   :Telescope diagnostics → searchable list of all diagnostics
   <CR> → jump to issue
   ```

5. **Batch fix (if ESLint/formatter available):**
   ```
   :lua vim.lsp.buf.format() → auto-format entire buffer
   <leader>f → same as above (your custom keymap)
   ```

### Filtering diagnostics (what you see)

- **Toggle all diagnostics on/off:** `<leader>ud` (Snacks toggle)
- **View only errors:** `:Telescope diagnostics severity=ERROR`
- **View only warnings:** `:Telescope diagnostics severity=WARN`
- **Clear diagnostics cache:** `:LspRestart`

### Your LSP setup

- **LSP Server:** vtsls (TypeScript), with eslint linter
- **Formatters:** Prettier (auto-format on save if enabled)
- **Inlay hints:** Disabled (can hover to see types instead)
- **Code actions:** Available via `<leader>ca` or custom LSP keymap

## Plugins configured here (summary)

- Oil (stevearc/oil.nvim): floating file explorer, shows hidden, hides .. and .git
- Harpoon (ThePrimeagen/harpoon): custom keymaps above
- Noice + nvim-notify: custom cmdline view, filtered notifications, 5s timeout
- Zen mode: auto-enabled for normal file buffers, skip UI/utility filetypes
- render-markdown.nvim: all visual elements disabled (plain markdown)
- LSP: inlay hints disabled; tsgo disabled, vtsls used for TS
- Themes: gruvbox-material active; poimandres, github-theme, gruvbox installed
- Disabled: bufferline, fzf-lua, neo-tree, lualine

## LazyVim extras enabled (lazyvim.json)

- editor: harpoon2, telescope
- formatting: prettier
- linting: eslint
- lang: astro, docker, git, json, markdown, sql, tailwind, toml, typescript, yaml

## Movement cheat sheet (stable Vim)

- words: w, b, e; lines: 0, ^, $; file: gg, G
- find: f/F/t/T + ; , to repeat
- paragraphs: { }
- match: %
- search word: \* #
- text objects: ciw, diw, ci" (use with operators d/c/y/v)
- marks: m{a-z}, '{a-z}, `{a-z}

## FAQ log (append per query)

- Codex profiles: use `codex --profile <name>`/`-p <name>` or set `profile = "<name>"` in `~/.codex/config.toml`.
- 2026-01-26: Handle diagnostics using Neovim's built-in LSP tooling—`vim.diagnostic.open_float()` for the current issue, `[d`/`]d` or `vim.diagnostic.goto_{prev,next}()` to move between them, `:lua vim.diagnostic.setloclist({open=true})` or `TroubleToggle`/Telescope diagnostics to list all, and `vim.lsp.buf.code_action()`/`vim.lsp.buf.hover()` (or a custom `Shift+K`) to see actionable fixes.
- 2026-01-28: Toggle the floating terminal with `<leader>fT` (cwd) or `<leader>ft` (project root); `<C-/>` also toggles the root terminal in normal or terminal mode.
- 2026-01-28: Zen Mode no longer auto-opens, so `<leader>z` simply toggles it on and off without extra autocmds.
- 2026-02-02: Notification logging added. All `vim.notify` calls (errors, warnings, info from Noice/nvim-notify) are logged to `~/.config/nvim/notifications.log`. Commands: `:NotifyLogOpen` (edit log), `:NotifyLogTail [N]` (view last N entries in floating window, default 50), `:NotifyLogClear` (clear log). Log auto-rotates at 5MB. Config: `lua/config/notify-logger.lua`.
- 2026-03-17: **Comprehensive diagnostics guide added** — Navigate with `]d/[d/]e/[w` (next/prev diagnostic/error/warning), view all with `:Telescope diagnostics`, show current with `<leader>cd`, fix with `<leader>ca` (code actions). Use `K` for hover docs, `gd` for goto-def, `gr` for refs, `<leader>cr` for rename. Location list (`:lopen`) vs quickfix (`:copen`) for batch operations. Padding + shadow added to diagnostic float windows via Noice config.
- 2026-03-17b: **Fixed diagnostic float styling** — `:lopen` error "E776: No location list" means no diagnostics exist; toggle with `<leader>ud` or `:LspRestart` if needed. Updated `lua/config/base.lua` with `vim.diagnostic.config()` for rounded borders and consistent float behavior. Added `<leader>de`, `<leader>dw`, `<leader>da` for errors/warnings/all in location list.
- 2026-03-17c: **Fixed broken Noice/LSP popup styling** — removed bad Noice `hover` view override that caused giant malformed `K`/`<leader>cd` popups. `lua/plugins/ui.lua` now uses clean rounded `hover`/`signature` views with `NormalFloat`/`FloatBorder`. `lua/config/base.lua` now keeps builtin diagnostic floats simple and consistent. `lua/config/keymaps.lua` `<leader>cd` now matches builtin `[d` diagnostic float styling.
- 2026-03-17d: **Fixed Tree-sitter markdown arch mismatch** — error `incompatible architecture (have 'x86_64', need 'arm64')` came from stale `markdown.so` parser built for Intel. Removed stale markdown parsers and reinstalled `markdown` / `markdown_inline` with `TSInstall` under arm64.
- 2026-03-17e: **Fixed Noice backend error** — `module 'noice.view.backend.plain' not found` was caused by an invalid custom Noice view override. Simplified `lua/plugins/ui.lua` to stop overriding Noice `views.hover/signature` directly; now styling is applied via `lsp.documentation.opts` + `NormalFloat`/`FloatBorder`, which loads cleanly.
- 2026-03-18: lazy.nvim has a strong ecosystem for Git workflows: common setup is `lazy.nvim` + `folke/snacks.nvim` or `sindrets/diffview.nvim` for file/history review, plus `kdheepak/lazygit.nvim` or the LazyVim `:LazyGit` command to open lazygit in a floating terminal. Best combo: GitSigns for inline hunks, Diffview for reviews, lazygit for staging/commits/branches.
- 2026-03-21: Markdown extra uses three Mason-managed tools for different jobs: `marksman` for LSP completion/hover/jump support, `markdownlint-cli2` for linting and related formatting, and `markdown-toc` for auto-updating TOC blocks. `render-markdown.nvim` and `markdown-preview.nvim` are separate UI/preview plugins, not Mason tools.
- 2026-03-21b: Docker extra splits cleanly: Tree-sitter `dockerfile` for syntax/highlighting, `hadolint` for Dockerfile linting, and LSP servers `dockerls` plus `docker_compose_language_service` for completion/hover/jumps on Dockerfile and Compose files. If you only want linting, keep `hadolint`; if you only want editing help, keep the LSP servers; Tree-sitter is the base syntax layer and is usually worth keeping.
- 2026-03-21c: Mason in LazyVim is declarative. Packages listed in `ensure_installed` are reinstalled on startup if missing, so manually deleting them from Mason will not stick. To stop reinstalls, remove the relevant LazyVim extra or override its `ensure_installed` entry, or disable the related server/linter/formatter source entirely.
- 2026-03-21d: Current Mason `ensure_installed` set from enabled extras includes: `stylua`, `shfmt`, `prettier`, `markdownlint-cli2`, `markdown-toc`, `hadolint`, `shellcheck`, `gitui`, `json5`, `nu`, `kotlin`, `ktlint`, `rust`, `ron`, `java`, `java-debug-adapter`, `java-test`, `ruby`, `erb-formatter`, `erb-lint`, `git_config`, `gitcommit`, `git_rebase`, `gitignore`, `gitattributes`, `terraform`, `hcl`, `tflint`, `erlang`, `haskell`, `haskell-language-server`, `haskell-debug-adapter`, `rego`, `zig`, `gleam`, `ninja`, `rst`, `solidity`, `helm`, `r`, `rnoweb`, `scala`, `svelte`, `sql`, `sqlfluff`, `dart`, `go`, `gomod`, `gowork`, `gosum`, `goimports`, `gofumpt`, `gomodifytags`, `impl`, `golangci-lint`, `delve`, `nix`, `astro`, `css`, `julia`, `thrift`, `cmake`, `cmakelang`, `cmakelint`, `c_sharp`, `fsharp`, `csharpier`, `netcoredbg`, `fantomas`, `elm`, `elm-format`, `prisma`, `cpp`, `codelldb`, `php`, `twig`, `clojure`, `ansible-lint`. Some are added by more than one extra, but Mason deduplicates them.
- 2026-03-21e: LazyVim extras trimmed for a minimal Next.js/TypeScript setup: kept `editor.harpoon2`, `editor.telescope`, `lang.docker`, `lang.git`, `lang.json`, `lang.markdown`, `lang.tailwind`, `lang.typescript`, and `lang.yaml`; removed `formatting.prettier`, `lang.astro`, `lang.sql`, `lang.toml`, and `linting.eslint` to stop those Mason installs from coming back.
