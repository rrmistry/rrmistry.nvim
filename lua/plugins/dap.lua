-- TypeScript/JavaScript debugging via js-debug-adapter (pwa-node).
-- mason-nvim-dap installs the adapter but ships no default setup for it,
-- so the adapter and launch/attach configurations are wired here.
-- Python needs none of this: nvim-dap-python (pack.python) self-configures.
---@type LazySpec
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "js" })
    end,
  },
  {
    -- VS Code-style F5: rerun the last-used configuration; only prompt on
    -- the very first run. <Leader>dc keeps the always-ask picker for
    -- switching configurations (launch.json entries show up there too).
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<F5>"] = {
            function()
              local dap = require "dap"
              if dap.session() or not vim.g.dap_ran_once then
                dap.continue()
              else
                dap.run_last()
              end
            end,
            desc = "Debugger: Start (run last config)",
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      dap.listeners.after.event_initialized["f5_run_last"] = function() vim.g.dap_ran_once = true end
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter", -- on PATH via mason
          args = { "${port}" },
        },
      }
      for _, language in ipairs { "typescript", "javascript" } do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch current file (node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to running process (e.g. dev server)",
            processId = function() return require("dap.utils").pick_process() end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
