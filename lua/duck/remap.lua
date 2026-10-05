vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore)

-- window navigation with Alt
vim.keymap.set('n', '<A-q>', function()
    vim.cmd('silent! close')
end, { silent = true })

-- Format keymap (<leader>fm)
vim.keymap.set({ "n", "v" }, "<leader>fm", function()
    require("conform").format({
        async = true,
        lsp_fallback = true,
    })
end, { desc = "Format file or range" })




vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')

-- Alt+Shift+h/j/k/l: move the current window in that direction, like SUPER+SHIFT+h/j/k/l
-- in Hyprland. Into a neighbouring column (or row) it joins it, after the neighbour:
--   lesson | exercise + asm  --(asm, Alt+Shift+h)-->  lesson + asm | exercise
-- Within its own column (or row) it swaps places with the neighbour. At the edge it
-- becomes a full-height column (or full-width row) on that side. The window itself moves,
-- so its options (wrap, winbar) and cursor come with it.
local function parent_of(tree, id, parent)
    if tree[1] == 'leaf' then return tree[2] == id and parent or nil end
    for _, child in ipairs(tree[2]) do
        local found = parent_of(child, id, tree)
        if found then return found end
    end
end

local function move_window(dir)
    local cur = vim.api.nvim_get_current_win()
    local target = vim.fn.win_getid(vim.fn.winnr(dir))
    local horizontal = dir == 'h' or dir == 'l'          -- moving across columns
    if target == 0 or target == cur then
        local parent = parent_of(vim.fn.winlayout(), cur)
        if parent then vim.cmd('wincmd ' .. dir:upper()) end   -- at the edge: own column/row
        return
    end
    local parent = parent_of(vim.fn.winlayout(), cur)
    local siblings = false
    if parent and parent[1] == (horizontal and 'row' or 'col') then
        for _, child in ipairs(parent[2]) do
            if child[1] == 'leaf' and child[2] == target then siblings = true end
        end
    end
    if siblings then   -- same column/row: take the neighbour's side of it
        vim.fn.win_splitmove(cur, target, { vertical = horizontal, rightbelow = dir == 'l' or dir == 'j' })
    else               -- another column/row: join it, after the neighbour
        vim.fn.win_splitmove(cur, target, { vertical = not horizontal, rightbelow = true })
    end
    vim.api.nvim_set_current_win(cur)
end
for key, dir in pairs({ H = 'h', J = 'j', K = 'k', L = 'l' }) do
    vim.keymap.set('n', '<A-' .. key .. '>', function() move_window(dir) end, { desc = 'move window ' .. dir })
end

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>lt", function()
    vim.cmd [[ PlenaryBustedFile % ]]
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
