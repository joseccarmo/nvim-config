-- ~/study/nvim: the study dashboard, auto-check on save (quickfix + diagnostics),
-- lesson/notes/wiki as ordinary buffers. :Study, :h study
-- Personal plugin: only loads on machines that have ~/study/nvim.
return {
    dir = "~/study/nvim",
    name = "study.nvim",
    cond = vim.fn.isdirectory(vim.fn.expand("~/study/nvim")) == 1,
    lazy = false,
    config = function()
        require("study").setup({})
    end,
}
