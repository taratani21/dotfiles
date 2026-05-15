return {
  "mrjones2014/legendary.nvim",
  version = "*",
  dependencies = {
    "kkharji/sqlite.lua",
    "stevearc/dressing.nvim",
    "folke/which-key.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Legendary" },
  keys = {
    { "<leader>L", "<cmd>Legendary<cr>",          desc = "Legendary: keymaps + commands + autocmds" },
    { "<leader>lk", "<cmd>Legendary keymaps<cr>", desc = "Legendary: keymaps only" },
    { "<leader>lc", "<cmd>Legendary commands<cr>", desc = "Legendary: commands only" },
    { "<leader>la", "<cmd>Legendary autocmds<cr>", desc = "Legendary: autocmds only" },
  },
  init = function()
    require("which-key").add({
      { "<leader>L",  desc = "Legendary (all)" },
      { "<leader>lk", desc = "Legendary keymaps" },
      { "<leader>lc", desc = "Legendary commands" },
      { "<leader>la", desc = "Legendary autocmds" },
    })
  end,
  opts = {
    -- Surface keymaps, commands, and autocmds from lazy.nvim plugin specs automatically
    extensions = {
      lazy_nvim = true,
      which_key = { auto_register = true },
    },
    -- Remember most recently used items at the top
    sort = {
      most_recent_first = true,
      user_items_first = true,
    },
    -- Show command/keymap descriptions inline
    select_prompt = "Legendary",
  },
}
