-- LSP
return {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Keymaps on LspAttach
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
                end
                map("gd", vim.lsp.buf.definition, "Go to definition")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("gr", vim.lsp.buf.references, "Go to references")
                map("gI", vim.lsp.buf.implementation, "Go to implementation")
                map("gy", vim.lsp.buf.type_definition, "Go to type definition")
                map("K", vim.lsp.buf.hover, "Hover docs")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map("gs", vim.lsp.buf.signature_help, "Signature help")

                -- Show diagnostics on CursorHold
                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = ev.buf,
                    callback = function()
                        vim.diagnostic.open_float(nil, {
                            focusable = false,
                            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                            border = 'rounded',
                            source = 'always',
                            prefix = ' ',
                            scope = 'cursor',
                        })
                    end
                })
            end,
        })

        -- Mason auto-installs servers
        require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
                -- Default handler for all servers
                function(server_name)
                    vim.lsp.config(server_name, {
                        capabilities = capabilities,
                    })
                    vim.lsp.enable(server_name)
                end,
                -- Custom lua_ls config for neovim dev
                lua_ls = function()
                    vim.lsp.config('lua_ls', {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = 'LuaJIT' },
                                workspace = {
                                    checkThirdParty = false,
                                    library = { vim.env.VIMRUNTIME },
                                },
                            },
                        },
                    })
                    vim.lsp.enable('lua_ls')
                end,
            }
        })

        -- Custom LSP servers
        vim.lsp.config('expert', {
            cmd = { "expert", "--stdio" },
            filetypes = { "elixir", "eelixir", "heex" },
            root_markers = { "mix.exs", ".git" },
        })
        vim.lsp.enable('expert')

        vim.lsp.config('tailwindcss', {
            capabilities = capabilities,
            filetypes = {
                "css", "scss", "sass", "postcss", "html",
                "javascript", "javascriptreact",
                "typescript", "typescriptreact",
                "svelte", "vue", "rust", "astro", "nextjs",
            },
            init_options = {
                userLanguages = { rust = "html" },
            },
            on_attach = function(_, bufnr)
                require("tailwindcss-colors").buf_attach(bufnr)
            end,
        })

        -- Completion
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-y>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-l>'] = function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end,
                ['<C-h>'] = function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end,
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'orgmode' },
            }, {
                { name = 'buffer' },
            }),
        })
    end
}
