-- Prose: soft-wrap long lines at word boundaries (code keeps the global nowrap).
-- The file is not changed; lines only wrap on screen, so half-width splits stay readable.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true     -- break at spaces, not mid-word
vim.opt_local.breakindent = true   -- wrapped list items keep their indent
vim.opt_local.colorcolumn = ""

-- j/k move by screen line inside a wrapped paragraph; counts (5j) still use real lines.
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { buffer = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { buffer = true, expr = true })
