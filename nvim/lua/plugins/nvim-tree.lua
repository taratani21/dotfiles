return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    enabled = true,
    dependencies = {
    "nvim-tree/nvim-web-devicons",
    },
    config = function()
    require("nvim-tree").setup {
      update_focused_file = {
        enable = true,
      },
      filters = {
        git_ignored = false,
      },
    }
    vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
    end,
}
