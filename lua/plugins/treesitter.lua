return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "make",
        "asm",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "json",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
  },
}
