-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- VS Code-style breadcrumbs under the tabline: relative file path plus
  -- symbol chain, clickable/pickable. Replaces AstroNvim's default winbar.
  { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
}
