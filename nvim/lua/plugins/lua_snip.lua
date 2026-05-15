return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  event = { "InsertEnter", "ModeChanged *:s" },
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")

    ls.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = false,
      -- Visual mode: press <Tab> on a selection to store it for the next snippet expansion.
      -- The selection is exposed as parent.snippet.env.LS_SELECT_DEDENT inside snippet nodes.
      store_selection_keys = "<Tab>",
    })

    -- Load friendly-snippets (VSCode-format) lazily by filetype.
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load custom snippets from ~/.config/nvim/snippets/ AFTER friendly-snippets
    -- so trigger collisions resolve in favor of our overrides.
    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath("config") .. "/snippets",
    })

    -- Filetype inheritance.
    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("typescriptreact", { "javascript", "typescript" })
    ls.filetype_extend("javascriptreact", { "javascript" })

    -- Preserve existing ruby snippets in lua/snippets/ep_snips.lua.
    pcall(require, "snippets.ep_snips")
  end,
}
