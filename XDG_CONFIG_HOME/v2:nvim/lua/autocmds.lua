vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function (args)
    local ft = vim.bo.filetype
  end
})
