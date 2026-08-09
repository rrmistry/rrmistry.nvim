# rrmistry.nvim

Personal [AstroNvim](https://astronvim.com) configuration — a fork of [AstroNvim/template](https://github.com/AstroNvim/template) with a VS Code-style command palette and a few quality-of-life additions.

## Installation

```shell
git clone https://github.com/rrmistry/rrmistry.nvim "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

## Dev containers

Mount the config plus a persistent named volume for Neovim's data and the full IDE works pre-configured inside a dev container — no `git clone` in the container, and rebuilds reuse everything. Validated against `mcr.microsoft.com/devcontainers/python:dev-3-bookworm` (arm64): all 75 plugins auto-install on first start (~2 min), mason installs the LSPs/formatters, treesitter compiles parsers, and a rebuilt container starts instantly with 0 missing plugins.

```jsonc
{
  "image": "mcr.microsoft.com/devcontainers/python:dev-3-bookworm",
  "mounts": [
    "source=${localEnv:HOME}/.config/nvim,target=/home/vscode/.config/nvim,type=bind",
    "source=nvim-devcontainer-data,target=/home/vscode/.local/share/nvim,type=volume"
  ],
  // chown: docker creates the volume mountpoint's parent dirs root-owned,
  // which would block nvim from creating ~/.local/state.
  // Then install nvim from the release tarball (bump version to taste).
  "onCreateCommand": "sudo chown -R vscode: /home/vscode/.local && curl -fsSL https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-$(dpkg --print-architecture | sed s/amd64/x86_64/).tar.gz | sudo tar xz -C /opt && sudo ln -sf /opt/nvim-linux-*/bin/nvim /usr/local/bin/nvim"
}
```

Why a named volume for `~/.local/share/nvim` instead of binding the host's: that directory holds mason binaries and compiled treesitter parsers built for the **host** OS/arch — macOS binaries can't run in a Linux container. The named volume lets containers install their own Linux toolchain once and share it across rebuilds and projects.

Notes (validated on the python bookworm image):

- First start installs the newest plugin versions each pin allows and **writes them to `lazy-lock.json`** — through the bind mount, so the repo shows a modified lock file afterward. `git restore lazy-lock.json` to keep the current pins, or commit the bump deliberately.
- `tree-sitter-cli` is pinned to v0.25.10 in this config (`lua/plugins/mason.lua`) — 0.26+ release binaries need glibc 2.39, bookworm ships 2.36. Bump the pin when the base images move past bookworm.
- The python image ships no Node.js, so the one npm-based server (`vtsls`, TypeScript) skips its install; everything else lands. Add node to the container (e.g. the devcontainers `node` feature) if you want TS tooling there.

## Extras on top of the template

| Keys | What |
| --- | --- |
| `Ctrl+P` / `Ctrl+Shift+P` | Command palette ([legendary.nvim](https://github.com/mrjones2014/legendary.nvim)) — fuzzy-search commands and keymaps by plain-English descriptions. `:Legendary` always works |
| `<Space>yp` / `<Space>yr` / `<Space>yn` | Copy absolute path / relative path / filename of the current file (reaches your local clipboard over SSH/tmux via OSC 52) |
| `<Space>ss` | Project-wide search & replace with preview ([grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)). `<Space>sw` prefills the word under cursor, `<Space>sf` scopes to the current file, `<Space>se` to files of the same extension; visual `<Space>s` prefills the selection |

### Search & replace panel (grug-far) cheat sheet

VS Code-style global replace. Fill **Search** and **Replace** (diff preview appears per match), use **Files Filter** to include globs (`*.py`, `src/**` — one per line) and exclude with negative globs (`!**/node_modules/**`); extra rg options like `--iglob=!*.min.js` or `--pcre2` go in **Flags**.

The panel opens in the current window. In it (localleader is `,`) — these also show up in the `Ctrl+P` palette while the panel is focused:

| Key | Action |
| --- | --- |
| `,j` / `,k` | Apply this match and jump to next / previous |
| `dd` on a match | Exclude it from "apply all" |
| `,s` | Apply all remaining matches (respects exclusions) |
| `,c` | Close panel |
| `g?` | Full help |

## Pulling updates from the AstroNvim template

```shell
git fetch upstream
git merge upstream/main
```

`upstream` is added automatically when cloning with `gh repo clone`; otherwise add it once with `git remote add upstream https://github.com/AstroNvim/template`.
