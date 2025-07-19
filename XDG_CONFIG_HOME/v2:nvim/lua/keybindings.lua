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
  "gri", -- vim.lsp.buf.implementation()
  "gra", -- vim.lsp.buf.code_action()
  "grr", -- vim.lsp.buf.references()
  "grn", -- vim.lsp.buf.rename()
  "gc", -- toggle comment
  "gcc", -- toggle comment line
}, "")

wk.register({
  ["/"] = {
    "<Cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment for current line"
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
    l = { "<Cmd>lua require('gitsigns').blame_line()<CR>", "Git blame line"},
    L = { "<Cmd>lua require('gitsigns').blame_line({full=true})<CR>", "Git blame line (full)"},
  },
  l = {
    game = "LSP",
    f = { "<Cmd>lua vim.lsp.buf.format()<CR>", "Format" },
    j = { "<Cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic" },
    k = { "<Cmd>lua vim.diagnostic.goto_prev()<CR>", "Next diagnostic" },
    s = { "<Cmd>lua vim.diagnostic."}
  },
  [';'] = {
    name = "Editor",
    ch = {
      name = "Check health",
      t = { "<Cmd>checkhealth telescope<CR>", "Telescope" },
    },
    cc = { "<Cmd>edit $HOME/.config/nvim/init.lua<CR>", "Open config init.lua", },
    cs = { "<Cmd>lua require('telescope.builtin').colorscheme({ enable_preview = true })<CR>", "Show colorscheme options" }
  },
  S = {
    name = "Session",
    c = { "<Cmd>lua require('persistence').load()<CR>", "Restore last session for current dir" },
    l = { "<Cmd>lua require('persistence').load({ last = true })<CR>", "Restore last session" },
    q = { "<Cmd>quitall<CR>", "Quit session"},
    Q = { "<Cmd>lua require('persistence').stop()<CR>", "Quit without saving session" },
  },
}, { prefix = "<leader>" })

wk.register({
  -- ["/"] = { "<Cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment for the selected block" }
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)<CR>", "Toggle comment for the selected block" },
}, { prefix = "<leader>", mode = "v" })

wk.register({
  r = { "<Cmd>lua require('telescope.builtin').lsp_references({})<CR>", "Show references" },
  d = { "<Cmd>lua require('telescope.builtin').lsp_definitions({})<CR>", "Show definitions"},
  s = { "<Cmd>lua require('telescope.builtin').lsp_document_symbols({})<CR>", "Show document symbols"},
}, { prefix = "g", mode = "n" })

-- Pane management
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Down>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Up>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>')

-- Toggleterm
vim.keymap.set('n', '<M-3>', '<Cmd>ToggleTerm direction=float<CR>')
vim.keymap.set('n', '<M-2>', '<Cmd>ToggleTerm direction=vertical size=80<CR>')
vim.keymap.set('n', '<M-1>', '<Cmd>ToggleTerm direction=horizontal size=20<CR>')
vim.keymap.set('t', '<M-3>', '<Cmd>ToggleTerm direction=float<CR>')
vim.keymap.set('t', '<M-2>', '<Cmd>ToggleTerm direction=vertical size=80<CR>')
vim.keymap.set('t', '<M-1>', '<Cmd>ToggleTerm direction=horizontal size=20<CR>')
-- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- Keep selection upon shifts
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

