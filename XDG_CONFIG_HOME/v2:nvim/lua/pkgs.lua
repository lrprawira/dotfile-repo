return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    persistence = "persistence",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      })
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    event = "BufRead",
    config = function()
      require("auto-save").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          presets = {
            operators = false,
            motions = false,
          },
        },
        triggers_blacklist = {
        },
      })
      require("keybindings")
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    event = "BufReadPost",
    config = function()
      require("gitsigns").setup({})
    end
  },
  {
    'numToStr/Comment.nvim',
    event = "BufReadPost",
    opts = {},
    config = function()
      local config = require("Comment")
      config.setup({
        mappings = {
          basic = false,
          extra = false,
        },
      })
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    build = 'make',
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
    lazy = true,
    cmd = { "Telescope" },
    config = function()
      require('telescope')
          .load_extension('fzf')
    end
  },
  {
    'folke/trouble.nvim',
    event = "BufReadPost",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html", "python" },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
  },
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    ensure_installed = "nvim-lua/plenary.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "BufRead",
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          }
        }
      })
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require('nvim-surround').setup({
        keymaps = {
          -- insert          = '<C-g>z',
          -- insert_line     = '<C-g>Z',
          normal          = 'gz',
          normal_cur      = 'gZ',
          normal_line     = 'gzgz',
          normal_cur_line = 'gZgZ',
          visual          = 'gz',
          visual_line     = 'gZ',
          delete          = 'gzd',
          change          = 'gzr',
        }
      })
    end
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    -- event = "VeryLazy",
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, mocha, macchiato
        -- background = {
        --   light = "latte",
        --   dark = "frappe",
        -- },
        transparent_background = false,
        show_end_of_buffer = true,
        term_colors = false,
        integrations = {
          mason = true,
          leap = true,
        }
      })
    end
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    event = "BufReadPost",
    config = function()
      require("leap")
          .add_default_mappings()
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "jayp0521/mason-null-ls.nvim",
    },
    lazy = true,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = function()
      require("mason").setup({
        -- mason servers to install
        ensure_installed = {
          "lua_ls",
          "pyright",
          "blue",
          "html",
          "rome",
          "gopls",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "BufReadPost",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    -- TODO: AAAAA
    "echasnovski/mini.hipatterns",
    event = "BufReadPost",
    config = function()
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local config = require("mason-lspconfig")
      config.setup({
        automatic_installation = true
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "BufReadPost",
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
  },
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/nvim-cmp"
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig.util.default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup_handlers({
        function(server)
          require('lspconfig')[server].setup({})
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = {
                    "vim",
                  }
                },
              }
            }
          })
        end
      })
    end
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "VimEnter",
    config = function()
      local function mode()
        return '󰀘'
      end
      require('lualine').setup({
        options = {
          theme = "catppuccin",
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { 'branch' },
          lualine_c = {},
        },
      })
    end
  },
  {
    'romgrk/barbar.nvim',
    event = "VeryLazy",
    dependencies = {
      'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
      icons = {
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, },
          [vim.diagnostic.severity.WARN] = { enabled = true, },
        },
        pinned = {
          filename = true,
          button = ''
        },
      },
      sidebar_filetypes = {
        NvimTree = true,
      },
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    config = function()
      require('illuminate').configure({
        delay = 250,
      })
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "^1.3.0",
    lazy = true,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle", },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require "nvim-tree.api"
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', 'l', api.node.open.edit, opts('Toggle node'))
        end,
        update_focused_file = {
          enable = true
        }
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end,
  }
}
