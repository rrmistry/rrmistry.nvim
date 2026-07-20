-- Policy: Copilot is ON for every filetype by default (copilot.lua only
-- disables what's in its internal deny-list). We re-enable the useful
-- denied ones below; what stays off is deliberate: help pages, rebase
-- todo lists, legacy VCS commit buffers (hg/svn/cvs), no-filetype
-- buffers, and grug-far panels (denied by its community spec).
return {
  "zbirenbaum/copilot.lua",
  optional = true, -- merge-fragment: applies only via the community import
  opts = {
    -- never attach to secrets-bearing files: buffer content is never sent
    -- to GitHub for these. Replaces the default should_attach, so the
    -- buflisted/buftype checks are reproduced here.
    should_attach = function(bufnr, bufname)
      if not vim.bo[bufnr].buflisted or vim.bo[bufnr].buftype ~= "" then return false end
      local name = vim.fs.basename(bufname):lower()
      if
        name:match "^%.env" -- .env, .env.local, .env.production, ...
        or name:match "%.pem$"
        or name:match "%.key$"
        or name:match "^id_%w+$" -- ssh private keys (id_rsa, id_ed25519)
        -- ponytail: contains-matches may over-block (e.g. secrets_test.py);
        -- loosen here if a legitimate file gets denied
        or name:match "credential"
        or name:match "secret"
      then
        return false
      end
      return true
    end,
    filetypes = {
      markdown = true,
      yaml = true, -- docker-compose etc.
      gitcommit = true,
    },
  },
}
