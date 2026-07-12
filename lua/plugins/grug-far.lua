-- Project-wide search & replace with preview, like VS Code's search panel.
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  opts = {},
  keys = {
    {
      "<Leader>sr",
      function() require("grug-far").open() end,
      mode = { "n", "v" },
      desc = "Search & replace (project)",
    },
  },
}
