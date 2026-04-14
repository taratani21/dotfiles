return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      markdown = { "prettier" },
      go = { "gofmt" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
  },
}
