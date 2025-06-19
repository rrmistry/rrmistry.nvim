-- ~/.config/nvim/init.lua

-- ASCII-only mode configuration (no Nerd Fonts required)
local icons = {
  folder_closed = "[+]",
  folder_open = "[-]",
  folder_empty = "[.]",
  git_add = "|",
  git_change = "|",
  git_delete = "_",
  git_topdelete = "^",
  git_changedelete = "~",
  git_untracked = "?",
  git_ignored = "!",
  git_staged = "S",
  git_conflict = "C",
  section_open = "v",
  section_closed = ">",
  modified = "[+]",
}

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
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = 'Horizontal Split' })

-- Additional useful keymaps
vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>/', '<cmd>Telescope live_grep<cr>', { desc = 'Search in Files' })
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent Files' })
vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<cr>', { desc = 'Search Buffers' })
vim.keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics<cr>', { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', '<cmd>Telescope resume<cr>', { desc = 'Resume Last Search' })
vim.keymap.set('n', '<leader>w', '<C-w>', { desc = 'Window Commands' })

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

  -- File explorer (neo-tree - modern VS Code-like)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Key mapping to toggle
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle File Explorer' })
      vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { desc = 'Focus File Explorer' })
      vim.keymap.set('n', '<leader>gs', ':Neotree git_status<CR>', { desc = 'Git Status' })

      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
          },
          icon = {
            folder_closed = icons.folder_closed,
            folder_open = icons.folder_open,
            folder_empty = icons.folder_empty,
            default = "○",
          },
          modified = {
            symbol = icons.modified,
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              added     = "+",
              modified  = "M",
              deleted   = "-",
              renamed   = "R",
              untracked = "?",
              ignored   = "!",
              unstaged  = "U",
              staged    = "S",
              conflict  = "C",
            }
          },
        },
        window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = "noop", -- Disable space to allow leader key functionality
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "toggle_node", -- Enter opens/closes folders and files
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { 
              "add",
              config = {
                show_path = "none"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = true,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            }
          }
        }
      })

      -- Auto open on startup without focus
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          require("neo-tree.command").execute({ action = "show" })
        end
      })
    end
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
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
      {'hrsh7th/cmp-cmdline'},

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
        ensure_installed = {'lua_ls', 'dockerls', 'docker_compose_language_service', 'yamlls', 'jsonls'},
        handlers = {
          lsp_zero.default_setup,
        },
      })

      -- Setup nvim-cmp for command line
      local cmp = require('cmp')
      
      -- Command line completion
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- Search completion
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
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
        ensure_installed = { "lua", "vim", "javascript", "typescript", "python", "dockerfile", "yaml", "json", "bash" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Which-key for command palette
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require("which-key")
      
      wk.setup({
        win = {
          border = "single",
        },
      })

      -- Register key groups (which-key v3 format)
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LazyGit" },
        { "<leader>n", group = "Neogit" },
        { "<leader>d", group = "Diff/Debug/Docker" },
        { "<leader>dc", group = "Docker Container" },
        { "<leader>dv", group = "Docker Volume" },
        { "<leader>dn", group = "Docker Network" },
        { "<leader>s", group = "Search" },
        { "<leader>w", group = "Window" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
        { "<leader>t", group = "Terminal/Toggle" },
      })
    end,
  },

  -- Bufferline for tab-like interface
  {
    'akinsho/bufferline.nvim',
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          always_show_bufferline = false,
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = false,
          -- Enable tab wrapping
          show_tab_indicators = true,
          tab_size = 18,
          max_name_length = 30,
          max_prefix_length = 15,
          truncate_names = true,
          -- Custom close icon (ASCII)
          buffer_close_icon = 'x',
          close_icon = 'X',
          left_trunc_marker = '<',
          right_trunc_marker = '>',
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true,
            }
          },
        },
      })
      -- Navigate buffers
      vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
      vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')
      vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close Buffer' })
      vim.keymap.set('n', '<leader>X', ':bdelete!<CR>', { desc = 'Force Close Buffer' })
      
      -- Additional buffer navigation shortcuts
      vim.keymap.set('n', '<leader>bp', ':BufferLineCyclePrev<CR>', { desc = 'Previous Buffer' })
      vim.keymap.set('n', '<leader>bn', ':BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
      vim.keymap.set('n', '<leader>bh', ':BufferLineCloseLeft<CR>', { desc = 'Close Buffers to Left' })
      vim.keymap.set('n', '<leader>bl', ':BufferLineCloseRight<CR>', { desc = 'Close Buffers to Right' })
      vim.keymap.set('n', '<leader>bo', ':BufferLineCloseOthers<CR>', { desc = 'Close Other Buffers' })
      vim.keymap.set('n', '<leader>bc', ':BufferLinePickClose<CR>', { desc = 'Pick Buffer to Close' })
      vim.keymap.set('n', '<leader>bb', ':BufferLinePick<CR>', { desc = 'Pick Buffer' })
    end,
  },

  -- Git integration
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = icons.git_add },
          change = { text = icons.git_change },
          delete = { text = icons.git_delete },
          topdelete = { text = icons.git_topdelete },
          changedelete = { text = icons.git_changedelete },
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

  -- Lazygit integration
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', { desc = 'Open LazyGit' })
      vim.keymap.set('n', '<leader>lf', ':LazyGitFilter<CR>', { desc = 'LazyGit Filter' })
      vim.keymap.set('n', '<leader>lc', ':LazyGitFilterCurrentFile<CR>', { desc = 'LazyGit Current File' })
    end,
  },

  -- Fugitive: Vim's premier Git integration
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git Status' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git Blame' })
      vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = 'Git Diff Split' })
      vim.keymap.set('n', '<leader>gh', ':0Gclog<CR>', { desc = 'Git History' })
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
        kind = "split",  -- Open in a split
        signs = {
          -- Customize git signs
          section = { icons.section_closed, icons.section_open },
          item = { icons.section_closed, icons.section_open },
          hunk = { "-", "+" },
        },
        -- Integrations
        integrations = {
          diffview = true,
          telescope = true,
        },
      }

      -- Key mappings
      vim.keymap.set('n', '<leader>ng', neogit.open, { desc = 'Open Neogit' })
      vim.keymap.set('n', '<leader>nc', function() 
        neogit.open({ "commit" }) 
      end, { desc = 'Neogit Commit' })
      vim.keymap.set('n', '<leader>np', function()
        neogit.open({ "push" })
      end, { desc = 'Neogit Push' })
      vim.keymap.set('n', '<leader>nl', function()
        neogit.open({ "pull" })
      end, { desc = 'Neogit Pull' })
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
      
      -- Window navigation keybindings
      -- Quick window switching with Alt/Option key
      vim.keymap.set('n', '<M-h>', '<C-w>h', { desc = 'Navigate to left window' })
      vim.keymap.set('n', '<M-j>', '<C-w>j', { desc = 'Navigate to window below' })
      vim.keymap.set('n', '<M-k>', '<C-w>k', { desc = 'Navigate to window above' })
      vim.keymap.set('n', '<M-l>', '<C-w>l', { desc = 'Navigate to right window' })
      
      -- Window navigation with leader key
      vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Go to left window' })
      vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Go to window below' })
      vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Go to window above' })
      vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Go to right window' })
      
      -- Window splitting
      vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Split window horizontally' })
      vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Split window vertically' })
      
      -- Window closing
      vim.keymap.set('n', '<leader>wc', '<C-w>c', { desc = 'Close current window' })
      vim.keymap.set('n', '<leader>wo', '<C-w>o', { desc = 'Close other windows' })
      
      -- Window resizing
      vim.keymap.set('n', '<leader>w=', '<C-w>=', { desc = 'Make all windows equal size' })
      vim.keymap.set('n', '<leader>w>', '<C-w>10>', { desc = 'Increase window width' })
      vim.keymap.set('n', '<leader>w<', '<C-w>10<', { desc = 'Decrease window width' })
      vim.keymap.set('n', '<leader>w+', '<C-w>5+', { desc = 'Increase window height' })
      vim.keymap.set('n', '<leader>w-', '<C-w>5-', { desc = 'Decrease window height' })
      
      -- Quick window cycling
      vim.keymap.set('n', '<leader>ww', '<C-w>w', { desc = 'Cycle through windows' })
      vim.keymap.set('n', '<leader>wp', '<C-w>p', { desc = 'Go to previous window' })
      
      -- Window movement (swap windows)
      vim.keymap.set('n', '<leader>wH', '<C-w>H', { desc = 'Move window to far left' })
      vim.keymap.set('n', '<leader>wJ', '<C-w>J', { desc = 'Move window to bottom' })
      vim.keymap.set('n', '<leader>wK', '<C-w>K', { desc = 'Move window to top' })
      vim.keymap.set('n', '<leader>wL', '<C-w>L', { desc = 'Move window to far right' })
      
      -- Focus on main editing window (useful when tree view has focus)
      vim.keymap.set('n', '<leader>wf', function()
        -- Try to find a window that's not the tree view
        local wins = vim.api.nvim_list_wins()
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
          if ft ~= 'neo-tree' and ft ~= 'NvimTree' then
            vim.api.nvim_set_current_win(win)
            return
          end
        end
      end, { desc = 'Focus on main editor window' })
      
      -- Quick escape from tree view to main editor
      vim.keymap.set('n', '<Esc><Esc>', function()
        local ft = vim.bo.filetype
        if ft == 'neo-tree' or ft == 'NvimTree' then
          vim.cmd('wincmd l')  -- Move to right window
        end
      end, { desc = 'Escape from tree view to editor' })
      
      -- Buffer navigation (for switching between open files)
      vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = 'Delete buffer' })
      vim.keymap.set('n', '<leader>bf', ':bfirst<CR>', { desc = 'First buffer' })
      vim.keymap.set('n', '<leader>bl', ':blast<CR>', { desc = 'Last buffer' })
      vim.keymap.set('n', '<leader>bb', ':Telescope buffers<CR>', { desc = 'List buffers' })
      
      -- Quick buffer switching with Tab
      vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Previous buffer' })
    end
  },

  -- Command-line completion with noice.nvim (modern UI)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { pattern = "^:", icon = ":", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = "/", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "?", lang = "regex" },
          },
        },
        messages = {
          enabled = true,
          view = "mini",
          view_error = "mini",
          view_warn = "mini",
        },
        popupmenu = {
          enabled = true,
          backend = "cmp",
        },
        lsp = {
          progress = {
            enabled = false,
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },


  -- -- Codeium
  -- {
  --   'Exafunction/codeium.vim',
  --   event = 'BufEnter'
  -- },

  -- Docker support
  {
    'jamestthompson3/nvim-remote-containers',
    config = function()
      -- Remote container commands under Docker namespace
      vim.keymap.set('n', '<leader>da', ':AttachToContainer<CR>', { desc = 'Attach to Container' })
      vim.keymap.set('n', '<leader>db', ':BuildImage<CR>', { desc = 'Build Docker Image' })
      vim.keymap.set('n', '<leader>ds', ':StartImage<CR>', { desc = 'Start Docker Image' })
      
      -- Docker Compose commands for remote containers
      vim.keymap.set('n', '<leader>dCu', ':ComposeUp<CR>', { desc = 'Compose Up (Remote Containers)' })
      vim.keymap.set('n', '<leader>dCd', ':ComposeDown<CR>', { desc = 'Compose Down (Remote Containers)' })
      vim.keymap.set('n', '<leader>dCx', ':ComposeDestroy<CR>', { desc = 'Compose Destroy (Remote Containers)' })
    end
  },

  -- Docker compose and container management
  {
    'dgrbrady/nvim-docker',
    dependencies = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'},
    config = function()
      -- Docker keymaps
      vim.keymap.set('n', '<leader>dcc', ':DockerContainers<CR>', { desc = 'Docker Containers' })
      vim.keymap.set('n', '<leader>dci', ':DockerImages<CR>', { desc = 'Docker Images' })
      vim.keymap.set('n', '<leader>dcl', ':DockerContainerLogs<CR>', { desc = 'Container Logs' })
      vim.keymap.set('n', '<leader>dcs', ':DockerContainerStart<CR>', { desc = 'Start Container' })
      vim.keymap.set('n', '<leader>dcx', ':DockerContainerStop<CR>', { desc = 'Stop Container' })
      vim.keymap.set('n', '<leader>dcr', ':DockerContainerRestart<CR>', { desc = 'Restart Container' })
      vim.keymap.set('n', '<leader>dce', ':DockerContainerExec<CR>', { desc = 'Exec into Container' })
    end
  },

  -- Docker compose file support
  {
    'https://github.com/kkvh/vim-docker-tools',
    init = function()
      -- Configure docker tools to use a vertical split instead of horizontal
      vim.g.dockertools_size = vim.o.columns
    end,
    config = function()
      -- Docker tools keybindings
      vim.keymap.set('n', '<leader>do', ':DockerToolsOpen<CR>', { desc = 'Docker Tools Open' })
      vim.keymap.set('n', '<leader>dx', ':DockerToolsClose<CR>', { desc = 'Docker Tools Close' })
      
      -- Docker compose commands
      vim.keymap.set('n', '<leader>dcu', ':DockerToolsComposeUp<CR>', { desc = 'Docker Compose Up' })
      vim.keymap.set('n', '<leader>dcd', ':DockerToolsComposeDown<CR>', { desc = 'Docker Compose Down' })
      vim.keymap.set('n', '<leader>dcb', ':DockerToolsComposeBuild<CR>', { desc = 'Docker Compose Build' })
      vim.keymap.set('n', '<leader>dcr', ':DockerToolsComposeRestart<CR>', { desc = 'Docker Compose Restart' })
      
      -- Docker Volume Management
      vim.keymap.set('n', '<leader>dvl', function() 
        vim.cmd('!docker volume ls')
      end, { desc = 'List Docker Volumes' })
      
      vim.keymap.set('n', '<leader>dvi', function()
        local volume = vim.fn.input('Volume name to inspect: ')
        if volume ~= '' then
          vim.cmd('!docker volume inspect ' .. volume)
        end
      end, { desc = 'Inspect Docker Volume' })
      
      vim.keymap.set('n', '<leader>dvc', function()
        local volume = vim.fn.input('New volume name: ')
        if volume ~= '' then
          vim.cmd('!docker volume create ' .. volume)
        end
      end, { desc = 'Create Docker Volume' })
      
      vim.keymap.set('n', '<leader>dvr', function()
        local volume = vim.fn.input('Volume name to remove: ')
        if volume ~= '' then
          local confirm = vim.fn.confirm('Remove volume ' .. volume .. '?', '&Yes\n&No', 2)
          if confirm == 1 then
            vim.cmd('!docker volume rm ' .. volume)
          end
        end
      end, { desc = 'Remove Docker Volume' })
      
      vim.keymap.set('n', '<leader>dvp', function()
        vim.cmd('!docker volume prune -f')
      end, { desc = 'Prune Unused Volumes' })
      
      -- Docker Network Management
      vim.keymap.set('n', '<leader>dnl', function()
        vim.cmd('!docker network ls')
      end, { desc = 'List Docker Networks' })
      
      vim.keymap.set('n', '<leader>dni', function()
        local network = vim.fn.input('Network name to inspect: ')
        if network ~= '' then
          vim.cmd('!docker network inspect ' .. network)
        end
      end, { desc = 'Inspect Docker Network' })
      
      vim.keymap.set('n', '<leader>dnc', function()
        local network = vim.fn.input('New network name: ')
        if network ~= '' then
          local driver = vim.fn.input('Driver (bridge/overlay/host/none) [bridge]: ')
          if driver == '' then driver = 'bridge' end
          vim.cmd('!docker network create --driver ' .. driver .. ' ' .. network)
        end
      end, { desc = 'Create Docker Network' })
      
      vim.keymap.set('n', '<leader>dnr', function()
        local network = vim.fn.input('Network name to remove: ')
        if network ~= '' then
          local confirm = vim.fn.confirm('Remove network ' .. network .. '?', '&Yes\n&No', 2)
          if confirm == 1 then
            vim.cmd('!docker network rm ' .. network)
          end
        end
      end, { desc = 'Remove Docker Network' })
      
      vim.keymap.set('n', '<leader>dnp', function()
        vim.cmd('!docker network prune -f')
      end, { desc = 'Prune Unused Networks' })
      
      vim.keymap.set('n', '<leader>dnx', function()
        local container = vim.fn.input('Container name/id: ')
        if container ~= '' then
          local network = vim.fn.input('Network name: ')
          if network ~= '' then
            vim.cmd('!docker network connect ' .. network .. ' ' .. container)
          end
        end
      end, { desc = 'Connect Container to Network' })
      
      vim.keymap.set('n', '<leader>dnd', function()
        local container = vim.fn.input('Container name/id: ')
        if container ~= '' then
          local network = vim.fn.input('Network name: ')
          if network ~= '' then
            vim.cmd('!docker network disconnect ' .. network .. ' ' .. container)
          end
        end
      end, { desc = 'Disconnect Container from Network' })
    end
  },

  -- Better dockerfile syntax and features
  {
    'ekalinin/Dockerfile.vim',
  },

  -- Container log viewer
  {
    'lpoto/telescope-docker.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').load_extension('docker')
      
      -- Telescope Docker keymaps - integrated under Docker namespace
      vim.keymap.set('n', '<leader>di', '<cmd>Telescope docker images<cr>', { desc = 'Docker Images (Telescope)' })
      vim.keymap.set('n', '<leader>dc', '<cmd>Telescope docker containers<cr>', { desc = 'Docker Containers (Telescope)' })
      vim.keymap.set('n', '<leader>dN', '<cmd>Telescope docker networks<cr>', { desc = 'Docker Networks (Telescope)' })
      vim.keymap.set('n', '<leader>dV', '<cmd>Telescope docker volumes<cr>', { desc = 'Docker Volumes (Telescope)' })
      vim.keymap.set('n', '<leader>dC', '<cmd>Telescope docker compose<cr>', { desc = 'Docker Compose (Telescope)' })
    end
  },
})
