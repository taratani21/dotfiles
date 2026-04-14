return {
    dir = '/root/projects/nvim-claude',
    name = 'nvim-claude',
    lazy = false,
    config = function()
        require('nvim-claude').setup({})
    end,
    keys = {
        { '<leader>cf', '<cmd>ClaudeSendFile<cr>',      desc = 'Claude: send file' },
        { '<leader>cv', ':ClaudeSendSelection<cr>',     mode = 'v', desc = 'Claude: send selection' },
        { '<leader>cn', '<cmd>ClaudeSendLine<cr>',      desc = 'Claude: send line (+diagnostics)' },
        { '<leader>co', '<cmd>ClaudeFocus<cr>',         desc = 'Claude: focus pane' },
        { '<leader>ct', '<cmd>ClaudeAttach<cr>',        desc = 'Claude: attach pane' },
        { '<leader>cw', '<cmd>ClaudeWatch<cr>',         desc = 'Claude: watch events' },
        { '<leader>cp', '<cmd>ClaudePreviewHunk<cr>',   desc = 'Claude: preview hunk' },
        { '<leader>cr', '<cmd>ClaudeReview<cr>',        desc = 'Claude: review panel' },
        { '<leader>cd', '<cmd>ClaudeDiffFile<cr>',      desc = 'Claude: diff file vs snapshot' },
        { ']h',         '<cmd>ClaudeNextHunk<cr>',      desc = 'Next claude hunk' },
        { '[h',         '<cmd>ClaudePrevHunk<cr>',      desc = 'Prev claude hunk' },
    },
}
