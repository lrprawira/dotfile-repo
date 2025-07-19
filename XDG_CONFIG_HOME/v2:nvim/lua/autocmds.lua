vim.api.nvim_create_autocmd('BufReadPre', {
  callback = function (args)
    local ft = vim.bo.filetype
  end
})

-- Workaround uv__is_closing assertion error
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.cmd("!notify-send ''")
    vim.cmd("sleep 10m")
  end,
})
