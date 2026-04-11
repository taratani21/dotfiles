return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "bash",
        "fish",
        "go",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "vim",
        "yaml",
        "swift",
        "typescript",
        "tsx",
        "javascript",
        "css",
      })
    end,
}
