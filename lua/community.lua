-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- VS Code-style winbar: relative path, filename, symbol breadcrumbs —
  -- the official AstroNvim docs recipe (recipes/status)
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
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
  -- AI: Copilot completions inside blink.cmp, plus sidekick for Copilot
  -- next-edit suggestions and the Claude Code CLI terminal (<Space>A*)
  { import = "astrocommunity.completion.blink-copilot" },
  { import = "astrocommunity.ai.sidekick-nvim" },
  -- editor upgrades (2026-07 survey picks)
  -- conform: single formatting pipeline (community spec disables astrolsp/
  -- none-ls formatting; formatters are declared in lua/plugins/mason.lua)
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-context" }, -- sticky scroll
  -- VS Code-style stickiness: follow the top visible line (not the cursor),
  -- so nested if/for/while contexts pin while mouse-scrolling too.
  -- Merge-fragment on the community spec above (not a separate install);
  -- `optional` = applies only while the astrocommunity import exists.
  { "nvim-treesitter/nvim-treesitter-context", optional = true, opts = { mode = "topline" } },
  { import = "astrocommunity.diagnostics.trouble-nvim" }, -- problems panel (<Space>x*)
  { import = "astrocommunity.terminal-integration.vim-tmux-navigator" }, -- C-hjkl across nvim/tmux
  { import = "astrocommunity.test.neotest" }, -- pytest runner (<Space>T*), adapter from pack.python
  { import = "astrocommunity.code-runner.overseer-nvim" }, -- task runner, reads .vscode/tasks.json (<Space>M*)
  { import = "astrocommunity.motion.nvim-surround" }, -- ys/cs/ds surround operators
  { import = "astrocommunity.git.neogit" }, -- git dashboard: stage/unstage/discard/commit/amend (<Space>gn*)
  -- Neogit maps <C-p> to PreviousSection in its status buffer, shadowing the
  -- command palette; free it (section-jump stays on <C-n>, hunks on { / })
  { "NeogitOrg/neogit", optional = true, opts = { mappings = { status = { ["<c-p>"] = false } } } },
  { import = "astrocommunity.git.diffview-nvim" }, -- VS Code-style git tree: staged & unstaged diffs
  -- extra lazy-load triggers so panel commands work before first DiffviewOpen
  {
    "sindrets/diffview.nvim",
    optional = true,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  },
  { import = "astrocommunity.utility.noice-nvim" },
}
