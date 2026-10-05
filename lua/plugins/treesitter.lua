-- nvim-treesitter is on the `main` branch: it installs parsers, and Neovim does the
-- highlighting once vim.treesitter.start() runs for a buffer. (The old master-branch
-- `ensure_installed` / `highlight.enable` options are ignored there, which is why asm,
-- make, bash and json were never installed and C used regex highlighting.)
local languages = {
    "c", "cpp", "make", "asm", "lua", "vim", "vimdoc",
    "bash", "json", "markdown", "markdown_inline",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,            -- main does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install(languages)   -- no-op when already installed

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("duck-treesitter", { clear = true }),
            callback = function(ev)
                -- vimwiki keeps its own syntax (links, lists); render-markdown still uses the parser
                if ev.match == "vimwiki" then return end
                local lang = vim.treesitter.language.get_lang(ev.match)
                if lang and vim.tbl_contains(languages, lang) then
                    pcall(vim.treesitter.start, ev.buf, lang)
                end
            end,
        })
    end,
}
