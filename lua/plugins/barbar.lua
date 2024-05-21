return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = true end,
  version = '^1.0.0',
  config = function()
    local function is_neotree_open()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "ft") == "neo-tree" then
          return require("bufferline.api").set_offset(40, "NeoTree")
            end
       end
          return require("bufferline.api").set_offset(0)
     end

        vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWipeout" }, {
            pattern = "*",
            callback = function()
                is_neotree_open()
            end,
        })
    end,
}
