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
  "g%", -- cycle backwards through results (?)
  "gf", -- goto file under cursor
  "gi", -- move to last insert then get into insert mode
  "gv", -- move to last insert then get into visual mode
  "gn", -- search forward then select
  "gN", -- search backwards then select
  "gt", -- goto next tab
  "gT", -- goto previous tab
}, "")

wk.register({
  ["/"] = {
    "<Plug>(comment_toggle_linewise_current)", "Toggle comment for current line"
  },
  e = {
    "<Cmd>NvimTreeToggle<CR>", "Open NvimTree"
  },
  f = {
    "<Cmd>Telescope fd<CR>", "Find File"
  },
  c = {
    name = "Code",
    h = { "<Cmd>nohlsearch<CR>", "Remove highlights" },
  },
  b = {
    name = "Buffer",
    n = { "<Cmd>BufferNext<CR>", "Next Buffer" },
    p = { "<Cmd>BufferPrevious<CR>", "Previous Buffer" },
    c = { "<Cmd>BufferClose<CR>", "Close Buffer" },
    x = { "<Cmd>BufferCloseAllButPinned<CR>", "Close All Buffers" },
    ["'"] = { "<Cmd>BufferPin<CR>", "Pin Buffer" },
    f = { "<Cmd>Telescope buffers<CR>", "Find Buffer" },
    r = { "<Cmd>redraw<CR>", "Redraw Buffer" },
  },
  g = {
    name = "Git",
    g = { "<Cmd>LazyGit<CR>", "LazyGit" },
    l = { "<Cmd>lua require 'gitsigns'.blame_line()<CR>", "Git blame line"},
    L = { "<Cmd>lua require 'gitsigns'.blame_line({full=true})<CR>", "Git blame line (full)"},
  },
  l = {
    game = "LSP",
    f = { "<Cmd>lua vim.lsp.buf.format()<CR>", "Format" },
    j = { "<Cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
    k = { "<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Next diagnostic" },
  },
  L = {
    name = "Editor",
    ch = {
      name = "Check health",
      t = { "<Cmd>checkhealth telescope<CR>", "Telescope" },
    },
    cc = { "<Cmd>edit $HOME/.config/nvim/init.lua<CR>", "Open config init.lua", }
  },
}, { prefix = "<leader>" })
wk.register({
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggle comment for the selected block" }
}, { prefix = "<leader>", mode = "v" })
wk.register({
  r = { "<Cmd>lua require('telescope.builtin').lsp.references<CR>", "Show references" },
}, { prefix = "g", mode = "n" })

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Down>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Up>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>')
