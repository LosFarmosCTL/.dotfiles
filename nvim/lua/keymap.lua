local map = vim.keymap.set

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
    end,

    lsp = {
        setup = function(client, bufnr)
            local opts = { silent = true, buffer = bufnr }

            -- TODO: keybindings for LSP
            map("n", "gD", vim.lsp.buf.declaration, opts)
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

    dial = {
        setup = function()
            -- map ({'n', 'v'}, '<C-a>', '<Plug>(dial-increment)')
            -- map ({'n', 'v'}, '<C-x>', '<Plug>(dial-decrement)')
            -- map ('v', 'g<C-a>', '<Plug>(dial-increment-additional)')
            -- map ('v', 'g<C-x>', '<Plug>(dial-decrement-additional)')
        end,
    },

    twilight = {
        setup = function()
            map("n", "<Leader>t", "<CMD>Twilight<CR>")
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

            local function map(mode, l, r, opts)
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

            map({ "n", "v" }, "<leader>hs", "<CMD>Gitsigns stage_hunk<CR>")
            map({ "n", "v" }, "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>")
            map("n", "<leader>hS", gs.stage_buffer)
            map("n", "<leader>hu", gs.undo_stage_hunk)
            map("n", "<leader>hR", gs.reset_buffer)
            map("n", "<leader>hp", gs.preview_hunk)
            map("n", "<leader>hb", function()
                gs.blame_line({ full = true })
            end)
            map("n", "<l eader>tb", gs.toggle_current_line_blame)
            map("n", "<leader>hd", gs.diffthis)
            map("n", "<leader>hD", function()
                gs.diffthis("~")
            end)
            map("n", "<leader>td", gs.toggle_deleted)

            -- Text object
            map({ "o", "x" }, "ih", "<CMD><C-U>Gitsigns select_hunk<CR>")
        end,
    },
}
