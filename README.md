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
| `Ctrl+Shift+P` | Command palette ([legendary.nvim](https://github.com/mrjones2014/legendary.nvim)) — fuzzy-search commands and keymaps by plain-English descriptions. Needs terminal + tmux extended-keys support; `:Legendary` always works |
| `<Space>yp` / `<Space>yr` / `<Space>yn` | Copy absolute path / relative path / filename of the current file (reaches your local clipboard over SSH/tmux via OSC 52) |
| `<Space>sr` | Project-wide search & replace with preview ([grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim)) |

## Pulling updates from the AstroNvim template

```shell
git fetch upstream
git merge upstream/main
```

`upstream` is added automatically when cloning with `gh repo clone`; otherwise add it once with `git remote add upstream https://github.com/AstroNvim/template`.
