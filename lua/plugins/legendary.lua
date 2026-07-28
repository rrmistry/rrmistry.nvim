-- VS Code-style command palette: Ctrl+P, then type plain English.
-- Three layers: curated plain-English entries below, a startup harvest of
-- the whole <Leader> tree, and a per-buffer harvest of local mappings on
-- palette open (see config + lua/user_legendary_palette.lua). Entries
-- without an implementation are "anonymous": they only add a searchable
-- label for an existing binding — nothing is rebound.

-- true while any diffview tab is open (diff windows keep each file's own
-- filetype, so entries for them need a context filter instead of `ft`)
local function in_diffview()
  local ok, lib = pcall(require, "diffview.lib")
  return ok and lib.get_current_view() ~= nil
end

-- true in ANY diff context: native vim diff windows (:Gitsigns diffthis,
-- :windo diffthis) as well as diffview tabs
local function in_diff_mode()
  if vim.wo.diff then return true end
  return in_diffview()
end

-- run a diffview command, closing any open diffview first so only one
-- diff tab ever exists (mirrors the sidebar gd behavior)
local function single_diffview(cmd)
  return function()
    local ok, lib = pcall(require, "diffview.lib")
    if ok then
      for _, view in ipairs(vim.list_slice(lib.views)) do
        view:close()
      end
    end
    vim.cmd(cmd)
  end
end

