return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
    vim.o.ttimeoutlen = 10
  end,
  opts = {}
}
