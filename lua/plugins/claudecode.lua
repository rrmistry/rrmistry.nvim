-- Claude Code IDE integration: coder/claudecode.nvim speaks the same
-- WebSocket/MCP protocol as the official VS Code extension, so a `claude`
-- CLI can attach to THIS nvim via /ide — it then sees the current file and
-- selection live, opens files in the editor, and proposes edits as native
-- diff views (accept with :w, reject with :q).
--
-- Direct spec by exception: astrocommunity has no claudecode entry
-- (checked upstream 2026-08). snacks.nvim already ships with AstroNvim.
return {
  "coder/claudecode.nvim",
  -- eager: the WebSocket server + ~/.claude/ide/<port>.lock discovery file
  -- must exist BEFORE an external `claude` (tmux window) runs /ide. A
  -- keys/cmd-lazy spec would leave /ide finding nothing.
  lazy = false,
  opts = {
    -- Claude runs outside nvim (tmux window) or in sidekick's terminal
    -- (<Leader>Aa); claudecode manages no terminal of its own. Flip to
    -- "auto" if a claudecode-managed split is ever wanted.
    terminal = { provider = "none" },
  },
}