return {
  "mrjones2014/legendary.nvim",
  lazy = false,
  priority = 10000,
  opts = {
    -- VS Code-style rows: plain-English description first and dominant,
    -- the key/command as a subtle right-side hint
    default_item_formatter = function(item)
      local Toolbox = require "legendary.toolbox"
      local bind = ""
      if Toolbox.is_keymap(item) then
        bind = item.keys
      elseif Toolbox.is_command(item) then
        bind = item.cmd
      end
      return { item.description or "", bind }
    end,
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
      { "<Leader>uf", description = "Toggle format-on-save (this file)" },
      { "<Leader>uF", description = "Toggle format-on-save (all files)" },
      { "<Leader>la", description = "Code actions" },
      { "<Leader>lS", description = "Symbols outline (document symbols sidebar)" },
      { "<Leader>ls", description = "Go to symbol in file (VS Code @)" },
      { "<Leader>f'", description = "Browse bookmarks (marks) with preview" },
      { "m", description = "Set bookmark on line (press m then a letter, e.g. ma)" },
      { "'", description = "Jump to bookmark (press ' then the letter)" },
      { "mA", description = "Set cross-file bookmark A (capital letters work across files)" },
      { "'A", description = "Jump to cross-file bookmark A" },
      { "''", description = "Jump back to previous location (press again to toggle)" },
      { "`.", description = "Jump to last edit in this file" },
      { "g;", description = "Jump to previous edit location (change history)" },
      { "<C-o>", description = "Go back — previous cursor location (VS Code Alt+Left)" },
      { "<C-i>", description = "Go forward — next cursor location (VS Code Alt+Right)" },
      { "<Leader>lr", description = "Rename symbol" },
      { "gd", description = "Go to definition" },
      { "grr", description = "Find all references to symbol" },
      { "gri", description = "Go to implementation" },
      { "grt", description = "Go to type definition" },
      { "K", description = "Show hover docs" },
      { "]d", description = "Next problem (diagnostic) in file" },
      { "[d", description = "Previous problem (diagnostic) in file" },
      { "<Leader>ld", description = "Show problem details under cursor" },
      -- windows & splits
      { "\\", description = "Split editor down (horizontal split)" },
      { "|", description = "Split editor right (vertical split)" },
      { "<C-w>H", description = "Move window to far left" },
      { "<C-w>L", description = "Move window to far right" },
      { "<C-w>J", description = "Move window to bottom" },
      { "<C-w>K", description = "Move window to top" },
      { "<C-Up>", description = "Resize window taller" },
      { "<C-Down>", description = "Resize window shorter" },
      { "<C-Left>", description = "Resize window narrower" },
      { "<C-Right>", description = "Resize window wider" },
      { "<C-w>=", description = "Equalize all window sizes" },
      { "<C-w>o", description = "Close all other windows (keep current)" },
      { "<C-w>x", description = "Swap window with the next one" },
      { "<C-w>r", description = "Rotate windows" },
      { "<C-w>T", description = "Move window to its own workspace tab page" },
      { "<C-w>_", description = "Maximize window height" },
      { "<C-w>|", description = "Maximize window width" },
      { "<C-h>", description = "Go to left split / tmux pane" },
      { "<C-j>", description = "Go to below split / tmux pane" },
      { "<C-k>", description = "Go to above split / tmux pane" },
      { "<C-l>", description = "Go to right split / tmux pane" },
      -- buffers, i.e. open files ("editors" in VS Code)
      { "<Leader>bc", description = "Close other files (keep current)" },
      { "<Leader>bC", description = "Close all files" },
      { "<Leader>bl", description = "Close all files to the left (tabline)" },
      { "<Leader>br", description = "Close all files to the right (tabline)" },
      { "<b", description = "Move file tab left (reorder tabline)" },
      { ">b", description = "Move file tab right (reorder tabline)" },
      { "<Leader>b|", description = "Pick file from tabline into a vertical split" },
      { "<Leader>b\\", description = "Pick file from tabline into a horizontal split" },
      -- native tab pages = whole window layouts (closest VS Code analog:
      -- separate editor windows)
      { "gt", description = "Next workspace tab page (native tab)" },
      { "gT", description = "Previous workspace tab page (native tab)" },
      -- folds
      { "zM", description = "Fold all" },
      { "zR", description = "Unfold all" },
      { "za", description = "Toggle fold under cursor" },
      -- more VS Code habits
      { "d0", description = "Delete to start of line" },
      { "<Leader>uZ", description = "Toggle zen mode" },
      { "<Leader>us", description = "Toggle spell checking (dictionary-based)" },
      { "<Leader>uw", description = "Toggle soft wrap (this window only)" },
      { "<Leader>ft", description = "Change color theme" },
      { "<Leader>gg", description = "Open lazygit (pull, push, stash, branch, merge)" },
      { "<Leader>td", description = "Open lazydocker (containers, logs, exec, restart)" },
      -- terminal
      { "<F7>", description = "Toggle terminal" },
      { "<Leader>tf", description = "Open terminal (floating)" },
      { "<Leader>th", description = "Open terminal (horizontal split)" },
      { "<Leader>tv", description = "Open terminal (vertical split)" },
      -- AI: sidekick (Claude Code CLI + Copilot next-edit) and Copilot
      { "<Leader>Aa", description = "AI: toggle agent CLI terminal (current default provider)" },
      { "<Leader>As", description = "AI: select CLI tool (claude, ...)" },
      { "<Leader>At", description = "AI: send current line/selection to the CLI", mode = { "n", "v" } },
      { "<Leader>Af", description = "AI: send current file to the CLI" },
      { "<Leader>Ap", description = "AI: pick a prompt to send", mode = { "n", "v" } },
      { "<Leader>Ant", description = "AI: toggle Copilot next-edit suggestions (NES)" },
      { "<Leader>Anu", description = "AI: refresh next-edit suggestions" },
      { "<Leader>Ad", description = "AI: detach CLI session (keeps running in background)" },
      { "<C-.>", description = "AI: quick toggle CLI terminal (also while typing)" },
      { "<Tab>", description = "AI: go to / apply next edit suggestion (when shown)" },
      -- meta-discovery: the long tail beyond this curated palette
      { "<Leader>fC", description = "Run any command (fuzzy over ALL commands, even undescribed)" },
      { "<Leader>fk", description = "Search every keybinding (all keymaps)" },
      { "<Leader>gl", description = "Git blame current line" },
      { "<Leader>gL", description = "Git blame current line (full)" },
      { "<Leader>gt", description = "Git status: pick from changed files" },
      { "<Leader>gb", description = "Git branches: pick / switch" },
      { "<Leader>gc", description = "Git commit log (repository)" },
      { "<Leader>gC", description = "Git commit log (current file)" },
      { "<Leader>go", description = "Git browse: open current commit on remote" },
      { "<Leader>gd", description = "Git diff current file (side-by-side split)" },
      { "<Leader>gD", description = "Git diff current file against previous commit" },
      { "<Leader>gs", description = "Stage / unstage git change (hunk)", mode = { "n", "v" } },
      { "<Leader>gr", description = "Undo git change (discard hunk)", mode = { "n", "v" } },
      { "<Leader>gS", description = "Stage all changes in file" },
      { "<Leader>gR", description = "Undo all git changes in file" },
      { "]g", description = "Jump to next git change in file (staged or not)" },
      { "[g", description = "Jump to previous git change in file (staged or not)" },
      { "]G", description = "Jump to last git change in file (staged or not)" },
      { "[G", description = "Jump to first git change in file (staged or not)" },
      -- problems panel (trouble.nvim)
      { "<Leader>xx", description = "Problems panel: current file diagnostics" },
      { "<Leader>xX", description = "Problems panel: workspace diagnostics" },
      { "<Leader>xt", description = "Problems panel: TODOs / FIXMEs" },
      -- sticky scroll
      { "<Leader>uT", description = "Toggle sticky scroll (pinned def/class context)" },
      -- test runner (neotest)
      { "<Leader>Tt", description = "Run test under cursor" },
      { "<Leader>Tf", description = "Run all tests in file" },
      { "<Leader>Tp", description = "Run all tests in project" },
      { "<Leader>Td", description = "Debug test under cursor" },
      { "<Leader>To", description = "Show test output" },
      { "<Leader>T<CR>", description = "Toggle test summary sidebar" },
      -- task runner (overseer)
      { "<Leader>Mr", description = "Run task (reads .vscode/tasks.json)" },
      { "<Leader>Mt", description = "Toggle task runner panel" },
      -- surround (nvim-surround)
      { 'ysiw"', description = "Wrap word in quotes (surround)" },
      { "cs", description = 'Change surrounding quotes/brackets (e.g. cs"\')' },
      { "ds", description = 'Delete surrounding quotes/brackets (e.g. ds")' },
      { "S", description = 'Surround selection (then type " ( [ etc.)', mode = { "v" } },
      -- debugging (AstroNvim nvim-dap defaults; VS Code F-keys work too)
      { "<Leader>db", description = "Toggle breakpoint (F9)" },
      { "<Leader>dC", description = "Set conditional breakpoint" },
      { "<Leader>dB", description = "Clear all breakpoints" },
      { "<Leader>dc", description = "Debug: start / continue — picks configuration (F5)" },
      { "<Leader>do", description = "Debug: step over (F10)" },
      { "<Leader>di", description = "Debug: step into (F11)" },
      { "<Leader>dO", description = "Debug: step out" },
      { "<Leader>ds", description = "Debug: run to cursor" },
      { "<Leader>dp", description = "Debug: pause" },
      { "<Leader>dr", description = "Debug: restart" },
      { "<Leader>dq", description = "Debug: close session" },
      { "<Leader>dQ", description = "Debug: terminate session" },
      { "<Leader>du", description = "Toggle debugger UI (variables, stack, watches)" },
      { "<Leader>dR", description = "Debug: toggle REPL console" },
      { "<Leader>dh", description = "Debug: inspect variable under cursor" },
      { "<Leader>dE", description = "Debug: evaluate expression" },
      -- custom (defined in copypath.lua / grug-far.lua)
      { "u", description = "Undo" },
      { "<C-r>", description = "Redo" },
      -- registers & macros
      { "<Leader>fr", description = "Browse registers (yank / delete history)" },
      { '"0p', description = "Paste last yank (ignores deletes since)" },
      { "q", description = "Record macro into a register (press q again to stop)" },
      { "@", description = "Play macro from a register" },
      { "@@", description = "Repeat last played macro" },
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
      -- neo-tree Git tab actions (defaults are real but undiscoverable there)
      { "ga", description = "Git tab: stage file or folder (git add)", filters = { ft = "neo-tree" } },
      { "gu", description = "Git tab: unstage file or folder", filters = { ft = "neo-tree" } },
      { "gt", description = "Git tab: toggle file staged / unstaged", filters = { ft = "neo-tree" } },
      { "gr", description = "Git tab: discard changes to file or folder (git revert)", filters = { ft = "neo-tree" } },
      { "gd", description = "Sidebar: open diff view for file/folder under cursor", filters = { ft = "neo-tree" } },
      { "A", description = "Git tab: stage all files", filters = { ft = "neo-tree" } },
      { "gc", description = "Git tab: commit staged changes", filters = { ft = "neo-tree" } },
      { "gU", description = "Git tab: undo last commit (keep changes)", filters = { ft = "neo-tree" } },
      -- neo-tree sidebar actions (only shown while the sidebar is focused)
      { "]b", description = "Sidebar: next tab (File → Bufs → Git)", filters = { ft = "neo-tree" } },
      { "[b", description = "Sidebar: previous tab (Git → Bufs → File)", filters = { ft = "neo-tree" } },
      { "l", description = "Open file / expand folder", filters = { ft = "neo-tree" } },
      { "h", description = "Collapse folder / go to parent", filters = { ft = "neo-tree" } },
      { "?", description = "Show sidebar help (all tree actions)", filters = { ft = "neo-tree" } },
      { "a", description = "Sidebar: add new file (end with / for a folder)", filters = { ft = "neo-tree" } },
      { "d", description = "Sidebar: delete file/folder under cursor", filters = { ft = "neo-tree" } },
      { "r", description = "Sidebar: rename file/folder under cursor", filters = { ft = "neo-tree" } },
      { "c", description = "Sidebar: copy file/folder under cursor", filters = { ft = "neo-tree" } },
      { "m", description = "Sidebar: move file/folder under cursor", filters = { ft = "neo-tree" } },
      -- diffview file panel actions (only shown while the git panel is focused)
      { "s", description = "Stage / unstage file under cursor", filters = { ft = "DiffviewFiles" } },
      { "S", description = "Stage all files", filters = { ft = "DiffviewFiles" } },
      { "U", description = "Unstage all files", filters = { ft = "DiffviewFiles" } },
      { "X", description = "Discard changes to file (restore committed state)", filters = { ft = "DiffviewFiles" } },
      { "<CR>", description = "Open diff for selected file", filters = { ft = "DiffviewFiles" } },
      { "<C-l>", description = "Focus the diff windows (right of panel)", filters = { ft = "DiffviewFiles" } },
      { "L", description = "Show commit log", filters = { ft = "DiffviewFiles" } },
      -- diffview: focus & navigation (shown while a diffview tab is open;
      -- the RIGHT diff window is the real working file — edit it, :w saves)
      { "<Leader>e", description = "Git diff view: focus the file panel (sidebar)", filters = { in_diffview } },
      { "<Tab>", description = "Git diff view: open next file's diff", filters = { in_diffview } },
      { "<S-Tab>", description = "Git diff view: open previous file's diff", filters = { in_diffview } },
      { "gf", description = "Git diff view: open file for normal editing (leave diff)", filters = { in_diffview } },
      { "]c", description = "Jump to next change in diff", filters = { in_diff_mode } },
      { "[c", description = "Jump to previous change in diff", filters = { in_diff_mode } },
      { ":syncbind", description = "Re-sync side-by-side diff scrolling (after it drifts)" },
      { "do", description = "Take change from the other side (diff obtain)", filters = { in_diff_mode } },
      { "dp", description = "Push change to the other side (diff put)", filters = { in_diff_mode } },
      { "g<C-x>", description = "Cycle diff layout (side-by-side ↔ stacked)", filters = { in_diffview } },
      -- merge conflict resolution (diffview merge tool; acts on the
      -- conflict under the cursor, one at a time)
      { "]x", description = "Next merge conflict", filters = { in_diffview } },
      { "[x", description = "Previous merge conflict", filters = { in_diffview } },
      { "<Leader>co", description = "Conflict: accept current change (ours)", filters = { in_diffview } },
      { "<Leader>ct", description = "Conflict: accept incoming change (theirs)", filters = { in_diffview } },
      { "<Leader>cb", description = "Conflict: accept base version", filters = { in_diffview } },
      { "<Leader>ca", description = "Conflict: accept both changes", filters = { in_diffview } },
      { "dx", description = "Conflict: reject both (delete conflict region)", filters = { in_diffview } },
      { "g?", description = "Show git panel help", filters = { ft = "DiffviewFiles" } },
    },
    commands = {
      { ":enew", description = "New file (empty buffer in current window)" },
      { ":edit ", description = "Open file by exact path (paste relative or absolute)", unfinished = true },
      { ":", description = "Go to line: type the number and Enter (VS Code :42)", unfinished = true },
      { ":terminal", description = "Open terminal in current window (native)" },
      -- line duplication & movement (built-in :t / :m; adjust the offset
      -- for bigger jumps, e.g. :m+5 or :t-3)
      { ":t.", description = "Copy line down (duplicate below)" },
      { ":t-1", description = "Copy line up (duplicate above)" },
      { ":'<,'>t'>", description = "Copy selection down (duplicate below)" },
      { ":'<,'>t'<-1", description = "Copy selection up (duplicate above)" },
      { ":m+1", description = "Move line down (:m+2 for two lines, ...)" },
      { ":m-2", description = "Move line up (:m-3 for two lines, ...)" },
      { ":'<,'>m'>+1", description = "Move selection down ('>+2 for two lines, ...)" },
      { ":'<,'>m'<-2", description = "Move selection up ('<-3 for two lines, ...)" },
      { ":sort", description = "Sort lines ascending" },
      { ":sort u", description = "Sort lines & remove duplicates" },
      { ":setfiletype ", description = "Change language mode (set filetype)", unfinished = true },
      { ":GuessIndent", description = "Detect indentation from file" },
      { ":RenderMarkdown toggle", description = "Toggle markdown preview (in-editor)" },
      { ":Neotree position=current", description = "Open file tree full screen (in current window)" },
      -- git diffs (diffview.nvim; panel has "Changes" = unstaged vs staged,
      -- "Staged changes" = staged vs committed). View-openers live in
      -- `funcs` below so they reuse a single diff tab.
      { ":DiffviewToggleFiles", description = "Toggle git changes panel (staged & unstaged as separate trees)" },
      { ":DiffviewOpen ", description = "Compare git refs in tree view: main..feature, HEAD~3, a tag, ...", unfinished = true },
      { ":CodeDiff", description = "VS Code-style diff explorer of all changes (t = inline/split, - = stage, q = quit)" },
      { ":CodeDiff ", description = "VS Code-style diff vs a ref (e.g. main, HEAD~5, a commit)", unfinished = true },
      { ":DiffviewFileHistory ", description = "Git history of a path or ref range (e.g. src/ or main..feature)", unfinished = true },
      { ":DiffviewFocusFiles", description = "Focus git changes panel" },
      { ":Neotree git_status", description = "Sidebar: open Git tab (changed files tree)" },
      { ":Neotree buffers", description = "Sidebar: open Bufs tab (open files tree)" },
      { ":Neotree filesystem", description = "Sidebar: open File tab (file explorer)" },
      { ":DiffviewClose", description = "Close git diff view" },
      { ':!git commit -m "', description = "Commit staged changes: type message and closing quote", unfinished = true },
      { ":!git commit --amend --no-edit", description = "Amend last commit (keep message)" },
      { ":!git push", description = "Git push to upstream" },
      { ":!git pull", description = "Git pull from upstream" },
      { ":windo diffthis", description = "Compare visible splits (diff)" },
      { ":registers", description = "Show contents of all registers" },
      { ":delmarks!", description = "Delete all bookmarks in this file (a-z)" },
      { ":delmarks ", description = "Delete specific bookmark(s), e.g. a b c", unfinished = true },
      { ":tabnew", description = "New workspace tab page (separate window layout)" },
      { ":tabclose", description = "Close workspace tab page" },
      { ":tabonly", description = "Close all other workspace tab pages" },
      { ":diffoff!", description = "Turn off diff view" },
      { ":Lazy sync", description = "Update plugins" },
      { ":Mason", description = "Manage language tools (LSP, formatters, linters)" },
      { ":GrugFar", description = "Find & replace across project" },
      { ":checkhealth", description = "Diagnose Neovim health" },
      { ":Copilot auth", description = "Copilot: sign in with GitHub (one-time)" },
      { ":Copilot status", description = "Copilot: connection status" },
      { ":Copilot disable", description = "Copilot: pause completions" },
      { ":Copilot enable", description = "Copilot: resume completions" },
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
        single_diffview "DiffviewOpen",
        description = "Git changes: tree with unstaged & staged diffs (like VS Code)",
      },
      {
        single_diffview "DiffviewOpen -- %",
        description = "Diff current file (unstaged & staged sections)",
      },
      {
        single_diffview "DiffviewFileHistory %",
        description = "Git history of current file (diff per commit)",
      },
      {
        function()
          local md = require "mini.diff"
          local buf = vim.api.nvim_get_current_buf()
          if not md.get_buf_data(buf) then pcall(md.enable, buf) end
          if not md.get_buf_data(buf) then
            vim.notify("No committed version to diff against", vim.log.levels.INFO)
            return
          end
          md.toggle_overlay(buf)
        end,
        description = "Toggle inline diff view in this buffer (overlay)",
      },
      {
        function() require("snacks").rename.rename_file() end,
        description = "Rename / move current file (updates imports via LSP)",
      },
      {
        function()
          local file = vim.api.nvim_buf_get_name(0)
          if file == "" or vim.fn.filereadable(file) == 0 then
            return vim.notify("No file on disk for this buffer", vim.log.levels.WARN)
          end
          vim.ui.select({ "No", "Yes" }, {
            prompt = "Delete " .. vim.fn.fnamemodify(file, ":.") .. "?",
          }, function(choice)
            if choice ~= "Yes" then return end
            vim.fn.delete(file)
            require("snacks").bufdelete()
            vim.notify("Deleted " .. vim.fn.fnamemodify(file, ":t"))
          end)
        end,
        description = "Delete current file (asks first)",
      },
      {
        function()
          local file = vim.api.nvim_buf_get_name(0)
          if file == "" or vim.fn.filereadable(file) == 0 then
            return vim.notify("No file on disk for this buffer", vim.log.levels.WARN)
          end
          vim.ui.input({ prompt = "Copy to: ", default = file, completion = "file" }, function(dest)
            if not dest or dest == "" or dest == file then return end
            if vim.uv.fs_copyfile(file, dest) then
              vim.cmd.edit(dest)
              vim.notify("Copied to " .. vim.fn.fnamemodify(dest, ":."))
            else
              vim.notify("Copy failed", vim.log.levels.ERROR)
            end
          end)
        end,
        description = "Copy / duplicate current file (prompts for new path)",
      },
      {
        function() require("snacks").gitbrowse { what = "branch" } end,
        description = "Git: open repo on remote (current branch, in browser)",
      },
      {
        function() require("snacks").gitbrowse { what = "file" } end,
        description = "Git: open file on remote (current branch & line, in browser)",
      },
      {
        function() require("snacks").picker.lsp_workspace_symbols() end,
        description = "Go to symbol in workspace (VS Code #)",
      },
      {
        function() require("snacks").picker() end,
        description = "Open any picker (files, symbols, grep, undo, marks, ...)",
      },
      {
        function()
          local cfg = require "sidekick.config"
          local ok, resolved = pcall(function() return cfg.tools() end) -- public API
          local tools = {}
          for name in pairs(ok and resolved or cfg.cli.tools or {}) do
            table.insert(tools, name)
          end
          table.sort(tools)
          vim.ui.select(tools, { prompt = "Default agent CLI provider:" }, function(choice)
            if choice then
              vim.g.ai_cli = choice
              vim.notify("Default agent CLI: " .. choice .. " (this session)")
            end
          end)
        end,
        description = "AI: choose default CLI provider (claude, gemini, opencode, ...)",
      },
      {
        function()
          local new = not vim.o.wrap
          vim.o.wrap = new
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            vim.wo[win].wrap = new
          end
          vim.notify("Soft wrap " .. (new and "enabled" or "disabled") .. " globally (this session)")
        end,
        description = "Toggle soft wrap globally (all windows + new buffers)",
      },
      {
        function()
          if vim.o.mouse == "" then
            vim.o.mouse = "nvi"
            vim.notify "Mouse enabled"
          else
            vim.o.mouse = ""
            vim.notify "Mouse disabled (terminal-native selection)"
          end
        end,
        description = "Toggle mouse support on / off",
      },
    },
  },
  keys = {
    -- Both bound: Ctrl+Shift+P for VS Code muscle memory (needs extended-keys
    -- support end to end), plain Ctrl+P for keyboards without Shift chords
    -- (e.g. Termux) and terminals that collapse C-S-p into C-p anyway.
    -- Opening first harvests this buffer's LOCAL leader mappings (LSP and
    -- panel buffers carry their own), scoped to this buffer via filter.
    {
      "<C-p>",
      function() require("user_legendary_palette").open() end,
      desc = "Command palette",
      mode = { "n", "v" },
    },
    {
      "<C-S-p>",
      function() require("user_legendary_palette").open() end,
      desc = "Command palette",
      mode = { "n", "v" },
    },
  },
  config = function(_, opts)
    require("legendary").setup(opts)
    -- Harvest the entire <Leader> tree (every described mapping, any depth)
    -- into the palette as anonymous entries, so nothing bound under the
    -- leader is ever undiscoverable. Runs after startup so astrocore and
    -- plugin mappings all exist. Curated entries above stay as the
    -- plain-English layer; harvested ones add the stock vocabulary.
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      once = true,
      callback = function()
        vim.defer_fn(function()
          local leader = vim.g.mapleader or " "
          local items = {}
          for _, mode in ipairs { "n", "v" } do
            for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
              if m.desc and m.desc ~= "" and vim.startswith(m.lhs, leader) and #m.lhs > #leader then
                local lhs = "<Leader>" .. m.lhs:sub(#leader + 1)
                table.insert(items, { lhs, description = m.desc, mode = { mode } })
              end
            end
          end
          require("legendary").keymaps(items)
        end, 500)
      end,
    })
  end,
}
