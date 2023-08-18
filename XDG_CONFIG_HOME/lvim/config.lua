--[[
  THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
  `lvim` is the global options object
 ]]
-- vim options
-- vim.opt.expandtab = true
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
lvim.colorscheme = "catppuccin"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
require("lvim.lsp.manager").setup("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
})
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "rome"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
-- local formatters = require "lvim.lsp.null-ls.formatters"
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "blue",  filetypes = { "python" } },
  { name = "djlint" },
}
-- formatters.setup {
--   { command = "stylua" },
--   {
--     command = "prettier",
--     extra_args = { "--print-width", "100" },
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
-- local linters = require "lvim.lsp.null-ls.linters"
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "djlint", filetypes = { "html", "django-html", "htmldjango" } },
}
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  -- {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  -- },
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
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    event = "BufRead",
    config = function()
      require("auto-save").setup()
    end,
  },
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "WinScrolled",
  --   config = function()
  --     require('neoscroll').setup({
  --       -- All these keys will be mapped to their corresponding default scrolling animation
  --       mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
  --         '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
  --       hide_cursor = true,          -- Hide cursor while scrolling
  --       stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  --       use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
  --       respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  --       cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  --       easing_function = nil,       -- Default easing function
  --       pre_hook = nil,              -- Function to run before the scrolling animation starts
  --       post_hook = nil,             -- Function to run after the scrolling animation ends
  --     })
  --   end
  -- },
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
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, mocha, macchiato
        -- background = {
        --   light = "latte",
        --   dark = "frappe",
        -- },
        -- transparent_background: false,
        show_end_of_buffer = true,
        term_colors = false,
        integrations = {
          aerial = true
        }
      })
    end
  },
  -- {
  --   "RRethy/nvim-base16",
  --   priority = 1000,
  -- },
  -- {
  --   "wfxr/minimap.vim",
  --   config = function()
  --     vim.cmd("let g:minimap_width = 10")
  --     vim.cmd("let g:minimap_auto_start = 1")
  --     vim.cmd("let g:minimap_auto_start_win_enter = 1")
  --   end
  -- },
  {
    "windwp/nvim-ts-autotag",
    event = "BufRead",
    config = function()
      require("nvim-ts-autotag").setup()
    end
  },
  {
    "mrjones2014/nvim-ts-rainbow",
    event = "BufReadPost",
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require('colorizer').setup()
    end
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll", "AerialNavOpen", "AerialNavToggle" },
    config = function()
      require('aerial').setup({
        layout = {
          min_width = 20,
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    name = "leap",
    config = function()
      require("leap")
          .add_default_mappings()
      -- require("leap")
      --     .add_repeat_mappings(';', ',', {
      --       relative_directions = true,
      --       modes = { 'n', 'x', 'o' },
      --     })
    end,
  },
  -- {
  --   "ggandor/flit.nvim",
  --   name = "flit",
  --   dependencies = { "leap" },
  --   config = function()
  --     require("flit").setup({
  --       labeled_modes = "nvo",
  --     })
  --   end
  -- },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end
  },
  {
    "nvim-orgmode/orgmode",
    config = function()
      local orgmode = require('orgmode')
      orgmode.setup()
      orgmode.setup_ts_grammar()
    end
  },
}

--
-- Custom plugin configurations
--

-- Treesitter org-mode
lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = { 'org' }
table.insert(lvim.builtin.treesitter.ensure_installed, 'org')
-- Mason
lvim.builtin.mason.max_concurrent_installers = 8
-- nvim-lspconfig
-- lvim.lsp
-- nvim-cmp
-- lvim.keys.insert_mode["<C-@>"] = "<C-Space>"
-- lvim.builtin.cmp.sources = { {} }
-- Persistence
lvim.builtin.which_key.mappings["S"] = {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
-- Bufferline
lvim.builtin.bufferline.after = "catppuccin"
lvim.builtin.bufferline.options.highlight = require('catppuccin.groups.integrations.bufferline')
-- Lualine
lvim.builtin.lualine.options.theme = "catppuccin"
-- Buffer
lvim.builtin.which_key.mappings["c"] = {}
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferKill<cr>", "Close Buffer" }
lvim.builtin.which_key.mappings["w"] = {}
lvim.builtin.which_key.mappings["bw"] = { "<cmd>w!<cr>", "Save Buffer" }
-- TroubleToggle
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "Diagnostics",
--   t = { "<cmd>TroubleToggle<cr>", "trouble" },
--   w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
--   d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
--   q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
--   l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
--   r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
-- }
-- AerialToggle
lvim.builtin.which_key.mappings["A"] = { "<cmd>AerialToggle left<cr>", "aerial" }
-- lvim.builtin.which_key.mappings["A"] = {
--   name = "Aerial Outline",
--   t = { "<cmd>AerialToggle left<CR>", "aerial" }
-- }
-- AutoSave
lvim.builtin.which_key.mappings["n"] = { "<cmd>ASToggle<cr>", "toggle autosave" }
-- nvim-ts-rainbow
lvim.builtin.treesitter.rainbow.enable = true
-- toggleterm
lvim.builtin.terminal.on_config_done = nil

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
