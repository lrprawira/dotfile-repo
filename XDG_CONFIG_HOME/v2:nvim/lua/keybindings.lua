local wk = require("which-key")

local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
  if msg:match("which%-key") and level == vim.log.levels.WARN then
    return
  end
  orig_notify(msg, level, opts)
end

local function deregister(mappings, prefix, mode)
  local all_mappings = {}
  for _, lhs in ipairs(mappings) do
    local mapping = (prefix or "<leader>") .. lhs
    pcall(vim.api.nvim_del_keymap, mode or "n", mapping)
    all_mappings[mapping] = "which_key_ignore"
  end
  wk.register(all_mappings)
end

deregister({
  "g%",  -- cycle backwards through results (?)
  "gf",  -- goto file under cursor
  "gi",  -- move to last insert then get into insert mode
  "gv",  -- move to last insert then get into visual mode
  "gn",  -- search forward then select
  "gN",  -- search backwards then select
  "gt",  -- goto next tab
  "gT",  -- goto previous tab
  "gri", -- vim.lsp.buf.implementation()
  "gra", -- vim.lsp.buf.code_action()
  "grr", -- vim.lsp.buf.references()
  "grn", -- vim.lsp.buf.rename()
  "gc",  -- toggle comment
  "gcc", -- toggle comment line
  "gO",  -- document symbols
}, "")

wk.add({
  -- Comment
  { [[<leader>/]], function() require('Comment.api').toggle.linewise.current() end, desc = "Toggle comment for current line", },
  -- Explorer
  { [[<leader>e]], "<Cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree", icon = { icon = "", }, },
  -- Find file by name
  { [[<leader>f]], "<Cmd>Telescope fd<CR>", desc = "Find File", },
  -- Code
  { [[<leader>c]], group = "Code", },
  { [[<leader>ch]], "<Cmd>nohlsearch<CR>", desc = "Remove highlights", },
  { [[<leader>cs]], group = "Search" },
  { [[<leader>cst]], "<Cmd>Telescope live_grep<CR>", desc = "Text in project" },
  -- Buffer
  { [[<leader>b]], group = "Buffer" },
  { [[<leader>bn]], "<Cmd>BufferNext<CR>", desc = "Next buffer" },
  { [[<leader>bp]], "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
  { [[<leader>bc]], "<Cmd>BufferClose<CR>", desc = "Close buffer" },
  { [[<leader>bC]], "<Cmd>BufferClose!<CR>", desc = "Force close buffer" },
  { [[<leader>bx]], "<Cmd>BufferCloseAllButPinned<CR>", desc = "Close all buffers" },
  { [[<leader>bX]], "<Cmd>BufferCloseAllButPinned!<CR>", desc = "Force close all buffers" },
  { [[<leader>b']], "<Cmd>BufferPin<CR>", desc = "Pin buffer" },
  { [[<leader>bf]], "<Cmd>Telescope buffers<CR>", desc = "Find buffer" },
  { [[<leader>br]], "<Cmd>redraw<CR>", desc = "Redraw buffer" },
  -- Git
  { [[<leader>g]], group = "Git" },
  { [[<leader>gg]], "<Cmd>LazyGit<CR>", desc = "LazyGit" },
  { [[<leader>gl]], function() require('gitsigns').blame_line() end, desc = "LazyGit" },
  { [[<leader>gL]], function() require('gitsigns').blame_line({full=true}) end, desc = "LazyGit" },
  -- LSP
  { [[<leader>l]], group = "LSP", icon = { icon = "" } },
  { [[<leader>lf]], function() vim.lsp.buf.format() end, desc = "Format" },
  { [[<leader>lj]], function() vim.diagnostic.jump({ count=1, float=true }) end, desc = "Next diagnostic" },
  { [[<leader>lk]], function() vim.diagnostic.jump({ count=-1, float=true }) end, desc = "Previous diagnostic" },
  { [[<leader>ls]], function() require('telescope.builtin').diagnostics({bufnr = 0}) end, desc = "Show buffer diagnostics" },
  -- Editor
  { [[<leader>;]], group = "Editor", icon = { icon = "󰢱" } },
  { [[<leader>;ch]], group = "Check health" },
  { [[<leader>;cha]], "<Cmd>checkhealth<CR>", desc = "All" },
  { [[<leader>;cht]], "<Cmd>checkhealth telescope<CR>", desc = "Telescope" },
  { [[<leader>;cc]], "<Cmd>edit $HOME/.config/nvim/init.lua<CR>", desc = "Open config init.lua" },
  { [[<leader>;cs]], function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, desc = "Show colourscheme options" },
  -- Session
  { [[<leader>S]], group = "Session" },
  { [[<leader>Sc]], function() require("persistence").load() end, desc = "Restore last session for current dir" },
  { [[<leader>Sl]], function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
  { [[<leader>Sq]], "<Cmd>quitall<CR>", desc = "Quit session" },
  { [[<leader>SQ]], function() require("persistence").stop() end, desc = "Quit without saving session" },

  --
  mode = {"n"},
})

wk.add({
  -- Comment
  -- ["/"] = { "<Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment for the selected block" }
  { [[/]], "<Plug>(comment_toggle_linewise_visual)<CR>", desc = "Toggle comment for the selected block" },
  mode = {"v"},
})

-- For doing things in the context of current line
wk.add({
  { [[gr]], function() require("telescope.builtin").lsp_references({}) end, desc = "Show references" },
  { [[gd]], function() require("telescope.builtin").lsp_definitions({}) end, desc = "Show definitions" },
  { [[gs]], function() require("telescope.builtin").lsp_document_symbols({}) end, desc = "Show document symbols" },
  { [[gl]], function() vim.diagnostic.open_float() end, desc = "Show line diagnostics" },
  mode = {"n"},
})

-- Pane management
vim.keymap.set({ 'n', 't' }, [[<C-h>]], [[<C-\><C-n><C-w>h]])
vim.keymap.set({ 'n', 't' }, [[<C-j>]], [[<C-\><C-n><C-w>j]])
vim.keymap.set({ 'n', 't' }, [[<C-k>]], [[<C-\><C-n><C-w>k]])
vim.keymap.set({ 'n', 't' }, [[<C-l>]], [[<C-\><C-n><C-w>l]])
vim.keymap.set({ 'n', 't' }, [[<C-Left>]], [[<Cmd>vertical resize -2<CR>]])
vim.keymap.set({ 'n', 't' }, [[<C-Down>]], [[<Cmd>resize +2<CR>]])
vim.keymap.set({ 'n', 't' }, [[<C-Up>]], [[<Cmd>resize -2<CR>]])
vim.keymap.set({ 'n', 't' }, [[<C-Right>]], [[<Cmd>vertical resize +2<CR>]])

-- Toggleterm
vim.keymap.set({ 'n', 't' }, '<M-3>', '<Cmd>ToggleTerm direction=float<CR>')
vim.keymap.set({ 'n', 't' }, '<M-2>', '<Cmd>ToggleTerm direction=vertical size=80<CR>')
vim.keymap.set({ 'n', 't' }, '<M-1>', '<Cmd>ToggleTerm direction=horizontal size=20<CR>')
-- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- Keep selection upon shifts
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
