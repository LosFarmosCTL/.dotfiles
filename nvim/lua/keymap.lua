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
            map("n", "gd", vim.lsp.buf.definition, opts)
            map("n", "gi", vim.lsp.buf.implementation, opts)
            map("n", "gr", vim.lsp.buf.references, opts)

            map("n", "K", vim.lsp.buf.hover, opts)

            map("n", "<leader>rn", vim.lsp.buf.rename, opts)
            map("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            map("n", "<leader>f", vim.lsp.buf.format, opts)
        end,
    },

    telescope = {
        setup = function()
            map("n", "<Leader>e", "<CMD>Telescope find_files<CR>", silent)
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

    outline = {
        setup = function()
            map("n", "<Leader>o", "<CMD>SymbolsOutline<CR>", silent)
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
}
