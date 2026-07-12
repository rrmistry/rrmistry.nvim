-- Pickers opened via vim.ui.select (e.g. the command palette) start
-- focused on the input in insert mode — type immediately, no "i" needed.
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        select = {
          focus = "input",
          on_show = function() vim.cmd.startinsert() end,
          -- rank previously-picked items higher while typing, so e.g.
          -- "tab" learns to surface the buffer entries you actually use
          -- above built-in tab-page commands
          matcher = { frecency = true },
        },
      },
    },
  },
}
