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
    --                                      ESSENTIAL                               {{{
    -----------------------------------------------------------------------------------
    use("wbthomason/packer.nvim")
    use("lewis6991/impatient.nvim")
    use("tpope/vim-repeat")
    --}}}

    --                                  UI AND NAVIGATION                           {{{
    -----------------------------------------------------------------------------------
    use({
        "projekt0n/github-nvim-theme",
        config = [[require('plugins.github-theme')]],
    })
    use({
        "nvim-lualine/lualine.nvim",
        after = "github-nvim-theme",
        requires = "kyazdani42/nvim-web-devicons",
        config = [[require('plugins.lualine')]],
    })

    use({ -- TODO: set up telescope keymaps/additional config
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "kyazdani42/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
        config = [[require('plugins.telescope')]],
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
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use({
        "numToStr/FTerm.nvim",
        config = [[require('plugins.fterm').setup()]],
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
        "folke/twilight.nvim",
        config = [[require('keymap').twilight.setup()]],
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

    use({
        "lewis6991/spellsitter.nvim",
        requires = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("spellsitter").setup()
        end,
    })
    --}}}

    --                              LSP AND AUTOCOMPLETION                          {{{
    -----------------------------------------------------------------------------------
    use({ "neovim/nvim-lspconfig", config = [[require('plugins.lspconfig')]] })
    use({ "github/copilot.vim", config = [[require('plugins.copilot')]] })
    use("L3MON4D3/LuaSnip")

    use({ "hrsh7th/nvim-cmp", config = [[require('plugins.cmp')]] })
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")
    use({"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"})
    --}}}

    --                                  VERSION CONTROL                             {{{
    -----------------------------------------------------------------------------------
    -- TODO: set up keymaps
    use("tpope/vim-fugitive")
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

    use("tpope/vim-surround")
    use({ "mizlan/iswap.nvim", config = [[require('keymap').iswap.setup()]] })

    -- use 'booperlv/nvim-gomove' TODO: figure out some usable keybindings, alt+hjkl is used by my window manager

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })
    --}}}

    if packer_bootstrap then
        require("packer").sync()
    end
end)
