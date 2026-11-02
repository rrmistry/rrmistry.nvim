-- VS Code-style insert-mode Ctrl+arrows, arbitrated with Windsurf ghost text.
--
-- <C-Right>: accept the next word of a visible suggestion, else jump to the
-- next word. <C-Left>: un-accept the last partially accepted word, else jump
-- to the previous word.
--
-- Un-accept cannot be a single undo: windsurf's accept keys route through
-- normal mode for range-replacing completions (Esc + deletes + re-insert),
-- splintering the change across undo blocks. Instead each accept snapshots
-- the line it rewrites plus a {changedtick, cursor} fingerprint; un-accept
-- restores the snapshot only while the fingerprint still matches, so typing
-- or moving in between can never be swallowed — C-Left then just navigates.
local M = {}

local function ghost()
  local ok, vt = pcall(require, "codeium.virtual_text")
  if ok and vt.get_current_completion_item() then return vt end
end

-- expr mapping: insert-mode <C-Right>
function M.word_right()
  local vt = ghost()
  if vt then
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.b.ai_accept_pre = { row = cur[1], col = cur[2], line = vim.api.nvim_get_current_line() }
    -- record() runs after the accept keys have been applied
    return vt.accept_next_word() .. "<Cmd>lua require('user_ctrl_nav').record()<CR>"
  end
  return "<C-o>w"
end

function M.record()
  local pre = vim.b.ai_accept_pre
  if not pre then return end
  vim.b.ai_accept_pre = nil
  local stack = vim.b.ai_accept_stack or {}
  table.insert(stack, {
    pre = pre,
    fin = vim.api.nvim_win_get_cursor(0),
    tick = vim.b.changedtick,
  })
  vim.b.ai_accept_stack = stack
end

local function unaccept_valid()
  local stack = vim.b.ai_accept_stack or {}
  local top = stack[#stack]
  if not top then return false end
  local cur = vim.api.nvim_win_get_cursor(0)
  return top.tick == vim.b.changedtick and top.fin[1] == cur[1] and top.fin[2] == cur[2]
end

-- expr mapping: insert-mode <C-Left>
function M.word_left()
  if unaccept_valid() then return "<Cmd>lua require('user_ctrl_nav').unaccept()<CR>" end
  return "<C-o>b"
end

function M.unaccept()
  if not unaccept_valid() then return end
  local stack = vim.b.ai_accept_stack
  local top = table.remove(stack)
  vim.b.ai_accept_stack = stack
  -- the accept only rewrote from its own line downward (multi-line inserts
  -- extend it); restore those rows to the single original line
  vim.api.nvim_buf_set_lines(0, top.pre.row - 1, top.fin[1], false, { top.pre.line })
  vim.api.nvim_win_set_cursor(0, { top.pre.row, top.pre.col })
end

return M
