return {
  'vimwiki/vimwiki',
  init = function()
    vim.g.vimwiki_path = '~/vimwiki/'
    vim.g.vimwiki_syntax = 'markdown'
    vim.g.vimwiki_ext = 'md'
    -- Diary template handles date heading, no need for auto_header
    -- Use markdown treesitter parser for vimwiki filetype
    vim.treesitter.language.register('markdown', 'vimwiki')
  end,
  config = function()
    -- Insert diary template on new diary entries
    vim.api.nvim_create_autocmd('BufNewFile', {
      pattern = '*/diary/*.md',
      callback = function()
        local template = vim.fn.expand('~/vimwiki/templates/diary-template.md')
        local lines = {}
        for line in io.lines(template) do
          local processed = line:gsub('{{date}}', os.date('%B %d, %Y'))
          table.insert(lines, processed)
        end
        vim.api.nvim_buf_set_lines(0, 0, math.max(#lines, 1), false, lines)
      end,
    })
  end,
}
