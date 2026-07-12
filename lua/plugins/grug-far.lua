-- Project-wide search & replace with preview, like VS Code's search panel.
-- In-panel (localleader = ","): ,j apply match & go next · dd exclude match
-- · ,s apply all remaining · ,c close · g? help
-- Files Filter input: include globs (*.py, src/**); exclude with !pattern
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {
    windowCreationCommand = "enew", -- open in current window, not a vsplit
    -- folding = { foldlevel = 0 }, -- start files collapsed (VS Code tree feel)
  },
  keys = {
    {
      "<Leader>sr",
      function() require("grug-far").open() end,
      mode = { "n", "v" },
      desc = "Search & replace (project)",
    },
    {
      "<Leader>sw",
      function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
      desc = "Search & replace word under cursor",
    },
    {
      "<Leader>sb",
      function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,
      desc = "Search & replace in current file",
    },
  },
}
