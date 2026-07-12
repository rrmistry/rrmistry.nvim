---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      -- compile parsers for new languages on first open; language packs in
      -- community.lua ensure the core ones (needs tree-sitter-cli, in mason.lua)
      auto_install = true,
    },
  },
}
