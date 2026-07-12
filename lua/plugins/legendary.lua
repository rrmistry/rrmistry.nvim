-- VS Code-style command palette: <Space>P, then type plain English.
-- Curated entries only (no auto-registration) to avoid duplicate cryptic items.
-- Entries without an implementation are "anonymous": they only add a searchable
-- label for an existing binding — nothing is rebound.
return {
  "mrjones2014/legendary.nvim",
  lazy = false,
  priority = 10000,
  opts = {
    keymaps = {
      -- core vim, in VS Code vocabulary
      { "y", description = "Copy selection to clipboard", mode = { "v" } },
      { "p", description = "Paste from clipboard", mode = { "n", "v" } },
      { "U", description = "UPPERCASE selection", mode = { "v" } },
      { "u", description = "lowercase selection", mode = { "v" } },
      { "~", description = "Toggle case of selection", mode = { "v" } },
      { "gUiw", description = "UPPERCASE word under cursor" },
      -- AstroNvim defaults
      { "<Leader>ff", description = "Open file (fuzzy search)" },
      { "<Leader>fw", description = "Search text in project" },
      { "<Leader>fo", description = "Open recent file" },
      { "<Leader>e", description = "Toggle file explorer" },
      { "<Leader>w", description = "Save file" },
      { "<Leader>c", description = "Close file (buffer)" },
      { "]b", description = "Next editor tab (buffer)" },
      { "[b", description = "Previous editor tab (buffer)" },
      { "<Leader>/", description = "Toggle comment", mode = { "n", "v" } },
      { "<Leader>lf", description = "Format document" },
      { "<Leader>la", description = "Code actions" },
      { "<Leader>lr", description = "Rename symbol" },
      { "gd", description = "Go to definition" },
      { "K", description = "Show hover docs" },
      -- windows & splits
      { "\\", description = "Split editor down (horizontal split)" },
      { "|", description = "Split editor right (vertical split)" },
      { "<C-w>H", description = "Move window to far left" },
      { "<C-w>L", description = "Move window to far right" },
      { "<C-w>J", description = "Move window to bottom" },
      { "<C-w>K", description = "Move window to top" },
      { "<C-h>", description = "Go to left split" },
      { "<C-j>", description = "Go to below split" },
      { "<C-k>", description = "Go to above split" },
      { "<C-l>", description = "Go to right split" },
      -- buffers, i.e. open files ("editors" in VS Code)
      { "<Leader>bc", description = "Close other files (keep current)" },
      { "<Leader>bC", description = "Close all files" },
      -- folds
      { "zM", description = "Fold all" },
      { "zR", description = "Unfold all" },
      { "za", description = "Toggle fold under cursor" },
      -- more VS Code habits
      { "d0", description = "Delete to start of line" },
      { "<Leader>uZ", description = "Toggle zen mode" },
      { "<Leader>ft", description = "Change color theme" },
      { "<Leader>gg", description = "Open lazygit (pull, push, stash, branch, merge)" },
      { "<Leader>gl", description = "Git blame current line" },
      { "<Leader>gL", description = "Git blame current line (full)" },
      -- custom (defined in copypath.lua / grug-far.lua)
      { "u", description = "Undo" },
      { "<C-r>", description = "Redo" },
      { "<Leader>q", description = "Quit window" },
      { "<Leader>Q", description = "Quit Neovim" },
      { "<Leader>yp", description = "Copy absolute path of file" },
      { "<Leader>yr", description = "Copy relative path of file" },
      { "<Leader>yn", description = "Copy filename" },
      { "<Leader>sr", description = "Search & replace in project (with preview)", mode = { "n", "v" } },
    },
    commands = {
      { ":enew", description = "New file (empty buffer in current window)" },
      { ":sort", description = "Sort lines ascending" },
      { ":sort u", description = "Sort lines & remove duplicates" },
      { ":setfiletype ", description = "Change language mode (set filetype)", unfinished = true },
      { ":GuessIndent", description = "Detect indentation from file" },
      { ":windo diffthis", description = "Compare visible splits (diff)" },
      { ":diffoff!", description = "Turn off diff view" },
      { ":Lazy sync", description = "Update plugins" },
      { ":Mason", description = "Manage language tools (LSP, formatters, linters)" },
      { ":GrugFar", description = "Find & replace across project" },
      { ":checkhealth", description = "Diagnose Neovim health" },
    },
  },
  keys = {
    -- Both bound: Ctrl+Shift+P for VS Code muscle memory (needs extended-keys
    -- support end to end), plain Ctrl+P for keyboards without Shift chords
    -- (e.g. Termux) and terminals that collapse C-S-p into C-p anyway.
    { "<C-p>", "<Cmd>Legendary<CR>", desc = "Command palette", mode = { "n", "v" } },
    { "<C-S-p>", "<Cmd>Legendary<CR>", desc = "Command palette", mode = { "n", "v" } },
  },
}
