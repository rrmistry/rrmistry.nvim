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
        -- Upstream neo-tree bug (setup/init.lua: vim.tbl_get called with a
        -- list instead of varargs, so key normalization no-ops): AstroNvim's
        -- ["<Space>"] = false never merges over the default lowercase
        -- <space>=toggle_node. Disable it on the exact default key so Space
        -- acts as the leader in the sidebar (<Space>ff etc.).
        -- Remove once fixed upstream (introduced in neo-tree PR #1788).
        ["<space>"] = "none",
      },
    },
  },
}
