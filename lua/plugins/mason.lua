-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      -- language-specific tools come from the packs in community.lua;
      -- only cross-cutting tools are ensured here
      ensure_installed = {
        "typos-lsp", -- spelling warnings in code/comments/identifiers, low noise
        "cucumber-language-server", -- LSP for Gherkin *.feature files (no pack exists)
        "debugpy", -- python debug adapter (pack.python does not ensure it)
        "tree-sitter-cli", -- lets treesitter auto_install compile new parsers
      },
    },
  },
  -- Configure conform.nvim (imported from astrocommunity). The community
  -- spec routes ALL formatting through conform (astrolsp/none-ls formatting
  -- disabled), so the formatters none-ls used to run are declared here.
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- conform's builtin ghokin definition passes $FILENAME, making ghokin
      -- format the LAST-SAVED file and clobber unsaved buffer edits. With no
      -- file arg, `ghokin fmt stdout` reads stdin, so conform feeds it the
      -- live buffer. (upstream bug in conform's ghokin spec)
      formatters = {
        ghokin = { args = { "fmt", "stdout" } },
      },
      -- python/lua/sh formatters are declared by their packs (optional
      -- conform specs); only gherkin has no pack and lives here.
      formatters_by_ft = {
        -- ghokin is not in mason: go install github.com/antham/ghokin/v3/cmd/ghokin@latest
        cucumber = { "ghokin" },
      },
    },
  },
}
