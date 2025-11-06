return {
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { 'Files', 'Buffers', 'Lines', 'BLines', 'History', 'Commits', 'BCommits' },   cmd = { 'Files', 'Buffers', 'Lines', 'BLines', 'History', 'Commits', 'BCommits' },
    config = function()
      -- layout padrão (opcional)
      vim.g.fzf_layout = { down = '40%' }
    end,
  },
}
