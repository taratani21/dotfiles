return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/notes/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/notes/*.md",
  },
  cmd = { "Obsidian" },
  keys = {
    { "<leader>vt", "<cmd>Obsidian today<cr>",        desc = "Today's daily note" },
    { "<leader>vy", "<cmd>Obsidian yesterday<cr>",    desc = "Yesterday's daily note" },
    { "<leader>vm", "<cmd>Obsidian tomorrow<cr>",     desc = "Tomorrow's daily note" },
    { "<leader>vd", "<cmd>Obsidian dailies<cr>",      desc = "Browse daily notes" },
    { "<leader>vn", "<cmd>Obsidian new<cr>",          desc = "New note" },
    { "<leader>vf", "<cmd>Obsidian quick_switch<cr>", desc = "Find note (by title)" },
    { "<leader>vs", "<cmd>Obsidian search<cr>",       desc = "Search vault (grep)" },
    { "<leader>vb", "<cmd>Obsidian backlinks<cr>",    desc = "Backlinks for current note" },
    { "<leader>vl", "<cmd>Obsidian follow_link<cr>",  desc = "Follow link under cursor" },
    { "<leader>vT", "<cmd>Obsidian tags<cr>",         desc = "Browse tags" },
    { "<leader>vo", "<cmd>Obsidian open<cr>",         desc = "Open in Obsidian app" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "folke/which-key.nvim",
  },
  init = function()
    -- Register the group label eagerly so which-key shows it before the plugin loads
    require("which-key").add({
      { "<leader>v", group = "Vault (Obsidian)" },
    })
  end,
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/notes",
      },
    },

    notes_subdir = "notes",
    new_notes_location = "notes_subdir",

    note_id_func = function(title)
      if title ~= nil and title ~= "" then
        local slug = title:gsub("[^%w%-_ ]", ""):gsub("%s+", "-"):lower()
        return slug .. "-" .. os.date("%Y-%m-%d")
      end
      return tostring(os.time())
    end,

    frontmatter = { enabled = false },

    note = {
      template = vim.NIL,
    },

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = nil,
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    picker = {
      name = "telescope.nvim",
    },

    ui = { enable = false },

    legacy_commands = false,

    attachments = {
      folder = "assets/imgs",
    },
  },
}
