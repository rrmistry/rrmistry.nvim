-- Palette opener that first harvests the current buffer's LOCAL leader
-- mappings (LSP attaches, panel buffers, etc. define per-buffer menus the
-- global startup harvest can't see). Each harvested entry is filtered to
-- the buffer it came from, so context menus stay contextual.
local M = {}

function M.open()
  local buf = vim.api.nvim_get_current_buf()
  if not vim.b[buf].legendary_harvested then
    vim.b[buf].legendary_harvested = true
    local leader = vim.g.mapleader or " "
    local items = {}
    for _, mode in ipairs { "n", "v" } do
      for _, m in ipairs(vim.api.nvim_buf_get_keymap(buf, mode)) do
        if m.desc and m.desc ~= "" and vim.startswith(m.lhs, leader) and #m.lhs > #leader then
          table.insert(items, {
            "<Leader>" .. m.lhs:sub(#leader + 1),
            description = m.desc,
            mode = { mode },
            filters = {
              function() return vim.api.nvim_get_current_buf() == buf end,
            },
          })
        end
      end
    end
    if #items > 0 then require("legendary").keymaps(items) end
  end
  vim.cmd "Legendary"
end

return M
