-- ~/.config/nvim/init.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic Vim options
vim.g.mapleader = " " -- Set leader key to space
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.showmode = false -- Don't show mode (lualine will show it)

  -- Requires wl-clipboard (in Alpine linux) or xclip (in Debian linux) installed to work
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard

vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- But case sensitive when uppercase present
vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence
vim.opt.splitright = true -- Force splits to open on the right
vim.opt.splitbelow = true -- Force splits to open below

-- Move between windows easily
vim.keymap.set('n', '<C-h>', '<C-w>h') -- Move to left window
vim.keymap.set('n', '<C-j>', '<C-w>j') -- Move to bottom window
vim.keymap.set('n', '<C-k>', '<C-w>k') -- Move to top window
vim.keymap.set('n', '<C-l>', '<C-w>l') -- Move to right window

-- Resize windows
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')

-- Split creation (similar to VS Code)
vim.keymap.set('n', '<leader>v', ':vsplit<CR>') -- Vertical split
vim.keymap.set('n', '<leader>h', ':split<CR>')  -- Horizontal split

-- Whitespace rendering settings
vim.opt.list = true -- Enable list mode for whitespace rendering
vim.opt.listchars = {
    space = '·',
    tab = '→ ',    -- Tab character
    trail = '·',   -- Trailing spaces
    extends = '⟩',  -- Character shown when line continues right
    precedes = '⟨', -- Character shown when line continues left
    nbsp = '␣',    -- Non-breaking space
    eol = '↴',     -- End of line character
}

-- Initialize lazy.nvim
require("lazy").setup({
  -- Color scheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Key mapping to toggle
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>')

      -- Configure Neo-tree
      require('neo-tree').setup({
        window = {
          position = "left",
          width = 30,
        },
      })

      -- Open Neo-tree on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.cmd("Neotree show")
        end
      })
    end
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
      })
    end
  },

  -- LSP Support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {'lua_ls'},
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })
    end
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "javascript", "typescript", "python" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Which-key for command palette
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        win = {  -- Changed from 'window' to 'win'
          border = "single",
        },
      })
    end,
  },

  -- Bufferline for tab-like interface
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
        },
      })
      -- Navigate buffers using Tab and Shift-Tab
      vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
      vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')
    end,
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})
          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})
        end
      })
    end,
  },

  -- Neogit: Magit-like Git interface
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',         -- Lua utility functions
      'sindrets/diffview.nvim',         -- Diff view integration
      'nvim-telescope/telescope.nvim',  -- Optional: for enhanced UI
    },
    config = function()
      local neogit = require('neogit')
      
      neogit.setup {
        -- Customize Neogit settings
        disable_signs = false,
        kind = "tab",  -- Open in a new tab
        signs = {
          -- Customize git signs
          section = { "▸", "▾" },
          item = { "▸", "▾" },
        },
        -- Integrations
        integrations = {
          diffview = true
        }
      }

      -- Key mappings
      vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open Neogit' })
      vim.keymap.set('n', '<leader>gc', function() 
        neogit.open({ "commit" }) 
      end, { desc = 'Open Neogit Commit' })
    end
  },

  -- Diffview: Enhanced diff view
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local diffview = require('diffview')
      
      diffview.setup {
        view = {
          -- Customize diff view layout
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            layout = "diff3_horizontal",
          }
        },
        file_panel = {
          listing_style = "tree",  -- Tree-view of changed files
          win_config = {
            position = "left",
            width = 35
          }
        }
      }

      -- Key mappings for Diffview
      vim.keymap.set('n', '<leader>dv', ':DiffviewOpen<CR>', { desc = 'Open Diffview' })
      vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
      vim.keymap.set('n', '<leader>dh', ':DiffviewFileHistory<CR>', { desc = 'File History' })
    end
  },

  -- Terminal integration
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      })
    end,
  },

  -- Auto pairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },

  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
        },
      })
    end,
  },

  -- window management
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      -- Enable navigation between tmux and vim
      vim.g.tmux_navigator_save_on_switch = 2
    end
  },

  -- Codeium
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
})

