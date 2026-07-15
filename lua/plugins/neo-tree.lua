-- Sidebar git extras. Everything else is already built into neo-tree's
-- git_status source: ga/gu/gr stage/unstage/discard work on FILE AND
-- FOLDER nodes (git pathspec), A stages all, gc commits, gp pushes.
return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    commands = {
      -- open the node under the cursor in diffview (staged & unstaged trees)
      diffview_node = function(state)
        local node = state.tree:get_node()
        vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(node:get_id()))
      end,
    },
    window = {
      mappings = {
        ["gd"] = "diffview_node",
      },
    },
  },
}
