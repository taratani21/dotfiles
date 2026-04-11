return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    enabled = true,
    dependencies = {
    "nvim-tree/nvim-web-devicons",
    },
    config = function()
    require("nvim-tree").setup {}
    vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
    end,
}
