return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        -- Also render in Vimwiki buffers (filetype: vimwiki, not markdown)
        file_types = { 'markdown', 'rmd', 'vimwiki' },
        -- Headings: full-width background, nerd font icons per level
        heading = {
            enabled = true,
            sign    = true,
            icons   = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
            width   = 'full',
        },

        -- Code blocks: full background so they visually pop
        code = {
            enabled   = true,
            sign      = false,
            style     = 'full',
            width     = 'full',
            left_pad  = 2,
            right_pad = 2,
        },

        -- Bullets: distinct icons per nesting level
        bullet = {
            enabled = true,
            icons   = { '●', '○', '◆', '◇' },
        },

        -- Checkboxes
        checkbox = {
            enabled   = true,
            unchecked = { icon = '󰄱 ' },
            checked   = { icon = '󰱒 ' },
        },

        -- Horizontal rules: full-width divider
        dash = {
            enabled = true,
            icon    = '─',
            width   = 'full',
        },

        -- Blockquotes
        quote = {
            enabled = true,
            icon    = '▋',
        },

        -- Tables: rounded borders, padded cells
        pipe_table = {
            enabled = true,
            preset  = 'round',
            style   = 'full',
            cell    = 'padded',
        },

        -- Links with icons
        link = {
            enabled    = true,
            image      = '󰥶 ',
            email      = '󰀓 ',
            hyperlink  = '󰌹 ',
        },

        -- Sign column
        sign = {
            enabled = true,
        },
    },
}
