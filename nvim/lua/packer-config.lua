-- install packer if its not present
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

require("packer").startup(function(use)
    --                                      CORE                               {{{
    -----------------------------------------------------------------------------------
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")
    use("tpope/vim-repeat")
    --}}}

    --                                  UI AND NAVIGATION                           {{{
    -----------------------------------------------------------------------------------
    use({
        "folke/tokyonight.nvim",
        config = [[require('plugins.tokyonight')]],
    })

    use({
        "nvim-lualine/lualine.nvim",
        after = "tokyonight.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require('plugins.lualine')]],
    })

    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "kyazdani42/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        config = [[require('plugins.telescope')]],
    })

    use({
        "stevearc/dressing.nvim",
        config = [[require('plugins.dressing')]],
    })

    use("rcarriga/nvim-notify")

    use({
        "kevinhwang91/nvim-hlslens",
        config = [[require('keymap').hlslens.setup()]],
    })

    use({
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    })
    use({
        "petertriho/nvim-scrollbar",
        config = [[require('plugins.scrollbar')]],
    })

    use({
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup()
        end,
    })

    use("ggandor/lightspeed.nvim")

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    use({
        "kosayoda/nvim-lightbulb",
        requires = "antoinemadec/FixCursorHold.nvim",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = {
                    enabled = true,
                },
            })
        end,
    })

    use({
        "numToStr/FTerm.nvim",
        config = [[require('plugins.fterm').setup()]],
    })

    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    })

    use({
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup()
            require("keymap").goto_preview.setup()
        end,
    })

    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup()
            require("keymap").trouble.setup()
        end,
    })

    use({
        "sidebar-nvim/sidebar.nvim",
        config = [[require('plugins.sidebar')]],
    })
    --}}}

    --                              SYNTAX/CODE HIGHLIGHTING                        {{{
    -----------------------------------------------------------------------------------
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = [[require('plugins.treesitter')]],
    })
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-textobjects")

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = [[require('plugins.indent-blankline')]],
    })

    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    })

    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    use({
        "haringsrob/nvim_context_vt",
        requires = "nvim-treesitter/nvim-treesitter",
        config = [[require('plugins.context_vt')]],
    })

    -- TODO: remove spellsitter, merged into nvim core starting with 0.8
    use({
        "lewis6991/spellsitter.nvim",
        requires = "nvim-treesitter/nvim-treesitter",
        config = [[require('plugins.spellsitter')]],
    })

    use({
        "RRethy/vim-illuminate",
        config = [[require('plugins.illuminate')]],
    })
    --}}}

    --                              LSP AND AUTOCOMPLETION                          {{{
    -----------------------------------------------------------------------------------
    use({ "neovim/nvim-lspconfig", config = [[require('plugins.lspconfig')]] })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = [[require('plugins.null-ls')]],
        requires = "nvim-lua/plenary.nvim",
    })

    use({ "github/copilot.vim", config = [[require('plugins.copilot')]] })

    -- TODO: actually set up anything and don't just have it installed for cmp
    use("L3MON4D3/LuaSnip")

    use({
        "lukas-reineke/lsp-format.nvim",
        config = [[require('plugins.lsp-format')]],
    })

    use({ "hrsh7th/nvim-cmp", config = [[require('plugins.cmp')]] })
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")
    use({ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" })

    use("onsails/lspkind-nvim")

    use("folke/lua-dev.nvim")

    use({
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup()
        end,
    })
    --}}}

    --                                  VERSION CONTROL                             {{{
    -----------------------------------------------------------------------------------
    use({
        "tpope/vim-fugitive",
        config = [[require("keymap").fugitive.setup()]],
    })
    use("tpope/vim-rhubarb")

    use({
        "lewis6991/gitsigns.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = [[require('plugins.gitsigns')]],
    })
    --}}}

    --                                    EDITING                                   {{{
    -----------------------------------------------------------------------------------
    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = [[require('plugins.autopairs')]],
    })

    use({
        "windwp/nvim-ts-autotag",
        requires = "nvim-treesitter",
        config = [[require('nvim-ts-autotag').setup()]],
    })

    use("tpope/vim-surround")
    use({ "mizlan/iswap.nvim", config = [[require('keymap').iswap.setup()]] })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "julian/vim-textobj-variable-segment",
        requires = "kana/vim-textobj-user",
    })
    --}}}

    --                                    MISCELLANEOUS                                   {{{
    -----------------------------------------------------------------------------------
    use({
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup()
        end,
    })

    use("andweeb/presence.nvim")
    --}}}

    if packer_bootstrap then
        require("packer").sync()
    end
end)
