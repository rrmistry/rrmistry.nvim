-- Policy: Copilot is ON for every filetype by default (copilot.lua only
-- disables what's in its internal deny-list). We re-enable the useful
-- denied ones below; what stays off is deliberate: help pages, rebase
-- todo lists, legacy VCS commit buffers (hg/svn/cvs), no-filetype
-- buffers, and grug-far panels (denied by its community spec).
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
