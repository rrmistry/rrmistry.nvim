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
      { "0", description = "Go to beginning of line", mode = { "n", "v" } },
      { "^", description = "Go to first non-blank character of line", mode = { "n", "v" } },
      { "$", description = "Go to end of line", mode = { "n", "v" } },
      -- indent width follows 'shiftwidth', auto-inferred per file by guess-indent
      { ">>", description = "Indent current line" },
      { "<<", description = "Unindent current line" },
      { ">", description = "Indent selection", mode = { "v" } },
      { "<", description = "Unindent selection", mode = { "v" } },
      { "gv", description = "Reselect last selection (e.g. to indent again)" },
      { "<C-t>", description = "Indent current line (while typing)", mode = { "i" } },
      { "<C-d>", description = "Unindent current line (while typing)", mode = { "i" } },
      -- AstroNvim defaults
      { "<Leader>ff", description = "Open file (fuzzy search)" },
      { "<Leader>fw", description = "Search text in project" },
      { "<Leader>fo", description = "Open recent file" },
      { "<Leader>e", description = "Toggle file explorer" },
      { "<Leader>o", description = "Toggle focus: file tree ↔ editor" },
      { "<Leader>w", description = "Save file" },
      { "<Leader>c", description = "Close file (buffer)" },
      { "]b", description = "Next editor tab (buffer)" },
      { "[b", description = "Previous editor tab (buffer)" },
      { "<Leader>fb", description = "Switch between open files (fuzzy list of buffers)" },
      { "<Leader>bb", description = "Pick open file from tabline (tabs)" },
      { "<C-^>", description = "Toggle between last two files (like Ctrl+Tab)" },
      { "<Leader>/", description = "Toggle comment", mode = { "n", "v" } },
      { "<Leader>lf", description = "Format document" },
      { "<Leader>la", description = "Code actions" },
      { "<Leader>lS", description = "Symbols outline (document symbols sidebar)" },
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
      { "<Leader>us", description = "Toggle spell checking (dictionary-based)" },
      { "<Leader>ft", description = "Change color theme" },
      { "<Leader>gg", description = "Open lazygit (pull, push, stash, branch, merge)" },
      { "<Leader>gl", description = "Git blame current line" },
      { "<Leader>gL", description = "Git blame current line (full)" },
      { "<Leader>gs", description = "Stage / unstage git change (hunk)", mode = { "n", "v" } },
      { "<Leader>gr", description = "Undo git change (discard hunk)", mode = { "n", "v" } },
      { "<Leader>gS", description = "Stage all changes in file" },
      { "<Leader>gR", description = "Undo all git changes in file" },
      { "]g", description = "Jump to next git change in file" },
      { "[g", description = "Jump to previous git change in file" },
      { "]G", description = "Jump to last git change in file" },
      { "[G", description = "Jump to first git change in file" },
      -- custom (defined in copypath.lua / grug-far.lua)
      { "u", description = "Undo" },
      { "<C-r>", description = "Redo" },
      { "<Leader>q", description = "Quit window" },
      { "<Leader>Q", description = "Quit Neovim" },
      { "<Leader>yp", description = "Copy absolute path of file" },
      { "<Leader>yr", description = "Copy relative path of file" },
      { "<Leader>yn", description = "Copy filename" },
      { "<Leader>ss", description = "Search & replace in project (with preview)" },
      { "<Leader>sw", description = "Search & replace word under cursor" },
      { "<Leader>sf", description = "Search & replace in current file" },
      { "<Leader>se", description = "Search & replace in files of same type as current" },
      { "<Leader>s", description = "Search & replace selection", mode = { "v" } },
      -- grug-far panel actions: only shown in the palette while inside the
      -- panel (ft filter). "," is the localleader, matching grug-far defaults.
      { ",j", description = "Apply this match and go to next", filters = { ft = "grug-far" } },
      { ",k", description = "Apply this match and go to previous", filters = { ft = "grug-far" } },
      { ",l", description = "Apply this line only (keep in list)", filters = { ft = "grug-far" } },
      { "dd", description = "Exclude this match from apply-all", filters = { ft = "grug-far" } },
      { ",s", description = "Apply all remaining matches", filters = { ft = "grug-far" } },
      { ",r", description = "Replace all (ignores exclusions)", filters = { ft = "grug-far" } },
      { ",v", description = "Apply all matches in this file", filters = { ft = "grug-far" } },
      { ",q", description = "Send results to quickfix list", filters = { ft = "grug-far" } },
      { ",o", description = "Open match location", filters = { ft = "grug-far" } },
      { ",i", description = "Preview match location", filters = { ft = "grug-far" } },
      { ",b", description = "Abort running search/replace", filters = { ft = "grug-far" } },
      { ",c", description = "Close search & replace panel", filters = { ft = "grug-far" } },
      { "g?", description = "Show panel help", filters = { ft = "grug-far" } },
    },
    commands = {
      { ":enew", description = "New file (empty buffer in current window)" },
      { ":sort", description = "Sort lines ascending" },
      { ":sort u", description = "Sort lines & remove duplicates" },
      { ":setfiletype ", description = "Change language mode (set filetype)", unfinished = true },
      { ":GuessIndent", description = "Detect indentation from file" },
      { ":RenderMarkdown toggle", description = "Toggle markdown preview (in-editor)" },
      { ":Neotree position=current", description = "Open file tree full screen (in current window)" },
      { ":windo diffthis", description = "Compare visible splits (diff)" },
      { ":diffoff!", description = "Turn off diff view" },
      { ":Lazy sync", description = "Update plugins" },
      { ":Mason", description = "Manage language tools (LSP, formatters, linters)" },
      { ":GrugFar", description = "Find & replace across project" },
      { ":checkhealth", description = "Diagnose Neovim health" },
    },
    funcs = {
      -- real function, not fed keystrokes: works from inside the neo-tree
      -- window too, where <Space> (leader) is taken by toggle-folder
      {
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "focus"
          end
        end,
        description = "Switch focus between file tree and editor",
      },
      {
        function() require("dropbar.api").pick() end,
        description = "Breadcrumbs: pick path/symbol to jump to (like clicking VS Code breadcrumbs)",
      },
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
