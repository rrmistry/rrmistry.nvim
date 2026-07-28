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
    -- Shift + mouse wheel scrolls horizontally (VS Code behavior); by
    -- default vim treats shifted wheel as page-scroll instead
    mappings = {
      n = {
        ["<S-ScrollWheelUp>"] = { "<ScrollWheelLeft>", desc = "Scroll left" },
        ["<S-ScrollWheelDown>"] = { "<ScrollWheelRight>", desc = "Scroll right" },
        ["<Down>"] = { "gj", desc = "Move down (visual line)" },
        ["<Up>"] = { "gk", desc = "Move up (visual line)" },
        -- navigate ALL hunks differing from the last commit, staged or not
        -- (gitsigns' default target='unstaged' goes quiet once a file is staged)
        ["]g"] = { function() require("gitsigns").nav_hunk("next", { target = "all" }) end, desc = "Next Git hunk" },
        ["[g"] = { function() require("gitsigns").nav_hunk("prev", { target = "all" }) end, desc = "Previous Git hunk" },
        ["]G"] = { function() require("gitsigns").nav_hunk("last", { target = "all" }) end, desc = "Last Git hunk" },
        ["[G"] = { function() require("gitsigns").nav_hunk("first", { target = "all" }) end, desc = "First Git hunk" },
        -- gitsigns split diffs (AstroNvim ships neither binding)
        ["<Leader>gd"] = {
          function() require("gitsigns").diffthis() end,
          desc = "View Git diff",
        },
        ["<Leader>gD"] = {
          function() require("gitsigns").diffthis "~1" end,
          desc = "View Git diff against previous commit",
        },
        -- default agent CLI is runtime-switchable (palette: "AI: choose
        -- default CLI provider"); falls back to Claude Code
        ["<Leader>Aa"] = {
          function() require("sidekick.cli").toggle { name = vim.g.ai_cli or "claude", focus = true } end,
          desc = "Sidekick Toggle CLI (default provider)",
        },
      },
      v = {
        ["<S-ScrollWheelUp>"] = { "<ScrollWheelLeft>", desc = "Scroll left" },
        ["<S-ScrollWheelDown>"] = { "<ScrollWheelRight>", desc = "Scroll right" },
      },
      -- arrows move by visual line through soft-wrapped text (VS Code style);
      -- j/k keep vim's physical-line semantics
      x = {
        ["<Down>"] = { "gj", desc = "Move down (visual line)" },
        ["<Up>"] = { "gk", desc = "Move up (visual line)" },
      },
      i = {
        ["<S-ScrollWheelUp>"] = { "<ScrollWheelLeft>", desc = "Scroll left" },
        ["<S-ScrollWheelDown>"] = { "<ScrollWheelRight>", desc = "Scroll right" },
        ["<Down>"] = { "<C-o>gj", desc = "Move down (visual line)" },
        ["<Up>"] = { "<C-o>gk", desc = "Move up (visual line)" },
      },
    },
    autocmds = {
      -- open the repo README (any case: README.md, ReadMe.md, readme.rst,
      -- bare README) when starting nvim without a file, e.g. `nvim` or
      -- `nvim .` — lands in the main window, sidebar untouched
      auto_open_readme = {
        {
          event = "VimEnter",
          desc = "Open repo README when starting without a file",
          callback = function()
            vim.defer_fn(function()
              for _, b in ipairs(vim.api.nvim_list_bufs()) do
                local name = vim.api.nvim_buf_get_name(b)
                if vim.bo[b].buflisted and name ~= "" and vim.fn.isdirectory(name) == 0 then
                  return -- a real file is already open
                end
              end
              local cwd = vim.fn.getcwd()
              local best
              for _, name in ipairs(vim.fn.readdir(cwd) or {}) do
                local l = name:lower()
                if l == "readme.md" then
                  best = name
                  break
                elseif not best and (l == "readme" or l:match "^readme%.%w+$") then
                  best = name
                end
              end
              if not best then return end
              local target
              for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local wb = vim.api.nvim_win_get_buf(w)
                if vim.bo[wb].filetype ~= "neo-tree" and vim.api.nvim_win_get_config(w).relative == "" then
                  target = w
                  break
                end
              end
              local function open() vim.cmd.edit(vim.fs.joinpath(cwd, best)) end
              if target then
                vim.api.nvim_win_call(target, open)
              else
                open()
              end
            end, 150)
          end,
        },
      },
    },
    options = {
      opt = {
        -- terminal window title: project root basename first, then the file
        -- path — "myproject • src/main.py [+]" (cwd tracks the project root
        -- via the rooter below)
        titlestring = "%{fnamemodify(getcwd(), ':t')} • %f %m",
        -- soft wrap on by default (AstroNvim ships wrap=false); linebreak
        -- wraps at word boundaries like VS Code
        wrap = true,
        linebreak = true,
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
