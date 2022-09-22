local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    vim.keymap.set(mode, lhs, rhs, opts)
end

local silent = { silent = true }

return {
    setup = function()
        -- use space as the leader key
        map("n", "<SPACE>", "<Nop>")
        vim.g.mapleader = " "

        -- remap saving a file to something faster
        map("n", "<Leader>w", ":w<CR>")

        -- set up shortcuts for copy/paste/cut to system clipboard
        map("n", "<Leader>Y", '"+Y')
        map("n", "<Leader>D", '"+D')
        map({ "n", "v" }, "<Leader>y", '"+y')
        map({ "n", "v" }, "<Leader>d", '"+d')

        map({ "n", "v" }, "<Leader>p", '"+p')
        map({ "n", "v" }, "<Leader>P", '"+P')

        -- clear search highlights
        -- HACK: for some reason hlslens requires to use : instead of <CMD> or it doesn't get cleared immediately
        map("n", "<Leader>l", ":nohlsearch<CR>", silent)

        -- quickly start search+replace
        map("n", "<C-/>", ":%s/")

        map("n", "<Leader>q", ":bdelete<CR>", silent)
    end,

    lsp = {
        setup = function(client, bufnr)
            local opts = { silent = true, buffer = bufnr }

            map("n", "gD", vim.lsp.buf.declaration, opts)
            map("n", "gr", "<CMD>Trouble lsp_references<CR>", silent)
            map("n", "gd", "<CMD>Trouble lsp_definitions<CR>", silent)
            map("n", "gi", "<CMD>Trouble lsp_implementations<CR>", silent)

            map("n", "K", vim.lsp.buf.hover, opts)

            map("n", "<leader>rn", vim.lsp.buf.rename, opts)
            map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            map("n", "<leader>f", vim.lsp.buf.format, opts)
        end,
    },

    goto_preview = {
        setup = function()
            map(
                "n",
                "gpd",
                require("goto-preview").goto_preview_definition,
                silent
            )
            map(
                "n",
                "gpi",
                require("goto-preview").goto_preview_implementation,
                silent
            )
            map(
                "n",
                "gpr",
                require("goto-preview").goto_preview_references,
                silent
            )
            map("n", "gP", require("goto-preview").close_all_win, silent)
        end,
    },

    telescope = {
        setup = function()
            map("n", "<Leader>e", "<CMD>Telescope find_files<CR>", silent)
            map("n", "<leader><leader>e", "<CMD>Telescope projects<CR>", silent)
            map("n", "<leader>ge", "<CMD>Telescope git_files<CR>", silent)

            map("n", "<leader>tg", "<CMD>Telescope live_grep<CR>", silent)
            map("n", "<leader>tb", "<CMD>Telescope buffers<CR>", silent)
            map("n", "<leader>th", "<CMD>Telescope help_tags<CR>", silent)
            map("n", "<leader>tc", "<CMD>Telescope command_history<CR>", silent)
            map("n", "<leader>ts", "<CMD>Telescope spell_suggest<CR>", silent)

            map("n", "<leader>gl", "<CMD>Telescope git_commits<CR>", silent)
            map("n", "<leader>gL", "<CMD>Telescope git_bcommits<CR>", silent)
            map("n", "<leader>tgb", "<CMD>Telescope git_branches<CR>", silent)

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
                        },
                        n = {
                            ["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
                        },
                    },
                },
            })
        end,
    },

    fterm = {
        setup = function()
            map("n", "<Leader>//", require("FTerm").toggle)
            map("n", "<Leader>/b", require("plugins.fterm").spawn_btop)
        end,
    },

    iswap = {
        setup = function()
            map("n", "<Leader>s", "<CMD>ISwapWith<CR>", silent)
            map("n", "<Leader>S", "<CMD>ISwap<CR>")
        end,
    },

    hlslens = {
        setup = function()
            map(
                "n",
                "n",
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]]
            )
            map(
                "n",
                "N",
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]]
            )
            map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]])
            map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]])
            map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]])
            map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]])
        end,
    },

    gitsigns = {
        setup = function(bufnr)
            local gs = package.loaded.gitsigns

            function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true })

            map("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true })

            map({ "n", "v" }, "<leader>gs", "<CMD>Gitsigns stage_hunk<CR>")
            map({ "n", "v" }, "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>")
            map("n", "<leader>gu", gs.undo_stage_hunk)

            map("n", "<leader>gS", gs.stage_buffer)
            map("n", "<leader>gR", gs.reset_buffer)

            map("n", "<leader>gK", gs.preview_hunk)
            map("n", "<leader>gd", gs.diffthis)
            map("n", "<leader>gD", function()
                gs.diffthis("~")
            end)

            map("n", "<leader>gb", function()
                gs.blame_line({ full = true })
            end)

            map("n", "<leader>gtb", gs.toggle_current_line_blame)
            map("n", "<leader>gtd", gs.toggle_deleted)
        end,
    },

    -- TODO: look into the more advanced git navigation features in fugitive
    fugitive = {
        setup = function()
            map("n", "<Leader>gB", "<CMD>Git blame<CR>", silent)
            map("n", "<Leader>gl", "<CMD>Git log<CR>", silent)

            map("n", "<Leader>gG", "<CMD>Gread<CR>", silent) -- git checkout -- filename

            map("n", "<Leader>gc", "<CMD>Git commit<CR>", silent)
            map("n", "<Leader>gp", "<CMD>Git push<CR>", silent)
            map("n", "<Leader>gP", "<CMD>Git pull<CR>", silent)

            map("n", "<Leader>gM", "<CMD>GRename ", silent)

            map("n", "<Leader>gm", "<CMD>Gvdiffsplit!<CR>", silent) -- start 3-way diff for merge

            map("n", "<Leader>gH", "<CMD>GBrowse<CR>", silent)
        end,
    },

    trouble = {
        setup = function()
            map("n", "<Leader>tq", "<CMD>TroubleClose<CR>", silent)
            map(
                "n",
                "<Leader>td",
                "<CMD>Trouble workspace_diagnostics<CR>",
                silent
            )
            map("n", "<Leader>tt", "<CMD>Trouble todo<CR>", silent)
        end,
    },

    sidebar = {
        setup = function()
            map("n", "<leader>o", "<CMD>SidebarNvimToggle<CR>", silent)
        end,
    },
}
