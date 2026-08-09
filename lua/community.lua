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
  -- python: selective subpack imports (the README-documented pattern).
  -- Importing "pack.python" whole would drag in ALL variants (ruff, pyrefly,
  -- ty) via lazy's directory import, stacking type checkers and overriding
  -- black with ruff_format.
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.basedpyright" },
  { import = "astrocommunity.pack.python.black" },
  { import = "astrocommunity.pack.python.isort" },
  -- ruff LSP: in-editor lint diagnostics + autofix actions, driven by each
  -- project's own pyproject/ruff.toml (near-silent pyflakes defaults where
  -- none exists; hover stays with basedpyright). This subpack also sets the
  -- conform chain to ruff — the per-project arbitration lives in
  -- plugins/mason.lua: ruff-configured repos format with ruff, all others
  -- keep isort+black.
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.typescript" }, -- vtsls (VS Code's TS server), prettier
  { import = "astrocommunity.pack.astro" }, -- Astro.js: astro-language-server + parser
  { import = "astrocommunity.pack.lua" }, -- lua_ls, stylua, lazydev (this config!)
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.docker" }, -- Dockerfile + docker-compose LSPs
  { import = "astrocommunity.pack.bash" },
  -- lazydocker terminal UI (<Space>td): containers, logs, exec, restart
  { import = "astrocommunity.docker.lazydocker" },
  -- REST client for *.http files (vscode-restclient equivalent): send
  -- requests, env vars, intellisense via kulala-ls (<Space>r*)
  { import = "astrocommunity.programming-language-support.kulala-nvim" },
  -- CSV visualization: column alignment/highlighting, header freeze,
  -- column-aware sort (commands in the palette while in a csv buffer)
  { import = "astrocommunity.programming-language-support.csv-vim" },
  -- the community spec's ft-lazy load arrives too late: Neovim's runtime
  -- now ships its own ftplugin/csv.vim whose b:did_ftplugin guard blocks
  -- csv.vim's. Eager load puts csv.vim's ftplugin first in rtp order.
  { "chrisbra/csv.vim", optional = true, lazy = false },
  -- AI: Copilot completions inside blink.cmp, plus sidekick for Copilot
  -- next-edit suggestions and the Claude Code CLI terminal (<Space>A*)
  { import = "astrocommunity.completion.blink-copilot" },
  { import = "astrocommunity.ai.sidekick-nvim" },
  -- NES draws from the Copilot free-tier quota on every edit; keep it
  -- opt-in per session (<Space>Ane enables, <Space>Ant toggles)
  { "folke/sidekick.nvim", optional = true, opts = { nes = { enabled = false } } },
  -- Windsurf (Codeium) ghost-text inline suggestions — the default AI
  -- completion provider (generous free tier). Sign in once: :Codeium Auth
  { import = "astrocommunity.completion.codeium-nvim" },
  -- Windsurf accept keys: Tab is owned by blink (see the arbitration in
  -- plugins/copilot.lua), so codeium's own Tab map is off; partial accepts
  -- match VS Code muscle memory (insert-mode Ctrl+arrows are free).
  {
    "Exafunction/codeium.nvim",
    optional = true,
    opts = {
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = false, -- blink's Tab chain accepts instead
          accept_word = "<C-Right>",
          accept_line = "<C-Down>",
        },
      },
    },
  },
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
  { import = "astrocommunity.git.diffview-nvim" }, -- VS Code-style git tree: staged & unstaged diffs
  { import = "astrocommunity.git.codediff-nvim" }, -- VS Code diff algorithm & rendering; t toggles inline/split
  -- extra lazy-load triggers so panel commands work before first DiffviewOpen
  {
    "sindrets/diffview.nvim",
    optional = true,
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
  },
  { import = "astrocommunity.utility.noice-nvim" },
}
