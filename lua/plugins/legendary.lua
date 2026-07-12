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
      { ":Lazy sync", description = "Update plugins" },
      { ":Mason", description = "Manage language tools (LSP, formatters, linters)" },
      { ":GrugFar", description = "Find & replace across project" },
      { ":checkhealth", description = "Diagnose Neovim health" },
    },
  },
  keys = {
    -- Needs extended-keys support end to end (terminal emulator + tmux
    -- extended-keys on); without it the terminal sends plain Ctrl+P and
    -- this never fires — fall back to :Legendary.
    { "<C-S-p>", "<Cmd>Legendary<CR>", desc = "Command palette", mode = { "n", "v" } },
  },
}
