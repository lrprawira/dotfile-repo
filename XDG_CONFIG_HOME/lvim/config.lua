--[[
  THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
  `lvim` is the global options object
 ]]

-- vim options
vim.opt.expandtab = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.shell = "/bin/bash"

-- Change theme settings
lvim.colorscheme = "catppuccin"


--[[
	LunarVim Config
	]]
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = false,
	pattern = "*.lua",
	timeout = 1000,
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.use_icons = true


--[[
  Keymappings
	<https://www.lunarvim.org/docs/configuration/keybindings>
	]]

-- Examples:
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.leader = "space"

-- Buffer
lvim.builtin.which_key.mappings["c"] = {}
lvim.builtin.which_key.mappings["bc"] = { "<cmd>BufferKill<cr>", "Close Buffer" }
lvim.builtin.which_key.mappings["w"] = {}
lvim.builtin.which_key.mappings["bw"] = { "<cmd>w!<cr>", "Save Buffer" }

-- No quit on leader shortcut
lvim.builtin.which_key.mappings["q"] = {}

-- AerialToggle
lvim.builtin.which_key.mappings["A"] = { "<cmd>AerialToggle left<cr>", "aerial" }

-- AutoSave
lvim.builtin.which_key.mappings["Ln"] = { "<cmd>ASToggle<cr>", "toggle autosave" }

-- Dadbod
lvim.builtin.which_key.mappings['D'] = {
	name = "Database",
	B = { "<cmd>DBUIToggle<cr>", "Toggle database UI" },
}

-- Persistence
lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
	Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}


--[[
	TREE SITTER CONFIG
  ]]
-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }


--[[
	LSP SETUP (NVIM-LSPCONFIG)
	<https://www.lunarvim.org/docs/languages#lsp-support>
  ]]

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

-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "rome"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end


--[[
	FORMATTER SETUP (NULL-LS)
	<https://www.lunarvim.org/docs/languages#lintingformatting>
  ]]
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	timeout_ms = 3000,
	{ name = "blue",  filetypes = { "python" } },
	-- { name = "usort", filetypes = { "python" } }, # Timeout
	{ name = "djlint" },
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact" },
	},
}


--[[
	LINTER SETUP (NULL-LS)
	<https://www.lunarvim.org/docs/languages#lintingformatting>
  ]]
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
	{ name = "djlint",  filetypes = { "html", "django-html", "htmldjango" } },
	{ command = "mypy", filetypes = { "python" } },
	{
		command = "ruff",
		filetypes = { "python" },
		args = {
			-- E501 -> Line too long
			-- F403 -> Wildcard import
			-- F405 -> Use fn from wildcard import
			"--ignore=E501,F403,F405"
		}
	},
	{
		command = "shellcheck",
		args = { "--severity", "warning" },
	},
}


--[[
	LAZY PLUGINS DECLARATION
	Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
  ]]
lvim.plugins = {
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
	{
		"rmagatti/goto-preview",
		config = function()
			require('goto-preview').setup({
				width = 120,
				height = 25,
				default_mappings = false,
				debug = false,
				opacity = nil,
				post_open_hook = nil,
			})
		end
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
							['@function.outer'] = 'V', -- linewise
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
			-- 		require('nvim-surround').setup({})
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
					aerial = true
				}
			})
		end
	},
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
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end
	},
	{
		'tpope/vim-dadbod',
	},
	{
		'kristijanhusak/vim-dadbod-ui',
	},
	{
		'kristijanhusak/vim-dadbod-completion',
	},
}


--[[
	PLUGIN CONFIGURATIONS
  ]]

-- Treesitter
-- lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = { 'org' }
-- table.insert(lvim.builtin.treesitter.ensure_installed, 'org')
table.insert(lvim.builtin.treesitter.ensure_installed, 'sql')

-- Mason
lvim.builtin.mason.max_concurrent_installers = 8

-- Bufferline
lvim.builtin.bufferline.after = "catppuccin"
lvim.builtin.bufferline.options.highlight = require('catppuccin.groups.integrations.bufferline')

-- Lualine
lvim.builtin.lualine.options.theme = "catppuccin"

-- nvim-ts-rainbow
lvim.builtin.treesitter.rainbow.enable = true

-- toggleterm
lvim.builtin.terminal.on_config_done = nil


--[[
	Autocommands
	(`:help autocmd`)
	<https://neovim.io/doc/user/autocmd.html>
  ]]
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
