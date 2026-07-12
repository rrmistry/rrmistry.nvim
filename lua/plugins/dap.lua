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
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- VS Code launch.json files are JSONC; nvim-dap's reader is strict
      -- JSON. Strip comments (string-safe, via plenary) and trailing commas
      -- so per-project .vscode/launch.json entries load as-is.
      require("dap.ext.vscode").json_decode = function(str)
        str = require("plenary.json").json_strip_comments(str, {})
        str = str:gsub(",(%s*[%]}])", "%1") -- ponytail: naive on strings containing ",}"
        return vim.json.decode(str)
      end
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter", -- on PATH via mason
          args = { "${port}" },
        },
      }
      -- Generic "attach to debugpy in a container" for python, registered as
      -- a config provider so nvim-dap-python's own configs are untouched.
      -- Project-specific values belong in .vscode/launch.json (auto-read).
      dap.providers.configs["container_debugpy_attach"] = function(bufnr)
        if vim.bo[bufnr].filetype ~= "python" then return {} end
        return {
          {
            type = "python",
            request = "attach",
            name = "Attach to container (debugpy)",
            connect = {
              host = "127.0.0.1",
              port = function() return tonumber(vim.fn.input("debugpy port: ", "5678")) end,
            },
            pathMappings = {
              {
                localRoot = function() return vim.fn.input("Local source dir: ", vim.fn.getcwd(), "dir") end,
                remoteRoot = function() return vim.fn.input("Container source dir: ", "/app") end,
              },
            },
            justMyCode = false,
          },
        }
      end

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
