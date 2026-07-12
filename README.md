# rrmistry.nvim

Personal [AstroNvim](https://astronvim.com) configuration — a fork of [AstroNvim/template](https://github.com/AstroNvim/template) with a VS Code-style command palette and a few quality-of-life additions.

## Installation

```shell
git clone https://github.com/rrmistry/rrmistry.nvim "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

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
