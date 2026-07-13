-- Plugin + keymaps come from astrocommunity.search.grug-far-nvim (community.lua).
-- Single local override: open the panel in the current window, not a vsplit.
return {
  "MagicDuck/grug-far.nvim",
  optional = true, -- merge-fragment: applies only via the community import
  opts = { windowCreationCommand = "enew" },
}
