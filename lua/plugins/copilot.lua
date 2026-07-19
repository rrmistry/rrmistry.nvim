-- copilot.lua ships an internal deny-list that blocks markdown, yaml, and
-- gitcommit buffers; user-declared filetypes take precedence over it.
return {
  "zbirenbaum/copilot.lua",
  optional = true, -- merge-fragment: applies only via the community import
  opts = {
    filetypes = {
      markdown = true,
      yaml = true, -- docker-compose etc.
      gitcommit = true,
    },
  },
}
