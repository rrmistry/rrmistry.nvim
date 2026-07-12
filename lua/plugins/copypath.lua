-- VS Code "Copy Path" / "Copy Relative Path". Reaches the local clipboard
-- over SSH/tmux via Neovim's built-in OSC 52 support (auto-enabled on $SSH_TTY).
local function copy(expr)
  return function()
    local p = vim.fn.expand(expr)
    vim.fn.setreg("+", p)
    vim.notify("Copied: " .. p)
  end
end

return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<Leader>y"] = { desc = "Copy path" },
        ["<Leader>yp"] = { copy("%:p"), desc = "Copy absolute path" },
        ["<Leader>yr"] = { copy("%:."), desc = "Copy relative path" },
        ["<Leader>yn"] = { copy("%:t"), desc = "Copy filename" },
      },
    },
  },
}
