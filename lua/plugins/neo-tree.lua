-- Sidebar git extras. Everything else is already built into neo-tree's
-- git_status source: ga/gu/gr stage/unstage/discard work on FILE AND
-- FOLDER nodes (git pathspec), A stages all, gc commits, gp pushes.
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
      },
    },
  },
}
