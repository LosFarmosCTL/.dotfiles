vim.opt.signcolumn = "yes:5"

local forsen = false

return {
    forsen = function()
        vim.opt.number = forsen
    end,

    lol = {
        xd = function()
            vim.opt.relativenumber = forsen
        end,
    },
}
