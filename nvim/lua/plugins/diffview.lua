return {
    'sindrets/diffview.nvim',
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh", "DiffviewFileHistory" },
    keys = {
        { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
        { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
        {
            "<leader>dm",
            function()
                local ref = vim.fn.systemlist("git symbolic-ref --quiet --short refs/remotes/origin/HEAD")[1]
                if vim.v.shell_error ~= 0 or not ref or ref == "" then
                    ref = "origin/main"
                end
                vim.cmd("DiffviewOpen " .. ref .. "...HEAD")
            end,
            desc = "Diff origin/{base}...HEAD",
        },
        {
            "<leader>dl",
            function()
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                require("telescope.builtin").git_commits({
                    attach_mappings = function(prompt_bufnr, _)
                        actions.select_default:replace(function()
                            local entry = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            if entry and entry.value then
                                vim.cmd("DiffviewOpen " .. entry.value .. "^!")
                            end
                        end)
                        return true
                    end,
                })
            end,
            desc = "Pick commit → open diff",
        },
    },
    config = function()
        require("diffview").setup({
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                    disable_diagnostics = true,
                },
            },
        })
    end,
}
