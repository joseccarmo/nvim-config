require("duck.remap")
require("duck.set")

-- netrw settings
vim.g.netrw_banner = 1
vim.g.netrw_preview = 1   -- enable preview mode (p key)
vim.g.netrw_altv = 1      -- use vertical split instead of horizontal
vim.g.netrw_winsize = 30   -- width of preview window
vim.g.netrw_browse_split = 0  -- open files in vertical split (right)

-- Set cursor shape for different modes
vim.opt.guicursor = table.concat({
    "n-v-c:block",   -- normal, visual, command: block
    "i-ci-ve:ver25", -- insert, insert command-line, visual: vertical bar, 25% width
    "r-cr:hor20",    -- replace / virtual replace: horizontal bar, 20% height
    "o:hor50",       -- operator-pending: horizontal bar, 50% height
}, ",")
