-- ~/.config/nvim/lua/plugins/notes.lua
-- Project-scoped daily notes

local notes_dir = vim.fn.expand("~/.notes")

local function get_project()
  local toplevel = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error == 0 and toplevel and toplevel ~= "" then
    return vim.fn.fnamemodify(toplevel, ":t")
  end
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function get_daily_path()
  local project = get_project()
  local date = os.date("%Y-%m-%d")
  return notes_dir .. "/" .. project .. "/" .. date .. ".md"
end

local function quick_note()
  vim.ui.input({ prompt = "Note: " }, function(input)
    if not input or input == "" then
      return
    end
    local path = get_daily_path()
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    local time = os.date("%H:%M")
    local line = "- " .. time .. " — " .. input .. "\n"
    local f = io.open(path, "a")
    f:write(line)
    f:close()
    print("Note saved")
  end)
end

local function open_daily()
  local path = get_daily_path()
  vim.cmd("botright split " .. vim.fn.fnameescape(path))
end

return {
  dir = ".",
  name = "notes",
  config = function()
    vim.keymap.set("n", "<leader>jn", quick_note, { desc = "Quick note" })
    vim.keymap.set("n", "<leader>jo", open_daily, { desc = "Open daily notes" })
  end,
}
