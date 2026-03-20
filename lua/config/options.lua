vim.cmd.colorscheme "catppuccin-nvim"
vim.opt.laststatus = 3

vim.opt.autoread = true
vim.opt.updatetime = 300
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    group = vim.api.nvim_create_augroup("CheckFileChanges", { clear = true }),
    callback = function()
        if vim.fn.getcmdwintype() == '' then
            vim.cmd('checktime')
        end
    end,
})
