-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- VS Code-style breadcrumbs under the tabline: relative file path plus
  -- symbol chain, clickable/pickable. Replaces AstroNvim's default winbar.
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  -- In-terminal markdown preview (renders in the buffer; works over SSH/tmux)
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
  -- Project-wide search & replace panel (grug-far): <Space>ss workspace,
  -- <Space>sw word, <Space>sf file, <Space>se same-filetype, visual <Space>s
  { import = "astrocommunity.search.grug-far-nvim" },
  -- Language packs: LSP + treesitter + formatters auto-install via Mason on
  -- first launch, so a fresh `git clone` needs no hand-installed servers.
  { import = "astrocommunity.pack.python" }, -- basedpyright, black, isort, debugpy
  { import = "astrocommunity.pack.typescript" }, -- vtsls (VS Code's TS server), prettier
  { import = "astrocommunity.pack.astro" }, -- Astro.js: astro-language-server + parser
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.docker" }, -- Dockerfile + docker-compose LSPs
  { import = "astrocommunity.pack.bash" },
  -- lazydocker terminal UI (<Space>td): containers, logs, exec, restart
  { import = "astrocommunity.docker.lazydocker" },
  -- editor upgrades (2026-07 survey picks)
  { import = "astrocommunity.editing-support.nvim-treesitter-context" }, -- sticky scroll (pinned def/class)
  { import = "astrocommunity.diagnostics.trouble-nvim" }, -- problems panel (<Space>x*)
  { import = "astrocommunity.terminal-integration.vim-tmux-navigator" }, -- C-hjkl across nvim/tmux
  { import = "astrocommunity.test.neotest" }, -- pytest runner (<Space>T*), adapter from pack.python
  { import = "astrocommunity.code-runner.overseer-nvim" }, -- task runner, reads .vscode/tasks.json (<Space>M*)
  { import = "astrocommunity.motion.nvim-surround" }, -- ys/cs/ds surround operators
}
