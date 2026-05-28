return {
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cmd = { 'Files', 'Buffers', 'Lines', 'BLines', 'History', 'Commits', 'BCommits', 'Rg', },
    config = function()
      -- layout padrão (opcional)
      vim.g.fzf_layout = { down = '40%' }
    end,
  },
}
