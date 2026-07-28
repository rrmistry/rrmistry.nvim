-- Direct spec (deliberate exception to community-imports-only): the
-- astrocommunity mini-diff spec disables gitsigns entirely, which would
-- destroy our hunk staging/blame/navigation stack. Here mini.diff is an
-- invisible companion — no signs, no mappings — used solely for its
-- buffer-local inline overlay (MiniDiff.toggle_overlay): word-level diff
-- rendered on the real buffer, same tab, no windows, nothing to desync.
return {
  "echasnovski/mini.diff",
  event = "User AstroGitFile",
  opts = {
    -- diff against HEAD (not the index): staged AND unstaged changes both
    -- show in the overlay, matching VS Code's source-control diff. For new
    -- (untracked) files `git show` fails and attach declines — handled by
    -- the caller with a notification.
    source = {
      name = "git-head",
      attach = function(buf_id)
        local path = vim.api.nvim_buf_get_name(buf_id)
        if path == "" or vim.bo[buf_id].buftype ~= "" then return false end
        -- async: process spawns are expensive on Windows (worse under
        -- corporate AV); never block buffer open on a git roundtrip
        vim.system(
          { "git", "-C", vim.fs.dirname(path), "show", "HEAD:./" .. vim.fs.basename(path) },
          { text = true },
          vim.schedule_wrap(function(res)
            if not vim.api.nvim_buf_is_valid(buf_id) then return end
            local md = require "mini.diff"
            if res.code == 0 then
              pcall(md.set_ref_text, buf_id, res.stdout)
            else
              pcall(md.disable, buf_id) -- untracked/new file: no reference
            end
          end)
        )
      end,
    },
    view = {
      style = "sign",
      signs = { add = "", change = "", delete = "" }, -- gitsigns owns the gutter
    },
    mappings = {
      apply = "",
      goto_first = "",
      goto_last = "",
      goto_next = "",
      goto_prev = "",
      reset = "",
      textobject = "",
    },
  },
}
