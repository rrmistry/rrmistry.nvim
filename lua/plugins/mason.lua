-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "typos-lsp", -- spelling warnings in code/comments/identifiers, low noise
        "cucumber-language-server", -- LSP for Gherkin *.feature files

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",
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
      -- conform's builtin ghokin definition omits stdin=false, so it formats
      -- the LAST-SAVED file and clobbers unsaved buffer edits on every
      -- format/save. stdin=false makes conform feed it a temp copy of the
      -- buffer instead. (upstream bug in conform's ghokin spec)
      formatters = {
        ghokin = { stdin = false },
      },
      formatters_by_ft = {
        -- ghokin is not in mason: go install github.com/antham/ghokin/v3/cmd/ghokin@latest
        cucumber = { "ghokin" },
        python = { "isort", "black" },
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
    },
  },
}
