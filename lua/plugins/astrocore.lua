-- AstroCore: core AstroNvim options. See `:h astrocore` for all keys.
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Tiltfiles are Starlark; gets treesitter highlighting via auto_install
    filetypes = {
      filename = { Tiltfile = "starlark" },
    },
    options = {
      opt = {
        -- terminal window title: project root basename first, then the file
        -- path — "myproject • src/main.py [+]" (cwd tracks the project root
        -- via the rooter below)
        titlestring = "%{fnamemodify(getcwd(), ':t')} • %f %m",
      },
    },
    -- Keep the working directory on the project root (VS Code-workspace-like):
    -- version-control root first so breadcrumbs, file search, and grep stay
    -- relative to the repo regardless of where nvim was launched from or
    -- which root an LSP reports.
    rooter = {
      detector = {
        { ".git", "_darcs", ".hg", ".bzr", ".svn" },
        "lsp",
        { "lua", "MakeFile", "package.json" },
      },
      autochdir = true,
      scope = "global",
      notify = false,
    },
  },
}
