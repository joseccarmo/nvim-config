return {
  'mattn/calendar-vim',
  init = function()
    -- Open calendar with F3
    vim.keymap.set('n', '<F3>', ':Calendar<CR>', { desc = 'Open calendar' })
  end,
}
