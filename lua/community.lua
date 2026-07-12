-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- VS Code-style breadcrumbs under the tabline: relative file path plus
  -- symbol chain, clickable/pickable. Replaces AstroNvim's default winbar.
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
  -- Language packs: LSP + treesitter + formatters auto-install via Mason on
  -- first launch, so a fresh `git clone` needs no hand-installed servers.
  { import = "astrocommunity.pack.python" }, -- basedpyright, black, isort, debugpy
  { import = "astrocommunity.pack.typescript" }, -- vtsls (VS Code's TS server), prettier
  { import = "astrocommunity.pack.astro" }, -- Astro.js: astro-language-server + parser
}
