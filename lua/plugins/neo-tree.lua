-- Sidebar git extras. Neo-tree's built-ins already cover the rest:
-- ga/gu/gr stage/unstage/discard work on FILE AND FOLDER nodes (git
-- pathspec), A stages all, gc commits, gp pushes. Enter/double-click
-- keep the default open behavior; for diffs use gd (diffview tree) or
-- the palette's "Toggle inline diff view" on the opened buffer.
return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    commands = {
      -- open the node under the cursor in diffview (staged & unstaged trees);
      -- close any existing diffview first so only one diff tab ever exists
      diffview_node = function(state)
        local node = state.tree:get_node()
        local ok, lib = pcall(require, "diffview.lib")
        if ok then
          for _, view in ipairs(vim.list_slice(lib.views)) do
            view:close()
          end
        end
        vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(node:get_id()))
      end,
    },
    window = {
      mappings = {
        ["gd"] = "diffview_node",
        -- AstroNvim's ["<Space>"] = false no longer disables neo-tree's
        -- default <space>=toggle_node (current neo-tree needs "none" on the
        -- lowercase key). Without this, Space in the sidebar folds folders
        -- instead of acting as the leader key (<Space>ff etc.).
        ["<space>"] = "none",
      },
    },
  },
}
