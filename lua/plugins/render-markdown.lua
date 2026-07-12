-- In-terminal markdown preview: renders headings, tables, checkboxes and
-- code blocks inside the buffer itself, so it works over SSH/tmux/Termux
-- (no browser or port forwarding needed).
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  opts = {},
}
